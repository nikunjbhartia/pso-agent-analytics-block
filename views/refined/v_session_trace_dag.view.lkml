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
    description: "What: Unique conversation session identifier linking multi-agent DAG execution flows.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
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
    description: "What: Parent span identifier representing hierarchical DAG parent-child execution relationship.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.parent_span_id ;;
  }

  dimension: from_agent {
    label: "DAG Source Node (From Agent)"
    group_label: "Session & Trace DAG Lineage"
    description: "What: Originating agent or supervisor node in the multi-agent DAG execution graph.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.from_agent ;;
  }

  dimension: to_target {
    label: "DAG Target Node (To Agent / Tool)"
    group_label: "Session & Trace DAG Lineage"
    description: "What: Target receiving node in the DAG execution graph (delegated agent, backend tool, or LLM).\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.to_target ;;
  }

  measure: total_dag_hops {
    label: "Total DAG Lineage Hops"
    group_label: "Session & Trace DAG Lineage"
    description: "What: Total number of edges/hops in the multi-agent trace DAG execution graph.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: count
  }

  measure: avg_dag_hop_latency_ms {
    label: "Average DAG Hop Latency (ms)"
    group_label: "Session & Trace DAG Lineage"
    description: "What: What: Average execution latency per DAG hop. How: AVG(total_ms). Why: Identifies slow orchestration hops.\nHow: Measured in milliseconds from start timestamp to completion timestamp across trace spans.\nWhy: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: average
    value_format_name: decimal_1
    sql: ${TABLE}.total_ms ;;
  }

  dimension: is_circular_delegation {
    label: "Is Circular A2A Delegation Loop (Ping-Pong)"
    group_label: "Session & Trace DAG Lineage"
    description: "What: What: Flags circular ping-pong delegation loops between agents. How: Evaluates if from_agent equals to_target. Why: Detects infinite orchestration loops and wasted token spend.\nHow: Calculated using Gemini 2.5 Pro pricing rates with 75% prompt cache discount ($0.3125/M cached vs $1.25/M standard input).\nWhy: Monitors net FinOps API expenditure and identifies opportunities for prompt cache optimization."
    type: string
    sql: CASE WHEN ${TABLE}.from_agent = ${TABLE}.to_target THEN 'YES - CIRCULAR LOOP' ELSE 'NO' END ;;
  }

  measure: circular_loop_count {
    label: "Circular A2A Delegation Loop Count"
    group_label: "Session & Trace DAG Lineage"
    description: "What: What: Total count of circular delegation ping-pong hops detected. How: SUM of is_circular_delegation flags. Why: Prioritizes debugging of recursive agent loops.\nHow: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements.\nWhy: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: sum
    sql: CASE WHEN ${TABLE}.from_agent = ${TABLE}.to_target THEN 1 ELSE 0 END ;;
  }
}

