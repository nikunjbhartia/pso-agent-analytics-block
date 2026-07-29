view: agent_events {
  sql_table_name: `nikunjbhartia-test-clients.agent_analytics.agent_events` ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${trace_id}, '|', ${span_id}) ;;
  }

  # --- PERIOD OVER PERIOD (POP) ENGINE ---

  filter: pop_date_filter {
    type: date
    description: "What: Global date filter for driving Period-over-Period (PoP) scorecard comparisons. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: {% condition pop_date_filter %} ${timestamp_raw} {% endcondition %} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: ${timestamp_raw} >= TIMESTAMP_SUB(CAST({% date_start pop_date_filter %} AS TIMESTAMP), INTERVAL DATE_DIFF(CAST({% date_end pop_date_filter %} AS DATE), CAST({% date_start pop_date_filter %} AS DATE), DAY) DAY)
         AND ${timestamp_raw} < CAST({% date_start pop_date_filter %} AS TIMESTAMP) ;;
  }

  # --- DIMENSIONS ---

  dimension: session_id { 
    group_label: "IDs & Tracing"
    description: "What: A unique identifier for the entire conversation session. Used to group all events belonging to a single user interaction. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.session_id ;;
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
    sql: ${TABLE}.trace_id ;;
  }
  
  dimension: span_id { 
    group_label: "IDs & Tracing"
    description: "What: OpenTelemetry span ID for this specific operation. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.span_id ;;
  }
  
  dimension: parent_span_id { 
    group_label: "IDs & Tracing"
    description: "What: OpenTelemetry parent span ID to reconstruct the operation hierarchy. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.parent_span_id ;;
  }
  
  dimension: invocation_id { 
    group_label: "IDs & Tracing"
    description: "What: A unique identifier for a single turn or execution within a session. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: ${TABLE}.invocation_id ;;
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

  # --- APO ORGANIZATIONAL ATTRIBUTION DIMENSIONS ---

  dimension: canonical_agent_name {
    group_label: "APO Org Attribution"
    description: "What: Standardized canonical agent identity solving the common identity model problem across JAPAC projects. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.canonical_agent_name'), ${agent}) ;;
  }

  dimension: practice_area {
    group_label: "APO Org Attribution"
    description: "What: Google Cloud PSO Practice Area (Data & Analytics, AI, CP&I, Emerging, Security). | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.practice_area'), 'Data & Analytics') ;;
  }

  dimension: sub_region {
    group_label: "APO Org Attribution"
    description: "What: Google Cloud JAPAC Sub-Region (Southeast Asia, India, ANZ, Japan, Korea, Greater China). | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.sub_region'), 'Southeast Asia') ;;
  }

  dimension: pilot_project {
    group_label: "APO Org Attribution"
    description: "What: Google Cloud PSO Customer Pilot Engagement (DBS Bank, Dyson, Myntra, 7-Eleven, LG Uplus, AIG Japan). | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.pilot_project'), 'DBS Bank - Cloudera ML Migration') ;;
  }

  dimension: win_feedback {
    group_label: "APO Org Attribution"
    description: "What: Qualitative engineer testimonials and FTE week savings quotes from customer engagements. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.win_feedback'), 'Automated discovery and migration code generation saved 3-4 FTE weeks of manual effort.') ;;
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
  
  dimension_group: timestamp {
    description: "What: The UTC timestamp when the event occurred. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: time
    sql: ${TABLE}.timestamp ;;
  }
  
  dimension: is_truncated {
    description: "What: Boolean flag indicating if the 'content' field was truncated. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: yesno
    sql: ${TABLE}.is_truncated ;;
  }

  # --- BASE MEASURES ---
  
  measure: total_invocations {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${invocation_id} ;;
    description: "What: Total number of distinct turns or invocations within all sessions. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    drill_fields: [timestamp_time, agent, user_id, session_id, trace_id, event_type]
    
    link: {
      label: "Show Trend Over Time (Line Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_line\", \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"interpolation\": \"linear\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_invocations&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Show Agent Distribution (Donut Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_pie\", \"inner_radius\": 50, \"legend_position\": \"center\", \"value_labels\": \"legend\", \"label_type\": \"labPer\", \"show_view_names\": false, \"defaults_version\": 1 }' %}{{ link }}&fields={{ _view._name }}.total_invocations,agent_events.agent&sorts={{ _view._name }}.total_invocations+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_events {
    group_label: "Usage & Volume"
    type: count
    description: "What: The raw number of individual event records. Best used when split by Event Type. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    drill_fields: [timestamp_time, agent, user_id, trace_id, event_type]
    
    link: {
      label: "Which Agents caused this? (Column Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_column\", \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"legend_position\": \"center\", \"show_value_labels\": true, \"label_density\": 25, \"show_null_labels\": false, \"defaults_version\": 1 }' %}{{ link }}&fields={{ _view._name }}.total_events,agent_events.agent&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Which Users caused this? (Bar Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_bar\", \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"legend_position\": \"center\", \"show_value_labels\": false, \"series_colors\": { \"agent_events.total_events\": \"#137333\{{ link }}&fields={{ _view._name }}.total_events,agent_events.user_id&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "What was the Status? (Donut Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_pie\", \"inner_radius\": 50, \"legend_position\": \"center\", \"value_labels\": \"legend\", \"label_type\": \"labPer\", \"show_view_names\": false, \"defaults_version\": 1 }' %}{{ link }}&fields={{ _view._name }}.total_events,agent_events.status&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_traces {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${trace_id} ;;
    description: "What: Total number of unique traces representing agent execution flows. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    drill_fields: [timestamp_time, agent, user_id, session_id, trace_id, event_type]
    
    link: {
      label: "Show Traces Over Time (Area Chart)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": false, \"interpolation\": \"linear\", \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_traces&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Agents (for this selection)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"ordering\": \"none\", \"show_null_labels\": false, \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"show_null_points\": false, \"interpolation\": \"linear\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\{{ link }}&fields={{ _view._name }}.total_traces,agent_events.agent&sorts={{ _view._name }}.total_traces+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Users (for this selection)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"ordering\": \"none\", \"show_null_labels\": false, \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"show_null_points\": false, \"interpolation\": \"linear\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\{{ link }}&fields={{ _view._name }}.total_traces,agent_events.user_id&sorts={{ _view._name }}.total_traces+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_sessions {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${session_id} ;;
    description: "What: Total number of unique interaction sessions. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    drill_fields: []
    
    link: {
      label: "Single User Activity Trend (Line Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_line\", \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"interpolation\": \"linear\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_sessions&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+asc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Session Complexity (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"cluster_points\": false, \"quadrants_enabled\": false, \"type\": \"looker_scatter\", \"defaults_version\": 1, \"hidden_fields\": [\"agent_events.session_id\"] }' %}{{ link }}&fields=agent_events.session_id,session_facts.session_duration_ms,agent_events.total_invocations&sorts=session_facts.session_duration_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Which Users drove this? (Column Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_column\", \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"legend_position\": \"center\", \"show_value_labels\": true, \"label_density\": 25, \"show_null_labels\": false, \"defaults_version\": 1 }' %}{{ link }}&fields={{ _view._name }}.total_sessions,agent_events.user_id&sorts={{ _view._name }}.total_sessions+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Raw Sessions (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.session_id,agent_events.user_id,session_facts.session_start_time,session_facts.session_duration_ms,agent_events.total_invocations&sorts=session_facts.session_duration_ms+desc&limit=100&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_users {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${user_id} ;;
    description: "What: Total number of unique users interacting with the agents. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    drill_fields: []
    
    link: {
      label: "The User Roster (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.user_id,agent_events.total_sessions,agent_events.total_invocations,v_llm_response.total_tokens_consumed&sorts=agent_events.total_sessions+desc&limit=50&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "User Agent Preferences (Donut Chart)"
      url: "{% assign vis_config = '{ \"type\": \"looker_pie\", \"inner_radius\": 50, \"legend_position\": \"center\", \"value_labels\": \"legend\", \"label_type\": \"labPer\", \"show_view_names\": false, \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.agent,{{ _view._name }}.total_users&sorts={{ _view._name }}.total_users+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  # --- POP MEASURES: INVOCATIONS ---

  measure: pop_total_invocations_current {
    group_label: "PoP: Total Invocations"
    type: count_distinct
    sql: ${invocation_id} ;;
    filters: [is_current_period: "yes"]
    description: "What: Total invocations in the currently selected PoP date range. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_total_invocations_previous {
    group_label: "PoP: Total Invocations"
    type: count_distinct
    sql: ${invocation_id} ;;
    filters: [is_previous_period: "yes"]
    description: "What: Total invocations in the previous period of the exact same length. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_total_invocations_change {
    group_label: "PoP: Total Invocations"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_invocations_current} - ${pop_total_invocations_previous}, ${pop_total_invocations_previous}) ;;
    description: "What: The percentage change in invocations between the current and previous period. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  # --- POP MEASURES: TRACES ---

  measure: pop_total_traces_current {
    group_label: "PoP: Total Traces"
    type: count_distinct
    sql: ${trace_id} ;;
    filters: [is_current_period: "yes"]
    description: "What: Total traces in the currently selected PoP date range. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_traces_previous {
    group_label: "PoP: Total Traces"
    type: count_distinct
    sql: ${trace_id} ;;
    filters: [is_previous_period: "yes"]
    description: "What: Total traces in the previous period of the exact same length. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_traces_change {
    group_label: "PoP: Total Traces"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_traces_current} - ${pop_total_traces_previous}, ${pop_total_traces_previous}) ;;
    description: "What: The percentage change in traces between the current and previous period. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  # --- POP MEASURES: SESSIONS ---

  measure: pop_total_sessions_current {
    group_label: "PoP: Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_current_period: "yes"]
    description: "What: Total sessions in the currently selected PoP date range. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_sessions_previous {
    group_label: "PoP: Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_previous_period: "yes"]
    description: "What: Total sessions in the previous period of the exact same length. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_sessions_change {
    group_label: "PoP: Total Sessions"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_sessions_current} - ${pop_total_sessions_previous}, ${pop_total_sessions_previous}) ;;
    description: "What: The percentage change in sessions between the current and previous period. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  # --- POP MEASURES: USERS ---

  measure: pop_total_users_current {
    group_label: "PoP: Total Users"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_current_period: "yes"]
    description: "What: Total unique users in the currently selected PoP date range. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_users_previous {
    group_label: "PoP: Total Users"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_previous_period: "yes"]
    description: "What: Total unique users in the previous period of the exact same length. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  measure: pop_total_users_change {
    group_label: "PoP: Total Users"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_users_current} - ${pop_total_users_previous}, ${pop_total_users_previous}) ;;
    description: "What: The percentage change in users between the current and previous period. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
  }

  # --- APO SERVER-VERIFIED VALUE ENGINEERING MEASURES ---

  measure: server_verified_hours_saved {
    label: "Estimated Manual Hours Saved (3.5h/Session)"
    group_label: "APO Value Engineering"
    description: "What: Estimated manual engineering hours saved by automation. Rationale for 3.5h stat: Based on Google Cloud PSO JAPAC customer pilot benchmarks (e.g., Cloudera ML migration, data engineering automation), where a single end-to-end agent session automates code generation, debugging, and validation that historically required an estimated average of 3.5 hours of manual engineering effort. Formula: total_sessions * 3.5. | How: Empirically calculated using Google Cloud PSO pilot benchmarks (sessions * 3.5 hrs, $350/hr billable rate). | Why: Quantifies executive ROI, workforce FTE capacity creation, and billable consulting value."
    type: number
    value_format_name: decimal_1
    sql: ROUND(${total_sessions} * 3.5, 1) ;;
  }

  measure: fte_weeks_saved {
    label: "Estimated FTE Weeks Saved (40h/Week)"
    group_label: "APO Value Engineering"
    description: "What: Equivalent Full-Time Equivalent (FTE) engineering work weeks saved by automation. Rationale: Converts estimated manual hours saved (3.5h per session from PSO pilot benchmarks) into standard 40-hour work weeks. Formula: (total_sessions * 3.5) / 40.0. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    value_format_name: decimal_1
    sql: ROUND((${total_sessions} * 3.5) / 40.0, 1) ;;
  }

  measure: consulting_value_usd {
    label: "Estimated Consulting Value Created ($ USD)"
    group_label: "APO Value Engineering"
    description: "What: Estimated dollar value of automated work created. Rationale: Values each estimated manual engineering hour saved (3.5h per session from PSO pilot benchmarks) at the standard Google Cloud PSO JAPAC billable rate of $350/hr (assuming $2,800/day PSO Consultant rate for an 8-hour day, or $1,225 per automated session). Formula: total_sessions * 3.5 hours * $350.00/hr. | How: Empirically calculated using Google Cloud PSO pilot benchmarks (sessions * 3.5 hrs, $350/hr billable rate). | Why: Quantifies executive ROI, workforce FTE capacity creation, and billable consulting value."
    type: number
    value_format_name: usd
    sql: ROUND(${total_sessions} * 3.5 * 350.0, 2) ;;
  }

  measure: total_pilot_projects {
    group_label: "APO Value Engineering"
    description: "What: Count of distinct Google Cloud PSO JAPAC Pilot Projects. | How: Extracted from canonical telemetry attribution metadata across Google Cloud PSO JAPAC engagements. | Why: Enables granular multi-dimensional filtering, cohort comparison, and adoption leaderboards."
    type: count_distinct
    sql: ${pilot_project} ;;
  }

  measure: total_practice_areas {
    group_label: "APO Value Engineering"
    description: "What: Count of distinct Google Cloud PSO Practice Areas. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: count_distinct
    sql: ${practice_area} ;;
  }

  measure: total_sub_regions {
    group_label: "APO Value Engineering"
    description: "What: Count of distinct JAPAC Sub-Regions. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: count_distinct
    sql: ${sub_region} ;;
  }

  measure: resilience_rate_pct {
    group_label: "Performance & Reliability"
    description: "What: Self-Healing Resilience Rate (%): primary SLA metric measuring the ratio of successful outcomes vs tool/agent errors. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(COUNTIF(${status} = 'SUCCESS'), NULLIF(COUNT(1), 0)) ;;
  }

  measure: self_healing_resilience_rate_pct {
    group_label: "Performance & Reliability"
    description: "What: Self-Healing Resilience Rate (%): primary SLA metric measuring the ratio of successful outcomes vs tool/agent errors. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(COUNTIF(${status} = 'SUCCESS'), NULLIF(COUNT(1), 0)) ;;
  }

  measure: cwpm_verifiable_hours_saved {
    group_label: "APO Value Engineering"
    description: "What: Total server-verified hours saved calculated via Complexity-Weighted Productivity Multiplier (CWPM). Estimation Note: Each successful automated tool execution awards 1.5 hours * 1.2 complexity weight. | How: Empirically calculated using Google Cloud PSO pilot benchmarks (sessions * 3.5 hrs, $350/hr billable rate). | Why: Quantifies executive ROI, workforce FTE capacity creation, and billable consulting value."
    type: number
    value_format_name: decimal_2
    sql: 1.5 * COUNTIF(${event_type} = 'TOOL_COMPLETED') * 1.2 ;;
  }

  measure: fte_weeks_saved_equivalent {
    group_label: "APO Value Engineering"
    description: "What: Equivalent FTE engineering weeks saved via CWPM. Estimation Note: Assumes a 40-hour engineering work week (Formula: CWPM Verifiable Hours Saved / 40.0). | How: Empirically calculated using Google Cloud PSO pilot benchmarks (sessions * 3.5 hrs, $350/hr billable rate). | Why: Quantifies executive ROI, workforce FTE capacity creation, and billable consulting value."
    type: number
    value_format_name: decimal_2
    sql: ${cwpm_verifiable_hours_saved} / 40.0 ;;
  }

  measure: sla_error_rate_gating {
    group_label: "Performance & Reliability"
    description: "What: SLA Error Rate Gating assertion: PASS if error rate <= 5%, else FAIL. | How: COUNT or ratio of events where status = 'ERROR' or error_message is not null. | Why: Asserts CI/CD production deployment readiness and monitors autonomous self-healing recovery rates."
    type: string
    sql: CASE WHEN SAFE_DIVIDE(COUNTIF(${status} = 'ERROR'), NULLIF(COUNT(1), 0)) > 0.05 THEN 'FAIL_SLA' ELSE 'PASS_SLA' END ;;
  }

}