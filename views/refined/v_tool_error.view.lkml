view: v_tool_error {
  sql_table_name: `nikunjbhartia-test-clients.agent_analytics.v_tool_error` ;;

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
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,{{ _view._name }}.tool_name,agent_events.agent,{{ _view._name }}.tool_args,agent_events.error_message&sorts=agent_events.timestamp_time+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Error Distribution by Tool (Donut Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_pie\", \"inner_radius\": 50, \"legend_position\": \"center\", \"value_labels\": \"legend\", \"label_type\": \"labPer\", \"show_view_names\": false, \"defaults_version\": 1 }' %}{{ link }}&fields={{ _view._name }}.tool_name,{{ _view._name }}.total_tool_errors&sorts={{ _view._name }}.total_tool_errors+desc&limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Error Trend Breakdown (Area Chart)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"trellis\": \"\", \"stacking\": \"normal\", \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"interpolation\": \"monotone\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"type\": \"looker_area\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_date,agent_events.agent,{{ _view._name }}.total_tool_errors&pivots=agent_events.agent&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
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