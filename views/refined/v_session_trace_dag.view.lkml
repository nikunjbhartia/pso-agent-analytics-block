view: v_session_trace_dag {
  derived_table: {
    sql:
      SELECT
        session_id,
        trace_id,
        span_id,
        parent_span_id,
        timestamp,
        event_type,
        agent AS from_agent,
        COALESCE(JSON_VALUE(content, '$.to_agent'), JSON_VALUE(content, '$.tool'), event_type) AS to_target,
        CAST(JSON_VALUE(latency_ms, '$.total_ms') AS INT64) AS total_ms,
        status
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events`
      WHERE event_type IN ('AGENT_TRANSFER', 'A2A_INTERACTION', 'TOOL_COMPLETED', 'LLM_RESPONSE')
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
    group_label: "Session & Trace DAG Lineage"
    description: "Unique conversation session identifier linking multi-agent DAG execution flows."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: span_id {
    hidden: yes
    type: string
    sql: ${TABLE}.span_id ;;
  }

  dimension: parent_span_id {
    label: "Parent Span ID"
    group_label: "Session & Trace DAG Lineage"
    description: "Parent span identifier representing hierarchical DAG parent-child execution relationship."
    type: string
    sql: ${TABLE}.parent_span_id ;;
  }

  dimension: from_agent {
    label: "DAG Source Node (From Agent)"
    group_label: "Session & Trace DAG Lineage"
    description: "Originating agent or supervisor node in the multi-agent DAG execution graph."
    type: string
    sql: ${TABLE}.from_agent ;;
  }

  dimension: to_target {
    label: "DAG Target Node (To Agent / Tool)"
    group_label: "Session & Trace DAG Lineage"
    description: "Target receiving node in the DAG execution graph (delegated agent, backend tool, or LLM)."
    type: string
    sql: ${TABLE}.to_target ;;
  }

  measure: total_dag_hops {
    label: "Total DAG Lineage Hops"
    group_label: "Session & Trace DAG Lineage"
    description: "Total number of edges/hops in the multi-agent trace DAG execution graph."
    type: count
  }

  measure: avg_dag_hop_latency_ms {
    label: "Average DAG Hop Latency (ms)"
    group_label: "Session & Trace DAG Lineage"
    description: "Average execution latency in milliseconds per DAG hop or edge transfer."
    type: average
    value_format_name: decimal_1
    sql: ${TABLE}.total_ms ;;
  }
}
