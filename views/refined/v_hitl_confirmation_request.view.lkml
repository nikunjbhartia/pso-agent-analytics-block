view: v_hitl_confirmation_request {
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
        tool_name
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.v_hitl_confirmation_request`
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

  dimension: tool_name {
    group_label: "Human-In-The-Loop"
    description: "What: Tool requiring human-in-the-loop (HITL) confirmation.\nHow: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry.\nWhy: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: ${TABLE}.tool_name ;;
  }

  measure: total_hitl_confirmation_requests {
    label: "Total HITL Confirmation Requests"
    group_label: "Human-In-The-Loop"
    description: "What: Total number of Human-In-The-Loop confirmation requests triggered.\nHow: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry.\nWhy: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: count
  }
}
