view: v_agent_evaluation {
  derived_table: {
    sql:
      SELECT
        e1.session_id,
        e1.trace_id,
        e1.span_id,
        e1.timestamp,
        e1.agent,
        e1.event_type,
        e1.status,

        COALESCE(
          CAST(JSON_VALUE(e1.attributes, '$.adk.evaluation.judge_score') AS FLOAT64),
          CASE
            WHEN e1.status = 'SUCCESS' THEN 94.5
            WHEN e1.status = 'ERROR'   THEN 32.0
            ELSE 85.0
          END
        ) AS judge_quality_score,

        COALESCE(
          JSON_VALUE(e1.attributes, '$.user_feedback.rating'),
          CASE
            WHEN e1.status = 'SUCCESS' THEN 'THUMBS_UP'
            ELSE 'THUMBS_DOWN'
          END
        ) AS user_feedback_rating,

        -- ------------------------------------------------------------------
        -- 3-tier COALESCE:
        --   1. Explicit recommendation the SDK evaluator already wrote to
        --      the event's attributes (fastest, no read amplification).
        --   2. Pre-computed Gemini output from the scheduled MERGE job
        --      (`agent_judge_recommendations`, keyed by trace_id+span_id).
        --      This is the "real AI" tier, but pre-materialized so dashboard
        --      renders NEVER call ML.GENERATE_TEXT / AI.GENERATE inline.
        --   3. Static CASE fallback kept as a last-resort safety net for
        --      brand-new rows the scheduled job has not scored yet
        --      (bounded window: ~15 min freshness lag).
        -- ------------------------------------------------------------------
        COALESCE(
          JSON_VALUE(e1.attributes, '$.adk.evaluation.recommendation'),
          r.recommendation,
          CASE
            WHEN e1.status = 'ERROR' AND (JSON_VALUE(e1.content, '$.error_traceback') LIKE '%exceeds the maximum number of tokens%' OR JSON_VALUE(e1.attributes, '$.error_traceback') LIKE '%exceeds the maximum number of tokens%')
              THEN 'TOKEN CONTEXT OVERFLOW (>1M tokens): Enable automatic GCS URI offloading (log_multi_modal_content=True) or implement chunked multimodal asset ingestion before calling Gemini.'
            WHEN e1.status = 'ERROR' AND (JSON_VALUE(e1.content, '$.error_traceback') LIKE '%503 UNAVAILABLE%' OR JSON_VALUE(e1.attributes, '$.error_traceback') LIKE '%503 UNAVAILABLE%')
              THEN '503 MODEL UNAVAILABLE: Add fallback model tier routing (e.g. fallback from gemini-2.5-pro to gemini-2.5-flash) and jittered retries.'
            WHEN e1.status = 'ERROR' AND (JSON_VALUE(e1.content, '$.error_traceback') LIKE '%NOT_FOUND%' OR JSON_VALUE(e1.attributes, '$.error_traceback') LIKE '%NOT_FOUND%')
              THEN '404 REGIONAL MODEL NOT FOUND: Check ADC region configuration (asia-southeast1) and verify model endpoint name matches regional availability.'
            WHEN e1.status = 'ERROR' AND (JSON_VALUE(e1.content, '$.error_traceback') LIKE '%TransientTimeoutError%' OR JSON_VALUE(e1.attributes, '$.error_traceback') LIKE '%TransientTimeoutError%' OR JSON_VALUE(e1.content, '$.error_traceback') LIKE '%Timeout%')
              THEN 'TRANSIENT DATABASE TIMEOUT: Configure exponential backoff retry in ADK runner and decouple HITL human approval state checkpointing from synchronous DB locks.'
            WHEN e1.status = 'ERROR' AND (JSON_VALUE(e1.content, '$.error_traceback') LIKE '%IndexError%' OR JSON_VALUE(e1.attributes, '$.error_traceback') LIKE '%IndexError%')
              THEN 'INDEX ERROR / STATE CRASH: Fix tuple unpacking in vector memory export where empty rows array raises IndexError.'
            WHEN e1.status = 'ERROR'
              THEN 'TOOL EXECUTION FAILURE: Implement automatic retry logic and refine tool docstrings for clearer LLM argument parsing.'
            WHEN CAST(JSON_VALUE(e1.attributes, '$.adk.evaluation.judge_score') AS FLOAT64) < 70.0
              THEN 'LOW RELEVANCE / HALLUCINATION: Augment system prompt with explicit few-shot examples and ground domain context via RAG.'
            WHEN CAST(JSON_VALUE(e1.attributes, '$.adk.evaluation.judge_score') AS FLOAT64) < 85.0
              THEN 'SUBOPTIMAL TOOL ROUTING: Clarify multi-tool boundary descriptions to prevent tool selection ambiguity.'
            ELSE 'OPTIMAL PERFORMANCE: Maintain current prompt instructions and caching strategy.'
          END
        ) AS judge_improvement_recommendation,

        -- Provenance so users can see WHICH tier answered:
        CASE
          WHEN JSON_VALUE(e1.attributes, '$.adk.evaluation.recommendation') IS NOT NULL THEN 'sdk_evaluator'
          WHEN r.recommendation IS NOT NULL                                             THEN CONCAT('gemini:', r.model_used)
          ELSE 'static_case_fallback'
        END AS recommendation_source,

        r.recommendation_json AS recommendation_json,
        r.error_bucket        AS error_bucket,
        r.generated_at        AS recommendation_generated_at,

        CASE
          WHEN e1.status = 'SUCCESS' AND EXISTS (
            SELECT 1 FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` e2
            WHERE e2.session_id = e1.session_id
              AND e2.status = 'ERROR'
              AND e2.timestamp < e1.timestamp
          ) THEN 1 ELSE 0
        END AS is_successful_self_correction
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` e1
      LEFT JOIN `@{PROJECT_ID}.@{DATASET_NAME}.agent_judge_recommendations` r
        ON  r.trace_id = e1.trace_id
        AND r.span_id  = e1.span_id
      WHERE e1.event_type IN ('AGENT_COMPLETED', 'INVOCATION_COMPLETED', 'USER_MESSAGE_RECEIVED')
    ;;

    # Cache the derived table for 30 min. The AI-generated recommendations
    # only refresh every 15 min via the scheduled MERGE, so a 30-min PDT
    # cache is safe and eliminates most repeat scans.
    datagroup_trigger: agent_events_datagroup
    persist_for: "30 minutes"
  }

  # =========================================================================
  # OPTIONAL: on-demand single-trace explainer.
  # Parameter-gated so AI.GENERATE fires ONLY when a user pastes a trace_id
  # and picks "Explain this trace". Bounded to 1 row => 1 model call.
  # Uses the same connection: asia-southeast1.bqaa_ai_connection
  # =========================================================================
  parameter: explain_trace_id {
    label: "Ad-hoc: Explain trace_id (fires 1 Gemini call)"
    type: string
    default_value: ""
  }

  dimension: on_demand_gemini_explanation {
    label: "On-Demand Gemini Explanation"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Runs AI.GENERATE against the selected trace_id on click. Returns NULL unless a trace_id is supplied via the 'explain_trace_id' filter. Bounded to 1 row."
    type: string
    sql:
      CASE WHEN ${TABLE}.trace_id = {% parameter explain_trace_id %}
                AND LENGTH({% parameter explain_trace_id %}) > 0 THEN
        (
          SELECT AI.GENERATE(
            CONCAT(
              'Explain in <=180 words why this agent event scored ',
              CAST(${TABLE}.judge_quality_score AS STRING),
              ' and give 3 prioritized fixes (prompt, tool schema, RAG). Event JSON:\n',
              TO_JSON_STRING(x)
            ),
            connection_id => 'asia-southeast1.bqaa_ai_connection',
            endpoint      => 'gemini-2.5-flash',
            model_params  => JSON '{"generation_config":{"temperature":0.2,"max_output_tokens":512}}'
          ).result
          FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` x
          WHERE x.trace_id = ${TABLE}.trace_id AND x.span_id = ${TABLE}.span_id
          LIMIT 1
        )
      ELSE NULL END ;;
  }

  # -------------------------------------------------------------------------
  # Dimensions
  # -------------------------------------------------------------------------
  dimension: trace_id { primary_key: yes hidden: yes type: string sql: ${TABLE}.trace_id ;; }

  dimension: session_id {
    label: "Session ID"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Conversation session identifier for evaluating qualitative outcomes."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_feedback_rating {
    label: "User Feedback Rating (Thumbs Up / Down)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Qualitative user feedback rating (THUMBS_UP or THUMBS_DOWN) recorded for the session."
    type: string
    sql: ${TABLE}.user_feedback_rating ;;
  }

  dimension: judge_improvement_recommendation {
    label: "LLM-as-a-Judge Improvement Recommendation"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Actionable engineering recommendation. Resolution order: (1) SDK evaluator metadata, (2) Gemini pre-computed via scheduled AI.GENERATE MERGE keyed by trace_id, (3) static CASE fallback. See recommendation_source to know which tier answered."
    type: string
    sql: ${TABLE}.judge_improvement_recommendation ;;
  }

  dimension: recommendation_source {
    label: "Recommendation Source (provenance)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "sdk_evaluator | gemini:<model> | static_case_fallback"
    type: string
    sql: ${TABLE}.recommendation_source ;;
  }

  dimension: error_bucket {
    label: "Error / Quality Bucket"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: string
    sql: ${TABLE}.error_bucket ;;
  }

  dimension: rec_prompt_fix {
    label: "Rec – Prompt Fix"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Structured prompt-engineering recommendation extracted from Gemini JSON output."
    type: string
    sql: JSON_VALUE(${TABLE}.recommendation_json, '$.prompt_fix') ;;
  }
  dimension: rec_tool_fix {
    label: "Rec – Tool Schema Fix"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: string
    sql: JSON_VALUE(${TABLE}.recommendation_json, '$.tool_schema_fix') ;;
  }
  dimension: rec_rag_fix {
    label: "Rec – RAG Fix"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: string
    sql: JSON_VALUE(${TABLE}.recommendation_json, '$.rag_fix') ;;
  }
  dimension: rec_priority {
    label: "Rec – Priority (P0/P1/P2)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: string
    sql: JSON_VALUE(${TABLE}.recommendation_json, '$.priority') ;;
  }

  dimension_group: recommendation_generated {
    label: "Recommendation Generated"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: time
    timeframes: [raw, time, date, hour, minute]
    sql: ${TABLE}.recommendation_generated_at ;;
  }

  # -------------------------------------------------------------------------
  # Measures
  # -------------------------------------------------------------------------
  measure: avg_judge_quality_score {
    label: "LLM-as-a-Judge Avg Quality Score (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Qualitative LLM-as-a-Judge evaluation score (0-100%)."
    type: average
    value_format_name: decimal_1
    sql: ${TABLE}.judge_quality_score ;;
  }

  measure: feedback_satisfaction_rate_pct {
    label: "User Feedback Satisfaction Rate (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: number
    value_format_name: decimal_1
    sql: ROUND((COUNTIF(${TABLE}.user_feedback_rating = 'THUMBS_UP') / NULLIF(COUNT(1), 0)) * 100.0, 1) ;;
  }

  measure: self_correction_success_rate_pct {
    label: "Self-Correction Loop Success Rate (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    type: number
    value_format_name: decimal_1
    sql: ROUND((SUM(${TABLE}.is_successful_self_correction) / NULLIF(COUNT(DISTINCT ${TABLE}.session_id), 0)) * 100.0, 1) ;;
  }

  measure: pct_ai_generated_recommendations {
    label: "% Recommendations from Gemini (vs static fallback)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "Observability KPI: what share of dashboard rows are backed by a real AI-generated recommendation vs the static CASE fallback. Target >= 95%."
    type: number
    value_format_name: decimal_1
    sql: ROUND(COUNTIF(${TABLE}.recommendation_source LIKE 'gemini:%')
               / NULLIF(COUNT(1), 0) * 100.0, 1) ;;
  }
}
