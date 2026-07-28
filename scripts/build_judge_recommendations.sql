-- ============================================================================
-- build_judge_recommendations.sql
-- ----------------------------------------------------------------------------
-- Incrementally MERGE Gemini-generated prompt/tool/RAG recommendations into
-- `agent_analytics.agent_judge_recommendations`, keyed by trace_id+span_id.
--
-- Schedule via BigQuery Scheduled Queries (e.g. every 15 min) OR Cloud
-- Composer / Workflows. NEVER call inside a LookML derived_table on every
-- dashboard render — see v_agent_evaluation.view.lkml (COALESCE + LEFT JOIN).
--
-- Uses AI.GENERATE (GA) with the existing Cloud Resource Connection:
--     asia-southeast1.bqaa_ai_connection
--
-- Model selection:
--   Use `gemini-2.5-flash` (fast + cheap; recommendation text ~200 tokens).
--   Bump to `gemini-2.5-pro` only for rows where judge_score < 60 (deep RCA).
-- ============================================================================

-- One-time DDL (idempotent). Partition by day, cluster for join locality.
CREATE TABLE IF NOT EXISTS `nikunjbhartia-test-clients.agent_analytics.agent_judge_recommendations`
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
DECLARE max_rows_per_run INT64 DEFAULT 500;

MERGE `nikunjbhartia-test-clients.agent_analytics.agent_judge_recommendations` T
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
      -- Coarse bucket used both as a filter and as a hint to the model:
      CASE
        WHEN e.status = 'ERROR' AND JSON_VALUE(e.attributes,'$.error_traceback') LIKE '%Timeout%'      THEN 'TIMEOUT'
        WHEN e.status = 'ERROR' AND JSON_VALUE(e.attributes,'$.error_traceback') LIKE '%JSON%'         THEN 'SCHEMA'
        WHEN e.status = 'ERROR'                                                                        THEN 'TOOL_EXEC'
        WHEN SAFE_CAST(JSON_VALUE(e.attributes,'$.adk.evaluation.judge_score') AS FLOAT64) < 70        THEN 'HALLUCINATION'
        WHEN SAFE_CAST(JSON_VALUE(e.attributes,'$.adk.evaluation.judge_score') AS FLOAT64) < 85        THEN 'ROUTING'
        ELSE 'OPTIMAL'
      END AS error_bucket,
      TO_HEX(SHA256(CONCAT(
        IFNULL(e.status,''), '|',
        IFNULL(JSON_VALUE(e.attributes,'$.tool_name'),''), '|',
        IFNULL(SUBSTR(JSON_VALUE(e.attributes,'$.content'), 1, 2000),''), '|',
        IFNULL(SUBSTR(JSON_VALUE(e.attributes,'$.error_traceback'), 1, 2000),'')
      ))) AS source_fingerprint
    FROM `nikunjbhartia-test-clients.agent_analytics.agent_events` e
    WHERE e.event_type IN ('AGENT_COMPLETED','INVOCATION_COMPLETED')
      AND e.timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 DAY)
  ),
  -- Skip OPTIMAL rows: the static string is fine and Gemini would waste tokens.
  needs_generation AS (
    SELECT c.*
    FROM candidates c
    LEFT JOIN `nikunjbhartia-test-clients.agent_analytics.agent_judge_recommendations` r
      ON r.trace_id = c.trace_id AND r.span_id = c.span_id
    WHERE c.error_bucket <> 'OPTIMAL'
      AND (r.trace_id IS NULL OR r.source_fingerprint <> c.source_fingerprint)
    ORDER BY  -- prioritize worst outcomes first if we hit the budget cap
      CASE c.error_bucket WHEN 'TIMEOUT' THEN 1 WHEN 'SCHEMA' THEN 2 WHEN 'TOOL_EXEC' THEN 3
                          WHEN 'HALLUCINATION' THEN 4 WHEN 'ROUTING' THEN 5 ELSE 9 END,
      c.judge_score ASC
    LIMIT max_rows_per_run
  ),
  scored AS (
    SELECT
      n.*,
      -- AI.GENERATE returns STRUCT<result STRING, full_response JSON, status STRING>
      AI.GENERATE(
        CONCAT(
          'You are a senior LLM/agent reliability engineer at Google Cloud PSO JAPAC. ',
          'Given ONE production agent event, return a JSON object with keys ',
          '{"priority":"P0|P1|P2","prompt_fix":"…","tool_schema_fix":"…","rag_fix":"…","one_liner":"…"}. ',
          'Base recommendations ONLY on the evidence below; do not invent tool names. ',
          'Keep each field <= 240 chars. Be concrete (name the exact instruction to add, ',
          'the JSON field to validate, the retrieval index/filter to add).\n\n',
          'error_bucket: ', n.error_bucket, '\n',
          'status: ',       IFNULL(n.status,'NULL'), '\n',
          'tool_name: ',    IFNULL(n.tool_name,'NULL'), '\n',
          'judge_score: ',  IFNULL(CAST(n.judge_score AS STRING),'NULL'), '\n',
          'prompt_tokens: ', IFNULL(CAST(n.prompt_tokens AS STRING),'NULL'),
          '  completion_tokens: ', IFNULL(CAST(n.completion_tokens AS STRING),'NULL'), '\n',
          '--- content (truncated) ---\n',
          SUBSTR(IFNULL(n.content,''), 1, 4000), '\n',
          '--- error_traceback (truncated) ---\n',
          SUBSTR(IFNULL(n.error_traceback,''), 1, 4000)
        ),
        connection_id => 'asia-southeast1.bqaa_ai_connection',
        endpoint      => IF(n.judge_score < 60 OR n.error_bucket IN ('TIMEOUT','SCHEMA'),
                            'gemini-2.5-pro', 'gemini-2.5-flash'),
        model_params  => JSON '{"generation_config":{"temperature":0.2,"response_mime_type":"application/json","max_output_tokens":512}}'
      ) AS ai
    FROM needs_generation n
  )
  SELECT
    trace_id, span_id, session_id, event_timestamp, judge_score, error_bucket,
    ai.result                           AS recommendation,
    SAFE.PARSE_JSON(ai.result)          AS recommendation_json,
    IF(judge_score < 60 OR error_bucket IN ('TIMEOUT','SCHEMA'),
       'gemini-2.5-pro','gemini-2.5-flash') AS model_used,
    SAFE_CAST(JSON_VALUE(ai.full_response,'$.usageMetadata.promptTokenCount') AS INT64)     AS input_tokens,
    SAFE_CAST(JSON_VALUE(ai.full_response,'$.usageMetadata.candidatesTokenCount') AS INT64) AS output_tokens,
    CURRENT_TIMESTAMP() AS generated_at,
    source_fingerprint
  FROM scored
  WHERE ai.status IS NULL OR ai.status = ''  -- keep only successful generations
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
