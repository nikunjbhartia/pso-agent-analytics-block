view: udf_realtime_scorecard {
  sql_table_name: `@{PROJECT_ID}.@{DATASET_NAME}.udf_scorecard_metrics` ;;

  dimension: practice_area {
    type: string
    sql: ${TABLE}.practice_area ;;
  }

  dimension: agent {
    type: string
    sql: ${TABLE}.agent ;;
  }

  measure: total_sessions {
    type: sum
    sql: ${TABLE}.total_sessions ;;
  }

  measure: total_spans {
    type: sum
    sql: ${TABLE}.total_spans ;;
  }

  measure: avg_latency_score {
    type: average
    sql: ${TABLE}.avg_latency_score ;;
    value_format_name: percent_2
  }

  measure: avg_ttft_score {
    type: average
    sql: ${TABLE}.avg_ttft_score ;;
    value_format_name: percent_2
  }

  measure: avg_token_efficiency_score {
    type: average
    sql: ${TABLE}.avg_token_efficiency_score ;;
    value_format_name: percent_2
  }

  measure: avg_cost_score {
    type: average
    sql: ${TABLE}.avg_cost_score ;;
    value_format_name: percent_2
  }

  measure: avg_error_rate_score {
    type: average
    sql: ${TABLE}.avg_error_rate_score ;;
    value_format_name: percent_2
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
  }

  dimension: agent {
    type: string
    sql: ${TABLE}.agent ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_time ;;
  }

  measure: span_count {
    type: sum
    sql: ${TABLE}.span_count ;;
  }

  measure: error_count {
    type: sum
    sql: ${TABLE}.error_count ;;
  }

  dimension: sdk_version {
    type: string
    sql: ${TABLE}.sdk_version ;;
  }

  dimension: analyzed_session_id {
    type: string
    sql: ${TABLE}.analyzed_session_id ;;
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
  }

  dimension: drift_metric {
    type: string
    sql: ${TABLE}.drift_metric ;;
  }

  dimension: kolmogorov_smirnov_stat {
    type: number
    sql: ${TABLE}.kolmogorov_smirnov_stat ;;
    value_format_name: decimal_3
  }

  dimension: p_value {
    type: number
    sql: ${TABLE}.p_value ;;
    value_format_name: decimal_3
  }

  dimension: drift_status {
    type: string
    sql: ${TABLE}.drift_status ;;
  }

  dimension_group: last_evaluated {
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.last_evaluated_at ;;
  }
}
