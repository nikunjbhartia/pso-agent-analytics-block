view: v_tool_error {
  sql_table_name: `@{PROJECT_ID}.@{DATASET_NAME}.v_tool_error` ;;

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
    description: "What: The specific name of the tool or function that threw the error. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: ${TABLE}.tool_name ;;
  }

  dimension: tool_origin {
    group_label: "Tool Info"
    description: "What: The origin of the tool execution (e.g., LOCAL, MCP, SUB_AGENT) that failed. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: ${TABLE}.tool_origin ;;
  }

  dimension: tool_args {
    group_label: "Tool Info"
    type: string
    sql: TO_JSON_STRING(${TABLE}.tool_args) ;;
    description: "What: The JSON arguments that were passed to the tool when it failed. Cast to string to prevent BigQuery grouping errors. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
  }

  dimension: total_ms {
    group_label: "Latency"
    description: "What: The amount of time in milliseconds the tool ran before throwing the error. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    sql: ${TABLE}.total_ms ;;
  }

  # --- BASE MEASURES ---

  measure: total_tool_errors {
    group_label: "Performance & Reliability"
    type: count_distinct
    sql: ${pk} ;;
    description: "What: Total number of tool calls that resulted in an error status. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    drill_fields: []
    
    link: {
      label: "The Root Cause Inspector (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,{{ _view._name }}.tool_name,agent_events.agent,{{ _view._name }}.tool_args,agent_events.error_message&sorts=agent_events.timestamp_time+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Error Distribution by Tool (Donut Chart)"
      url: "@{VIZ_DONUT_CHART}{{ link }}&fields={{ _view._name }}.tool_name,{{ _view._name }}.total_tool_errors&sorts={{ _view._name }}.total_tool_errors+desc&limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Error Trend Breakdown (Area Chart)"
      url: "@{VIZ_STACKED_AREA}{{ link }}&fields=agent_events.timestamp_date,agent_events.agent,{{ _view._name }}.total_tool_errors&pivots=agent_events.agent&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  # --- POP MEASURES: TOOL ERRORS ---

  measure: pop_tool_errors_current {
    group_label: "PoP: Tool Errors"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total tool errors in the currently selected PoP date range. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
  }

  measure: pop_tool_errors_previous {
    group_label: "PoP: Tool Errors"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total tool errors in the previous period of the exact same length. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
  }

  measure: pop_tool_errors_change {
    group_label: "PoP: Tool Errors"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_tool_errors_current} - ${pop_tool_errors_previous}, ${pop_tool_errors_previous}) ;;
    description: "What: The percentage change in tool errors between the current and previous period. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
  }

}