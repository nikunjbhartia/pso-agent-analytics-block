view: v_agent_error {
  derived_table: {
    sql:
      SELECT
        timestamp,
        event_type,
        agent,
        session_id,
        invocation_id,
        user_id,
        trace_id,
        span_id,
        parent_span_id,
        status,
        error_message,
        is_truncated,
        total_ms,
        error_traceback
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.v_agent_error`
    ;;
  }

  dimension: trace_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.trace_id ;;
  }

  dimension: span_id {
    hidden: yes
    type: string
    sql: ${TABLE}.span_id ;;
  }

  dimension: event_type {
    hidden: yes
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: error_traceback {
    group_label: "Performance & Reliability"
    description: "What: Full Python traceback string for agent execution errors.\nHow: COUNT or ratio of events where status = 'ERROR' or error_message is not null.\nWhy: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: ${TABLE}.error_traceback ;;
  }

  measure: total_agent_errors {
    label: "Total Agent Errors"
    group_label: "Performance & Reliability"
    description: "What: Total number of agent-level execution errors.\nHow: COUNT or ratio of events where status = 'ERROR' or error_message is not null.\nWhy: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: count
  }
}
