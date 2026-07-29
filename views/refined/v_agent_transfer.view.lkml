view: v_agent_transfer {
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
        from_agent,
        to_agent,
        source_event_id
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.v_agent_transfer`
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

  dimension: from_agent {
    group_label: "Multi-Agent Delegation"
    description: "What: The originating agent in a multi-agent transfer.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.from_agent ;;
  }

  dimension: to_agent {
    group_label: "Multi-Agent Delegation"
    description: "What: The target receiving agent in a multi-agent transfer.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.to_agent ;;
  }

  measure: total_agent_transfers {
    label: "Total Agent Transfers"
    group_label: "Multi-Agent Delegation"
    description: "What: Total number of multi-agent handoffs or delegation events.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: count
  }
}
