-- ============================================================================
-- 02_build_judge_recommendations_table.sql
-- ----------------------------------------------------------------------------
-- Incrementally MERGE Gemini-generated prompt/tool/RAG recommendations into
-- `${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations`, keyed by trace_id+span_id.
--
-- PARAMETERS (replaced automatically by scripts/setup_all.sh):
--   ${PROJECT_ID}      : Target Google Cloud project
--   ${DATASET_NAME}    : BigQuery dataset (e.g. agent_analytics)
--   ${LOCATION}        : BigQuery region (e.g. asia-southeast1)
--   ${CONNECTION_NAME} : BigQuery Cloud Resource Connection name
--
-- Schedule via BigQuery Scheduled Queries (e.g. every 15 min) OR Cloud
-- Composer / Workflows.
-- ============================================================================

-- One-time DDL (idempotent). Partition by day, cluster for join locality.
CREATE TABLE IF NOT EXISTS `${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations`
(
  trace_id                STRING NOT NULL,
  span_id                 STRING NOT NULL,
  session_id              STRING,
  event_timestamp         TIMESTAMP,
  judge_score             FLOAT64,
  error_bucket            STRING,        -- TIMEOUT | SCHEMA | TOOL_EXEC | HALLUCINATION | ROUTING | OPTIMAL
  recommendation          STRING,        -- Gemini output (customized)
  recommendation_json     JSON,          -- structured: {prompt_fix, tool_fix, rag_fix, priority}
  model_used              STRING,
  input_tokens            INT64,
  output_tokens           INT64,
  generated_at            TIMESTAMP,
  source_fingerprint      STRING         -- SHA256 of inputs to detect drift & re-gen
)
PARTITION BY DATE(event_timestamp)
CLUSTER BY trace_id, span_id;

