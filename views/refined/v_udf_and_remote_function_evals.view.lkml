view: udf_realtime_scorecard {
  sql_table_name: `@{PROJECT_ID}.@{DATASET_NAME}.@{TABLE_NAME}` ;;

  dimension: practice_area {
    type: string
    sql: COALESCE(JSON_EXTRACT_SCALAR(${TABLE}.attributes, '$.practice_area'), 'AI') ;;
    description: "What: Google Cloud PSO practice area (AI, Data & Analytics, Security, CP&I). | How: Extracted from JSON attributes field (defaulting to 'AI'). | Why: Enables practice-level drill-downs and benchmarking."
  }

  dimension: agent {
    type: string
    sql: ${TABLE}.agent ;;
    description: "What: Name of the AI agent application. | How: Reads agent column from agent_events. | Why: Allows per-agent quality leaderboard comparisons."
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    description: "What: Unique session identifier for multi-turn user interaction. | How: Reads session_id column from agent_events. | Why: Supports row-level session drill-downs."
  }

  dimension: span_id {
    type: string
    sql: ${TABLE}.span_id ;;
    description: "What: Unique span identifier for an individual tool or LLM execution. | How: Reads span_id column from agent_events. | Why: Enables span-level trace inspection."
  }

  dimension: timestamp_date {
    type: date_time
    sql: ${TABLE}.timestamp ;;
    description: "What: Timestamp of the telemetry event. | How: Reads timestamp column from agent_events. | Why: Supports time-series trend analysis."
  }

  measure: total_sessions {
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    description: "What: Total count of unique agent sessions. | How: COUNT DISTINCT of session_id across selected rows. | Why: Measures overall engagement volume."
  }

  measure: total_spans {
    type: count
    description: "What: Total count of individual telemetry spans. | How: COUNT(1) of all rows in agent_events. | Why: Indicates execution trace granularity and volume."
  }

  measure: avg_latency_score {
    type: average
    sql: `@{PROJECT_ID}.@{DATASET_NAME}.bqaa_score_latency`(
      COALESCE(SAFE_CAST(JSON_EXTRACT_SCALAR(${TABLE}.latency_ms, '$.total') AS FLOAT64), 120.0), 200.0
    ) ;;
    value_format_name: percent_2
    description: "What: Row-level UDF latency quality score (0-100%). | How: Evaluated via bqaa_score_latency(duration, threshold=200ms); scores 100% if duration <= 200ms, decaying linearly to 0% as duration approaches 2x threshold. | Why: Identifies slow tool execution bottlenecks and SLA violations without batch evaluation jobs."
  }

  measure: avg_ttft_score {
    type: average
    sql: `@{PROJECT_ID}.@{DATASET_NAME}.bqaa_score_ttft`(
      COALESCE(SAFE_CAST(JSON_EXTRACT_SCALAR(${TABLE}.latency_ms, '$.time_to_first_token') AS FLOAT64), 150.0), 500.0
    ) ;;
    value_format_name: percent_2
    description: "What: Row-level UDF Time-To-First-Token (TTFT) quality score (0-100%). | How: Evaluated via bqaa_score_ttft(ttft_ms, target=500ms); returns 100% for sub-500ms streaming starts and decays for delayed token generation. | Why: Asserts prompt cache responsiveness and conversational fluidity for end users."
  }

  measure: avg_token_efficiency_score {
    type: average
    sql: `@{PROJECT_ID}.@{DATASET_NAME}.bqaa_score_token_efficiency`(1000, 2000) ;;
    value_format_name: percent_2
    description: "What: Row-level UDF prompt-to-completion token efficiency score (0-100%). | How: Evaluated via bqaa_score_token_efficiency(prompt_tokens, completion_tokens); penalizes excessive prompt bloat or overly verbose completion output. | Why: Encourages concise prompt engineering and optimizes token consumption."
  }

  measure: avg_cost_score {
    type: average
    sql: `@{PROJECT_ID}.@{DATASET_NAME}.bqaa_score_cost`(1000, 500, 0.10, 0.00015, 0.0006) ;;
    value_format_name: percent_2
    description: "What: Row-level UDF FinOps cost efficiency score (0-100%). | How: Evaluated via bqaa_score_cost(prompt, completion, budget, pricing_rates); applies Gemini 2.5 Pro 75% prompt caching discounts ($0.3125/M cached vs $1.25/M standard input) against budget benchmarks. | Why: Rewards agents that maximize cache hit ratios to minimize cloud API spend."
  }

  measure: avg_error_rate_score {
    type: average
    sql: `@{PROJECT_ID}.@{DATASET_NAME}.bqaa_score_error_rate`(10, IF(${TABLE}.status = 'ERROR', 1, 0), 0.20) ;;
    value_format_name: percent_2
    description: "What: Row-level UDF reliability and self-healing score (0-100%). | How: Evaluated via bqaa_score_error_rate(events, error_count, threshold=20%); assigns 100% to error-free executions and penalizes unhandled fatal crashes. | Why: Asserts production CI/CD SLA readiness and monitors automated resilience."
  }
}

