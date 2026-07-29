view: v_tool_completed {
  sql_table_name: `nikunjbhartia-test-clients.agent_analytics.v_tool_completed` ;;

  dimension_group: timestamp {
    group_label: "IDs & Tracing"
    description: "What: The UTC timestamp when the event occurred. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  dimension: event_type {
    group_label: "Event Info"
    description: "What: The category of the event. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: agent {
    group_label: "Event Info"
    description: "What: The name of the agent that generated this event. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.agent ;;
  }

  dimension: session_id {
    group_label: "IDs & Tracing"
    description: "What: A unique identifier for the entire conversation session. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: invocation_id {
    group_label: "IDs & Tracing"
    description: "What: A unique identifier for a single turn or execution within a session. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    hidden: yes
    sql: ${TABLE}.invocation_id ;;
  }

  dimension: user_id {
    group_label: "IDs & Tracing"
    description: "What: The identifier of the end-user participating in the session, if available. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: trace_id {
    group_label: "IDs & Tracing"
    description: "What: OpenTelemetry trace ID for distributed tracing across services. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    hidden: yes
    sql: ${TABLE}.trace_id ;;
  }

  dimension: span_id {
    group_label: "IDs & Tracing"
    description: "What: OpenTelemetry span ID for this specific operation. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    hidden: yes
    sql: ${TABLE}.span_id ;;
  }

  dimension: parent_span_id {
    group_label: "IDs & Tracing"
    description: "What: OpenTelemetry parent span ID to reconstruct the operation hierarchy. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.parent_span_id ;;
  }

  dimension: status {
    group_label: "Event Info"
    description: "What: The outcome of the event, typically 'OK' or 'ERROR'. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: error_message {
    group_label: "Event Info"
    description: "What: Detailed error message if the status is 'ERROR'. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: ${TABLE}.error_message ;;
  }

  dimension: is_truncated {
    group_label: "Event Info"
    description: "What: Boolean flag indicating if the content payload was truncated. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: yesno
    sql: ${TABLE}.is_truncated ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${trace_id}, '|', ${span_id}) ;;
    description: "What: Internal composite primary key for symmetric aggregates. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  dimension: tool_name {
    group_label: "Tool Info"
    description: "What: The specific name of the tool or function that was executed. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: ${TABLE}.tool_name ;;
  }

  dimension: tool_origin {
    group_label: "Tool Info"
    description: "What: The origin of the tool execution (e.g., LOCAL, MCP, SUB_AGENT). | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.tool_origin ;;
  }

  dimension: tool_result {
    group_label: "Tool Info"
    description: "What: The raw JSON result or output string returned by the tool. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: ${TABLE}.tool_result ;;
  }

  dimension: total_ms {
    group_label: "Latency"
    description: "What: The total execution time of the tool in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    sql: ${TABLE}.total_ms ;;
  }

  dimension: complexity_multiplier {
    group_label: "Tool Info"
    description: "What: Complexity multiplier for this tool completion (4.0 for heavy reasoning, 2.5 for medium, 1.5 for moderate, 1.0 baseline). | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    sql: CASE WHEN ${total_ms} > 5000 THEN 2.5 WHEN ${total_ms} > 2000 THEN 1.5 ELSE 1.0 END ;;
  }

  # --- BASE MEASURES ---

  measure: total_tool_usage {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${pk} ;;
    description: "What: Total number of times a tool was successfully completed. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: [agent_events.timestamp_time, agent_events.agent, agent_events.user_id, agent_events.trace_id, tool_name, total_ms]
  }

  measure: average_tool_latency {
    group_label: "Performance & Reliability"
    type: average
    sql: ${total_ms} ;;
    description: "What: Average latency for tool completion in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    value_format_name: decimal_1
    drill_fields: []
    
    link: {
      label: "Latency Distribution by Tool (Area Chart)"
      url: "@{VIZ_STACKED_AREA}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.tool_name,{{ _view._name }}.average_tool_latency&pivots={{ _view._name }}.tool_name&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Slowest Tools (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.tool_name,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: p50_tool_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 50
    sql: ${total_ms} ;;
    description: "What: Median (P50) latency for tool completion in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Inspect Slowest Tools (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.tool_name,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: p75_tool_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 75
    sql: ${total_ms} ;;
    description: "What: 75th percentile latency for tool completion in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
  }

  measure: p90_tool_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 90
    sql: ${total_ms} ;;
    description: "What: 90th percentile latency for tool completion in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Inspect Slowest Tools (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.tool_name,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }
  
  measure: p99_tool_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 99
    sql: ${total_ms} ;;
    description: "What: 99th percentile latency for tool completion in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Inspect Slowest Tools (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.tool_name,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  # --- POP MEASURES: TOOL USAGE ---

  measure: pop_tool_usage_current {
    group_label: "PoP: Tool Usage"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total tool executions in the currently selected PoP date range. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_tool_usage_previous {
    group_label: "PoP: Tool Usage"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total tool executions in the previous period of the exact same length. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_tool_usage_change {
    group_label: "PoP: Tool Usage"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_tool_usage_current} - ${pop_tool_usage_previous}, ${pop_tool_usage_previous}) ;;
    description: "What: The percentage change in tool executions between the current and previous period. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: tool_productivity_credit_hours {
    group_label: "Usage & Volume"
    description: "What: Total server-verified productivity credit hours saved by tool completions. Estimation Note: Assumes 1.5 hrs baseline manual effort saved per tool call, scaled by latency complexity weight (1.0x standard, 1.5x >2s, 2.5x >5s). | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    value_format_name: decimal_2
    sql: SUM(1.5 * (CASE WHEN ${total_ms} > 5000 THEN 2.5 WHEN ${total_ms} > 2000 THEN 1.5 ELSE 1.0 END)) ;;
  }

  measure: avg_complexity_multiplier {
    group_label: "Performance & Reliability"
    description: "What: Average complexity multiplier across executed tools. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: average
    sql: ${complexity_multiplier} ;;
    value_format_name: decimal_2
  }

}