-- ----------------------------------------------------------------------------
-- MERGE: only score rows that (a) are new, or (b) whose input fingerprint
-- changed since last generation. Keep the AI call bounded to <= N rows
-- per run so cost is predictable.
-- ----------------------------------------------------------------------------
MERGE `${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations` T
USING (
  WITH candidates AS (
    SELECT
      e.trace_id,
      e.span_id,
      e.session_id,
      e.timestamp                                                          AS event_timestamp,
      e.status,
      e.event_type,
      JSON_VALUE(e.attributes, '$.tool_name')                              AS tool_name,
      JSON_VALUE(e.attributes, '$.content')                                AS content,
      JSON_VALUE(e.attributes, '$.error_traceback')                        AS error_traceback,
      SAFE_CAST(JSON_VALUE(e.attributes, '$.usage.prompt_tokens')     AS INT64) AS prompt_tokens,
      SAFE_CAST(JSON_VALUE(e.attributes, '$.usage.completion_tokens') AS INT64) AS completion_tokens,
      SAFE_CAST(JSON_VALUE(e.attributes, '$.adk.evaluation.judge_score') AS FLOAT64) AS judge_score,
      CASE
        WHEN e.status = 'ERROR' AND (JSON_VALUE(e.content, '$.error_traceback') LIKE '%exceeds the maximum number of tokens%' OR JSON_VALUE(e.attributes, '$.error_traceback') LIKE '%exceeds the maximum number of tokens%')
          THEN 'TOKEN_OVERFLOW'
        WHEN e.status = 'ERROR' AND (JSON_VALUE(e.content, '$.error_traceback') LIKE '%503 UNAVAILABLE%' OR JSON_VALUE(e.attributes, '$.error_traceback') LIKE '%503 UNAVAILABLE%')
          THEN 'MODEL_UNAVAILABLE'
        WHEN e.status = 'ERROR' AND (JSON_VALUE(e.content, '$.error_traceback') LIKE '%NOT_FOUND%' OR JSON_VALUE(e.attributes, '$.error_traceback') LIKE '%NOT_FOUND%')
          THEN 'MODEL_NOT_FOUND'
        WHEN e.status = 'ERROR' AND (JSON_VALUE(e.content, '$.error_traceback') LIKE '%TransientTimeoutError%' OR JSON_VALUE(e.attributes, '$.error_traceback') LIKE '%TransientTimeoutError%' OR JSON_VALUE(e.content, '$.error_traceback') LIKE '%Timeout%')
          THEN 'TIMEOUT'
        WHEN e.status = 'ERROR' AND (JSON_VALUE(e.content, '$.error_traceback') LIKE '%IndexError%' OR JSON_VALUE(e.attributes, '$.error_traceback') LIKE '%IndexError%')
          THEN 'STATE_INDEX_ERROR'
        WHEN e.status = 'ERROR' AND JSON_VALUE(e.content,'$.error_traceback') LIKE '%JSON%'
          THEN 'SCHEMA'
        WHEN e.status = 'ERROR'
          THEN 'TOOL_EXEC'
        WHEN SAFE_CAST(JSON_VALUE(e.attributes,'$.adk.evaluation.judge_score') AS FLOAT64) < 70
          THEN 'HALLUCINATION'
        WHEN SAFE_CAST(JSON_VALUE(e.attributes,'$.adk.evaluation.judge_score') AS FLOAT64) < 85
          THEN 'ROUTING'
        WHEN SAFE_CAST(JSON_VALUE(e.attributes,'$.usage.prompt_tokens') AS INT64) > 2000 OR SAFE_CAST(JSON_VALUE(e.attributes,'$.usage_prompt_tokens') AS INT64) > 2000
          THEN 'FINOPS_TOKEN_OPT'
        ELSE 'BEST_PRACTICE_REINFORCEMENT'
      END AS error_bucket,
      TO_HEX(SHA256(CONCAT(
        IFNULL(e.status,''), '|',
        IFNULL(JSON_VALUE(e.attributes,'$.tool_name'),''), '|',
        IFNULL(SUBSTR(JSON_VALUE(e.attributes,'$.content'), 1, 2000),''), '|',
        IFNULL(SUBSTR(JSON_VALUE(e.attributes,'$.error_traceback'), 1, 2000),'')
      ))) AS source_fingerprint
    FROM `${PROJECT_ID}.${DATASET_NAME}.agent_events` e
    WHERE e.event_type IN ('AGENT_COMPLETED','INVOCATION_COMPLETED','AGENT_ERROR','INVOCATION_ERROR','TOOL_ERROR','LLM_ERROR')
      AND e.timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
  ),
  needs_generation AS (
    SELECT c.*
    FROM candidates c
    LEFT JOIN `${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations` r
      ON r.trace_id = c.trace_id AND r.span_id = c.span_id
    WHERE (r.trace_id IS NULL OR r.source_fingerprint <> c.source_fingerprint)
    ORDER BY
      CASE c.error_bucket WHEN 'TIMEOUT' THEN 1 WHEN 'SCHEMA' THEN 2 WHEN 'TOOL_EXEC' THEN 3
                          WHEN 'HALLUCINATION' THEN 4 WHEN 'ROUTING' THEN 5 WHEN 'FINOPS_TOKEN_OPT' THEN 6 ELSE 9 END,
      c.judge_score ASC
    LIMIT 100
  ),
  scored AS (
    SELECT
      n.*,
      AI.GENERATE(
        CONCAT(
          'You are a senior Google Cloud PSO JAPAC LLM-as-a-Judge and Reliability Engineer. ',
          'Evaluate this agent interaction on a 0-100 quality scale across Faithfulness/Grounding (<70 if hallucinating facts), ',
          'Tool Routing (<85 if ambiguous/wrong tool), and Goal Completion. ',
          'Return a JSON object with keys: ',
          'judge_score (0-100 integer), category (HALLUCINATION, ROUTING, TOOL_EXEC, TIMEOUT, TOKEN_OVERFLOW, MODEL_NOT_FOUND, OPTIMAL), ',
          'priority (P0, P1, P2), prompt_fix, tool_schema_fix, rag_fix, one_liner. ',
          'Base score and recommendations ONLY on the evidence below. Do not invent tool names. ',
          'status: ',       IFNULL(n.status,'NULL'), ' ',
          'tool_name: ',    IFNULL(n.tool_name,'NULL'), ' ',
          'existing_score: ', IFNULL(CAST(n.judge_score AS STRING),'NULL'), ' ',
          'prompt_tokens: ', IFNULL(CAST(n.prompt_tokens AS STRING),'NULL'),
          ' completion_tokens: ', IFNULL(CAST(n.completion_tokens AS STRING),'NULL'), ' ',
          '--- content (truncated) --- ',
          SUBSTR(IFNULL(n.content,''), 1, 4000), ' ',
          '--- error_traceback (truncated) --- ',
          SUBSTR(IFNULL(n.error_traceback,''), 1, 4000)
        ),
        connection_id => '${LOCATION}.${CONNECTION_NAME}',
        endpoint      => 'gemini-2.5-flash',
        model_params  => JSON '{"generation_config":{"temperature":0.2,"response_mime_type":"application/json","max_output_tokens":512}}'
      ) AS ai
    FROM needs_generation n
  )
  SELECT
    trace_id, span_id, session_id, event_timestamp,
    COALESCE(
      judge_score,
      SAFE_CAST(JSON_VALUE(ai.result, '$.judge_score') AS FLOAT64),
      IF(status = 'ERROR', 32.0, 94.5)
    ) AS judge_score,
    COALESCE(
      JSON_VALUE(ai.result, '$.category'),
      error_bucket
    ) AS error_bucket,
    ai.result                           AS recommendation,
    SAFE.PARSE_JSON(ai.result)          AS recommendation_json,
    'gemini-2.5-flash'                  AS model_used,
    SAFE_CAST(JSON_VALUE(ai.full_response,'$.usageMetadata.promptTokenCount') AS INT64)     AS input_tokens,
    SAFE_CAST(JSON_VALUE(ai.full_response,'$.usageMetadata.candidatesTokenCount') AS INT64) AS output_tokens,
    CURRENT_TIMESTAMP() AS generated_at,
    source_fingerprint
  FROM scored
  WHERE ai.status IS NULL OR ai.status = ''
) S
ON T.trace_id = S.trace_id AND T.span_id = S.span_id
WHEN MATCHED THEN UPDATE SET
  session_id          = S.session_id,
  event_timestamp     = S.event_timestamp,
  judge_score         = S.judge_score,
  error_bucket        = S.error_bucket,
  recommendation      = S.recommendation,
  recommendation_json = S.recommendation_json,
  model_used          = S.model_used,
  input_tokens        = S.input_tokens,
  output_tokens       = S.output_tokens,
  generated_at        = S.generated_at,
  source_fingerprint  = S.source_fingerprint
WHEN NOT MATCHED THEN INSERT ROW;