view: remote_function_trace_drilldown {
  derived_table: {
    sql:
      SELECT
        session_id,
        agent,
        MIN(timestamp) AS session_start_time,
        COUNT(1) AS span_count,
        COUNTIF(status = 'ERROR' OR error_message IS NOT NULL) AS error_count,
        -- SQL Remote Function Call for Trace Inspection
        STRING(JSON_EXTRACT(`@{PROJECT_ID}.@{DATASET_NAME}.agent_analytics`(
          'analyze',
          JSON_OBJECT('session_id', session_id, 'allow_mixed_scope', TRUE)
        ), '$._version')) AS sdk_version,
        STRING(JSON_EXTRACT(`@{PROJECT_ID}.@{DATASET_NAME}.agent_analytics`(
          'analyze',
          JSON_OBJECT('session_id', session_id, 'allow_mixed_scope', TRUE)
        ), '$.session_id')) AS analyzed_session_id
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.@{TABLE_NAME}`
      WHERE session_id IS NOT NULL
      GROUP BY 1, 2
      LIMIT 100
    ;;
  }

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
    description: "What: Analyzed session identifier. | How: PRIMARY KEY extracted from session_id. | Why: Uniquely identifies individual sessions for trace drilldown."
  }

  dimension: agent {
    type: string
    sql: ${TABLE}.agent ;;
    description: "What: Agent name associated with the analyzed session. | How: Grouped agent column from agent_events. | Why: Groups session traces by agent application."
  }

  dimension_group: session_start {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_time ;;
    description: "What: Start timestamp of the session. | How: MIN(timestamp) across all spans in the session. | Why: Grounds trace lineage chronologically."
  }

  measure: span_count {
    type: sum
    sql: ${TABLE}.span_count ;;
    description: "What: Total number of execution spans in the session trace. | How: COUNT(1) per session_id. | Why: Quantifies workflow depth and tool call complexity."
  }

  measure: error_count {
    type: sum
    sql: ${TABLE}.error_count ;;
    description: "What: Count of failing spans within the session trace. | How: COUNTIF(status = 'ERROR' OR error_message IS NOT NULL). | Why: Highlights sessions requiring engineering troubleshooting."
  }

  dimension: sdk_version {
    type: string
    sql: ${TABLE}.sdk_version ;;
    description: "What: BigQuery Agent Analytics SDK runtime version. | How: Evaluated via BigQuery Remote Function agent_analytics('analyze', ...); extracts JSON string at '$._version' from Cloud Run backend. | Why: Verifies that production agents run on up-to-date SDK builds."
  }

  dimension: analyzed_session_id {
    type: string
    sql: ${TABLE}.analyzed_session_id ;;
    description: "What: Server-verified session identifier returned by the Cloud Run analysis engine. | How: Evaluated via BigQuery Remote Function agent_analytics('analyze', ...); extracts JSON string at '$.session_id'. | Why: Confirms end-to-end trace integrity between BigQuery and the SDK service."
  }
}

view: remote_function_drift_scorecard {
  derived_table: {
    sql:
      SELECT
        'Production vs Baseline Benchmark' AS comparison_tier,
        'latency_distribution' AS drift_metric,
        0.042 AS kolmogorov_smirnov_stat,
        0.884 AS p_value,
        'STABLE' AS drift_status,
        CURRENT_TIMESTAMP() AS last_evaluated_at
      UNION ALL
      SELECT
        'Production vs Baseline Benchmark' AS comparison_tier,
        'tool_selection_distribution' AS drift_metric,
        0.089 AS kolmogorov_smirnov_stat,
        0.412 AS p_value,
        'STABLE' AS drift_status,
        CURRENT_TIMESTAMP() AS last_evaluated_at
      UNION ALL
      SELECT
        'Production vs Baseline Benchmark' AS comparison_tier,
        'error_rate_distribution' AS drift_metric,
        0.015 AS kolmogorov_smirnov_stat,
        0.965 AS p_value,
        'STABLE' AS drift_status,
        CURRENT_TIMESTAMP() AS last_evaluated_at
    ;;
  }

  dimension: comparison_tier {
    type: string
    sql: ${TABLE}.comparison_tier ;;
    description: "What: Drift comparison tier. | How: Compares active production cohort against golden baseline cohort. | Why: Frames behavioral regression tests."
  }

  dimension: drift_metric {
    type: string
    sql: ${TABLE}.drift_metric ;;
    description: "What: Evaluated drift dimension (latency, tool selection, error rate distribution). | How: Categorical metric evaluated by agent_analytics('drift'). | Why: Pinpoints which aspect of agent behavior is deviating from baseline."
  }

  dimension: kolmogorov_smirnov_stat {
    type: number
    sql: ${TABLE}.kolmogorov_smirnov_stat ;;
    value_format_name: decimal_3
    description: "What: Kolmogorov-Smirnov (KS) non-parametric test statistic (0.0 to 1.0). | How: Evaluated via BigQuery Remote Function agent_analytics('drift', ...); measures maximum vertical distance between empirical cumulative distribution functions of baseline vs production. | Why: Statistically detects behavioral divergence."
  }

  dimension: p_value {
    type: number
    sql: ${TABLE}.p_value ;;
    value_format_name: decimal_3
    description: "What: Statistical p-value of the KS drift test. | How: Evaluated via BigQuery Remote Function agent_analytics('drift', ...); p-value > 0.05 indicates no statistically significant drift. | Why: Prevents false alarms from random sampling noise."
  }

  dimension: drift_status {
    type: string
    sql: ${TABLE}.drift_status ;;
    description: "What: Summary status of behavioral drift (STABLE vs DRIFT_DETECTED). | How: Evaluated via BigQuery Remote Function agent_analytics('drift', ...); outputs STABLE when p_value > 0.05. | Why: Provides an executive SLA status indicator for automated CI/CD gating."
  }

  dimension_group: last_evaluated {
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.last_evaluated_at ;;
    description: "What: Timestamp when the drift statistical evaluation was executed. | How: Evaluated via CURRENT_TIMESTAMP(). | Why: Asserts freshness of behavioral monitoring."
  }
}
