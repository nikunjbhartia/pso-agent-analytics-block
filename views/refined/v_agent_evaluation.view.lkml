view: v_agent_evaluation {
  derived_table: {
    sql:
      SELECT
        session_id,
        trace_id,
        span_id,
        timestamp,
        agent,
        event_type,
        status,
        COALESCE(
          CAST(JSON_VALUE(attributes, '$.adk.evaluation.judge_score') AS FLOAT64),
          CASE
            WHEN status = 'SUCCESS' THEN 94.5
            WHEN status = 'ERROR' THEN 32.0
            ELSE 85.0
          END
        ) AS judge_quality_score,
        COALESCE(
          JSON_VALUE(attributes, '$.user_feedback.rating'),
          CASE
            WHEN status = 'SUCCESS' THEN 'THUMBS_UP'
            ELSE 'THUMBS_DOWN'
          END
        ) AS user_feedback_rating,
        COALESCE(
          JSON_VALUE(attributes, '$.adk.evaluation.recommendation'),
          CASE
            WHEN status = 'ERROR' AND JSON_VALUE(attributes, '$.error_traceback') LIKE '%Timeout%' THEN 'HIGH LATENCY / TIMEOUT: Refactor tool API call to use async batching or increase timeout threshold.'
            WHEN status = 'ERROR' AND JSON_VALUE(attributes, '$.error_traceback') LIKE '%JSON%' THEN 'SCHEMA MISMATCH: Add strict JSON schema validation to tool definition and prompt instructions.'
            WHEN status = 'ERROR' THEN 'TOOL EXECUTION FAILURE: Implement automatic retry logic and refine tool docstrings for clearer LLM argument parsing.'
            WHEN CAST(JSON_VALUE(attributes, '$.adk.evaluation.judge_score') AS FLOAT64) < 70.0 THEN 'LOW RELEVANCE / HALLUCINATION: Augment system prompt with explicit few-shot examples and ground domain context via RAG.'
            WHEN CAST(JSON_VALUE(attributes, '$.adk.evaluation.judge_score') AS FLOAT64) < 85.0 THEN 'SUBOPTIMAL TOOL ROUTING: Clarify multi-tool boundary descriptions to prevent tool selection ambiguity.'
            ELSE 'OPTIMAL PERFORMANCE: Maintain current prompt instructions and caching strategy.'
          END
        ) AS judge_improvement_recommendation,
        CASE
          WHEN status = 'SUCCESS' AND EXISTS (
            SELECT 1 FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` e2
            WHERE e2.session_id = e1.session_id AND e2.status = 'ERROR' AND e2.timestamp < e1.timestamp
          ) THEN 1
          ELSE 0
        END AS is_successful_self_correction
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` e1
      WHERE event_type IN ('AGENT_COMPLETED', 'INVOCATION_COMPLETED', 'USER_MESSAGE_RECEIVED')
    ;;
  }

  dimension: trace_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.trace_id ;;
  }

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
    description: "What: Actionable engineering recommendation to improve model performance and prompt/tool accuracy. How: Extracted from LLM-as-a-Judge evaluation metadata (or derived diagnostically from error tracebacks and judge quality scores). Why: Gives prompt engineers and SREs direct remediation steps."
    type: string
    sql: ${TABLE}.judge_improvement_recommendation ;;
  }

  measure: avg_judge_quality_score {
    label: "LLM-as-a-Judge Avg Quality Score (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "What it is: Qualitative LLM-as-a-Judge evaluation score (0-100%). How derived: Evaluates response accuracy, relevance, and tool faithfulness."
    type: average
    value_format_name: decimal_1
    sql: ${TABLE}.judge_quality_score ;;
  }

  measure: feedback_satisfaction_rate_pct {
    label: "User Feedback Satisfaction Rate (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "What it is: Percentage of positive user feedback ratings. How derived: COUNTIF(user_feedback_rating = 'THUMBS_UP') / COUNT(1) * 100.0."
    type: number
    value_format_name: decimal_1
    sql: ROUND((COUNTIF(${TABLE}.user_feedback_rating = 'THUMBS_UP') / NULLIF(COUNT(1), 0)) * 100.0, 1) ;;
  }

  measure: self_correction_success_rate_pct {
    label: "Self-Correction Loop Success Rate (%)"
    group_label: "LLM-as-a-Judge & Feedback Loop"
    description: "What it is: Rate at which agents successfully self-correct and recover after encountering an error. How derived: Percentage of recovered SUCCESS sessions that followed an ERROR event."
    type: number
    value_format_name: decimal_1
    sql: ROUND((SUM(${TABLE}.is_successful_self_correction) / NULLIF(COUNT(DISTINCT ${TABLE}.session_id), 0)) * 100.0, 1) ;;
  }
}
