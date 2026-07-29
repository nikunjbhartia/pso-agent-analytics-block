view: v_a2a_interaction {
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
        a2a_task_id,
        a2a_context_id
      FROM `nikunjbhartia-test-clients.agent_analytics.v_a2a_interaction`
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

  dimension: a2a_task_id {
    group_label: "Multi-Agent Delegation"
    description: "What: Task identifier for Agent-to-Agent (A2A) interactions. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.a2a_task_id ;;
  }

  dimension: a2a_context_id {
    group_label: "Multi-Agent Delegation"
    description: "What: Shared context identifier across A2A agent delegations. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.a2a_context_id ;;
  }

  measure: total_a2a_interactions {
    label: "Total A2A Interactions"
    group_label: "Multi-Agent Delegation"
    description: "What: Total number of Agent-to-Agent (A2A) protocol interactions. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: count
  }
}
