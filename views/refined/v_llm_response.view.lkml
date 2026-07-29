view: v_llm_response {
  sql_table_name: `nikunjbhartia-test-clients.agent_analytics.v_llm_response` ;;

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

  dimension: usage_total_tokens {
    group_label: "Token Usage"
    description: "What: The total number of tokens (prompt + completion) consumed by this specific LLM response. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    sql: ${TABLE}.usage_total_tokens ;;
  }

  dimension: usage_prompt_tokens {
    group_label: "Token Usage"
    description: "What: The number of tokens consumed by the input prompt sent to the LLM. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    sql: ${TABLE}.usage_prompt_tokens ;;
  }

  dimension: usage_completion_tokens {
    group_label: "Token Usage"
    description: "What: The number of tokens consumed by the output generated by the LLM. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    sql: ${TABLE}.usage_completion_tokens ;;
  }

  dimension: usage_cached_tokens {
    group_label: "Token Usage"
    description: "What: The number of prompt tokens that were served from the context cache, reducing latency and cost. | How: Calculated using Gemini 2.5 Pro pricing rates with 75% prompt cache discount ($0.3125/M cached vs $1.25/M standard input). | Why: Monitors net FinOps API expenditure and identifies opportunities for prompt cache optimization."
    type: number
    sql: ${TABLE}.usage_cached_tokens ;;
  }

  dimension: context_cache_hit_rate {
    group_label: "Token Usage"
    description: "What: The percentage of the prompt that was served from the cache (cached tokens / total prompt tokens). | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    sql: ${TABLE}.context_cache_hit_rate ;;
  }

  dimension: total_ms {
    group_label: "Latency"
    description: "What: The total wall-clock time in milliseconds the LLM took to process the request and generate the full response. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    sql: ${TABLE}.total_ms ;;
  }

  dimension: ttft_ms {
    group_label: "Latency"
    description: "What: Time To First Token (TTFT). The latency in milliseconds before the LLM began streaming the first token of the response. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: number
    sql: ${TABLE}.ttft_ms ;;
  }

  dimension: model_version {
    group_label: "Event Info"
    description: "What: The specific version of the LLM model used for this request (e.g., 'gemini-2.5-flash'). | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    type: string
    sql: ${TABLE}.model_version ;;
  }

  dimension: dynamic_tier_signal {
    group_label: "Executive FinOps Spend"
    description: "What: Recommends model tier migration based on real-time caching economics (STAY_PRO_CACHED vs MIGRATE_FLASH). | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    type: string
    sql: CASE WHEN ${context_cache_hit_rate} > 0.60 THEN 'STAY_PRO_CACHED' ELSE 'MIGRATE_FLASH' END ;;
  }

  # --- BASE MEASURES ---

  measure: total_tokens_consumed {
    group_label: "Usage & Volume"
    type: sum
    sql: ${usage_total_tokens} ;;
    description: "What: Total tokens consumed across all LLM responses in the selected timeframe. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: [agent_events.timestamp_time, agent_events.agent, agent_events.user_id, agent_events.trace_id, model_version, total_ms]
    
    link: {
      label: "Show Tokens Over Time (Area Chart)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": false, \"interpolation\": \"linear\", \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_tokens_consumed&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Agents (for this selection)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"ordering\": \"none\", \"show_null_labels\": false, \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"show_null_points\": false, \"interpolation\": \"linear\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\" } } \' %}{{ link }}&fields={{ _view._name }}.total_tokens_consumed,agent_events.agent&sorts={{ _view._name }}.total_tokens_consumed+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Users (for this selection)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"ordering\": \"none\", \"show_null_labels\": false, \"show_totals_labels\": false, \"show_silhouette\": false, \"totals_color\": \"#808080\", \"show_null_points\": false, \"interpolation\": \"linear\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\" } } \' %}{{ link }}&fields={{ _view._name }}.total_tokens_consumed,agent_events.user_id&sorts={{ _view._name }}.total_tokens_consumed+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_prompt_tokens {
    group_label: "Usage & Volume"
    type: sum
    sql: ${usage_prompt_tokens} ;;
    description: "What: Total prompt tokens consumed across all LLM responses. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    drill_fields: [agent_events.timestamp_time, agent_events.agent, agent_events.user_id, agent_events.trace_id, model_version, total_ms]
  }

  measure: total_completion_tokens {
    group_label: "Usage & Volume"
    type: sum
    sql: ${usage_completion_tokens} ;;
    description: "What: Total completion (candidate) tokens generated across all LLM responses. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    drill_fields: [agent_events.timestamp_time, agent_events.agent, agent_events.user_id, agent_events.trace_id, model_version, total_ms]
  }

  measure: total_llm_calls {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${pk} ;;
    description: "What: Total number of successful LLM responses. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
    drill_fields: [agent_events.timestamp_time, agent_events.agent, agent_events.user_id, agent_events.trace_id, model_version, total_ms]
    
    link: {
      label: "The Outlier Hunter (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\", \"agent_events.trace_id\": \"#1e8e3e\", \"v_llm_response.total_ms\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.trace_id,{{ _view._name }}.total_llm_calls,{{ _view._name }}.total_tokens_consumed&sorts={{ _view._name }}.total_llm_calls+desc+0&limit=5000&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Deep Log Inspector (Raw Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.user_id,agent_events.agent,{{ _view._name }}.model_version,{{ _view._name }}.usage_total_tokens&sorts=agent_events.timestamp_time+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "User Footprint Over Time (Area Chart)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"trellis\": \"\", \"stacking\": \"normal\", \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"interpolation\": \"monotone\", \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"type\": \"looker_area\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_date,agent_events.user_id,{{ _view._name }}.total_llm_calls&pivots=agent_events.user_id&sorts=agent_events.user_id,agent_events.timestamp_date+desc&limit=500&column_limit=10&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: average_llm_latency {
    group_label: "Performance & Reliability"
    type: average
    sql: ${total_ms} ;;
    description: "What: Average latency for LLM responses in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    value_format_name: decimal_1
    drill_fields: []
    
    link: {
      label: "Latency vs Tokens (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\", \"agent_events.trace_id\": \"#1e8e3e\", \"v_llm_response.total_ms\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.trace_id,{{ _view._name }}.total_ms,{{ _view._name }}.usage_total_tokens&sorts={{ _view._name }}.total_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Slowest Calls (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.usage_total_tokens,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: p50_llm_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 50
    sql: ${total_ms} ;;
    description: "What: Median (P50) latency for LLM responses in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Latency vs Tokens (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\", \"agent_events.trace_id\": \"#1e8e3e\", \"v_llm_response.total_ms\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.trace_id,{{ _view._name }}.total_ms,{{ _view._name }}.usage_total_tokens&sorts={{ _view._name }}.total_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Slowest Calls (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.usage_total_tokens,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: p75_llm_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 75
    sql: ${total_ms} ;;
    description: "What: 75th percentile latency for LLM responses in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
  }

  measure: p90_llm_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 90
    sql: ${total_ms} ;;
    description: "What: 90th percentile latency for LLM responses in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Latency vs Tokens (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\", \"agent_events.trace_id\": \"#1e8e3e\", \"v_llm_response.total_ms\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.trace_id,{{ _view._name }}.total_ms,{{ _view._name }}.usage_total_tokens&sorts={{ _view._name }}.total_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Slowest Calls (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.usage_total_tokens,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }
  
  measure: p99_llm_latency {
    group_label: "Performance & Reliability"
    type: percentile
    percentile: 99
    sql: ${total_ms} ;;
    description: "What: 99th percentile latency for LLM responses in milliseconds. | How: Measured in milliseconds from start timestamp to completion timestamp across trace spans. | Why: Identifies slow tool execution bottlenecks and ensures end-user conversational responsiveness."
    drill_fields: []
    
    link: {
      label: "Latency vs Tokens (Scatter Plot)"
      url: "{% assign vis_config = '{ \"x_axis_gridlines\": false, \"y_axis_gridlines\": true, \"show_view_names\": false, \"show_y_axis_labels\": true, \"show_y_axis_ticks\": true, \"y_axis_tick_density\": \"default\", \"y_axis_tick_density_custom\": 5, \"show_x_axis_label\": true, \"show_x_axis_ticks\": true, \"y_axis_scale_mode\": \"linear\", \"x_axis_reversed\": false, \"y_axis_reversed\": false, \"plot_size_by_field\": false, \"trellis\": \"\", \"stacking\": \"\", \"limit_displayed_rows\": false, \"legend_position\": \"center\", \"point_style\": \"circle\", \"show_value_labels\": false, \"label_density\": 25, \"x_axis_scale\": \"auto\", \"y_axis_combined\": true, \"show_null_points\": true, \"x_axis_zoom\": true, \"y_axis_zoom\": true, \"series_types\": {}, \"series_colors\": {\"v_llm_response.total_tokens_consumed\": \"#e8710a\", \"agent_events.trace_id\": \"#1e8e3e\", \"v_llm_response.total_ms\": \"#e8710a\" } } \' %}{{ link }}&fields=agent_events.trace_id,{{ _view._name }}.total_ms,{{ _view._name }}.usage_total_tokens&sorts={{ _view._name }}.total_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Slowest Calls (Data Table)"
      url: "{% assign vis_config = '{ \"show_view_names\": false, \"show_row_numbers\": true, \"transpose\": false, \"truncate_text\": false, \"hide_totals\": false, \"hide_row_totals\": false, \"size_to_fit\": true, \"table_theme\": \"white\", \"limit_displayed_rows\": false, \"enable_conditional_formatting\": false, \"header_text_alignment\": \"left\", \"header_font_size\": \"12\", \"rows_font_size\": \"12\", \"conditional_formatting_include_totals\": false, \"conditional_formatting_include_nulls\": false, \"show_sql_query_menu_options\": false, \"show_totals\": true, \"show_row_totals\": true, \"truncate_header\": false, \"minimum_column_width\": 75, \"series_cell_visualizations\": {\"v_llm_response.usage_total_tokens\": {\"is_active\": true}}, \"table_show_footer\": false, \"table_enable_pagination\": false, \"table_show_headers\": true, \"type\": \"looker_grid\", \"defaults_version\": 1 }' %}{{ link }}&fields=agent_events.timestamp_time,agent_events.trace_id,agent_events.agent,{{ _view._name }}.usage_total_tokens,{{ _view._name }}.total_ms&sorts={{ _view._name }}.total_ms+desc&limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  # --- POP MEASURES: TOTAL TOKENS ---

  measure: pop_total_tokens_current {
    group_label: "PoP: Total Tokens Consumed"
    type: sum
    sql: ${usage_total_tokens} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total tokens consumed in the currently selected PoP date range. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_total_tokens_previous {
    group_label: "PoP: Total Tokens Consumed"
    type: sum
    sql: ${usage_total_tokens} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total tokens consumed in the previous period of the exact same length. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_total_tokens_change {
    group_label: "PoP: Total Tokens Consumed"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_tokens_current} - ${pop_total_tokens_previous}, ${pop_total_tokens_previous}) ;;
    description: "What: The percentage change in total tokens between the current and previous period. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  # --- POP MEASURES: PROMPT TOKENS ---

  measure: pop_prompt_tokens_current {
    group_label: "PoP: Prompt Tokens"
    type: sum
    sql: ${usage_prompt_tokens} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total prompt tokens consumed in the currently selected PoP date range. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_prompt_tokens_previous {
    group_label: "PoP: Prompt Tokens"
    type: sum
    sql: ${usage_prompt_tokens} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total prompt tokens consumed in the previous period. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_prompt_tokens_change {
    group_label: "PoP: Prompt Tokens"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_prompt_tokens_current} - ${pop_prompt_tokens_previous}, ${pop_prompt_tokens_previous}) ;;
    description: "What: The percentage change in prompt tokens between the current and previous period. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  # --- POP MEASURES: COMPLETION TOKENS ---

  measure: pop_completion_tokens_current {
    group_label: "PoP: Completion Tokens"
    type: sum
    sql: ${usage_completion_tokens} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total completion tokens generated in the currently selected PoP date range. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_completion_tokens_previous {
    group_label: "PoP: Completion Tokens"
    type: sum
    sql: ${usage_completion_tokens} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total completion tokens generated in the previous period. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  measure: pop_completion_tokens_change {
    group_label: "PoP: Completion Tokens"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_completion_tokens_current} - ${pop_completion_tokens_previous}, ${pop_completion_tokens_previous}) ;;
    description: "What: The percentage change in completion tokens between the current and previous period. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
  }

  # --- POP MEASURES: LLM CALLS ---

  measure: pop_llm_calls_current {
    group_label: "PoP: LLM Calls"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_current_period: "yes"]
    description: "What: Total LLM calls in the currently selected PoP date range. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_llm_calls_previous {
    group_label: "PoP: LLM Calls"
    type: count_distinct
    sql: ${pk} ;;
    filters: [agent_events.is_previous_period: "yes"]
    description: "What: Total LLM calls in the previous period. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  measure: pop_llm_calls_change {
    group_label: "PoP: LLM Calls"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_llm_calls_current} - ${pop_llm_calls_previous}, ${pop_llm_calls_previous}) ;;
    description: "What: The percentage change in LLM calls between the current and previous period. | How: Evaluated via LookML SQL extraction or aggregation over BigQuery agent_events telemetry. | Why: Essential for JAPAC PSO agent performance monitoring, FinOps cost attribution, and reliability SLA gating."
  }

  # --- EXECUTIVE FINOPS & DOLLAR SPEND MEASURES ---

  measure: total_spend_usd {
    group_label: "Executive FinOps Spend"
    description: "What: Total actual dollar spend USD applying a 75% discount for Gemini Prompt Caching ($1.25/M standard prompt, $0.3125/M cached prompt, $5.00/M completion). | How: Calculated using Gemini 2.5 Pro pricing rates with 75% prompt cache discount ($0.3125/M cached vs $1.25/M standard input). | Why: Monitors net FinOps API expenditure and identifies opportunities for prompt cache optimization."
    type: number
    value_format_name: usd
    sql: ROUND(SUM((${usage_prompt_tokens} - IFNULL(${usage_cached_tokens}, 0)) * 0.00000125 + (IFNULL(${usage_cached_tokens}, 0) * 0.0000003125) + (${usage_completion_tokens} * 0.00000500)), 4) ;;
  }

  measure: cost_per_session_usd {
    group_label: "Executive FinOps Spend"
    description: "What: Unit economics: average dollar cost per customer session. | How: Calculated using Gemini 2.5 Pro pricing rates with 75% prompt cache discount ($0.3125/M cached vs $1.25/M standard input). | Why: Monitors net FinOps API expenditure and identifies opportunities for prompt cache optimization."
    type: number
    value_format_name: usd
    sql: SAFE_DIVIDE(${total_spend_usd}, NULLIF(${agent_events.total_sessions}, 0)) ;;
  }

  measure: cache_hit_ratio_pct {
    group_label: "Executive FinOps Spend"
    description: "What: Percentage of prompt tokens served directly from Gemini Prompt Caching. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(SUM(${usage_cached_tokens}), NULLIF(SUM(${usage_prompt_tokens}), 0)) ;;
  }

  measure: cache_savings_usd {
    group_label: "Executive FinOps Spend"
    description: "What: Estimated dollar savings from Gemini prompt caching. | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    value_format_name: usd
    sql: ROUND(SUM(${usage_cached_tokens} * 0.00000094), 4) ;;
  }

  measure: cache_discounted_actual_cost_usd {
    group_label: "Executive FinOps Spend"
    description: "What: Total actual dollar spend USD applying Gemini prompt caching discount ($1.25/M standard prompt vs $0.3125/M cached prompt vs $5.00/M completion). | How: Calculated using Gemini 2.5 Pro pricing rates with 75% prompt cache discount ($0.3125/M cached vs $1.25/M standard input). | Why: Monitors net FinOps API expenditure and identifies opportunities for prompt cache optimization."
    type: number
    value_format_name: usd
    sql: ROUND(SUM(
           ((COALESCE(${usage_prompt_tokens}, 0) - COALESCE(${usage_cached_tokens}, 0)) * 1.25 / 1000000.0) +
           (COALESCE(${usage_cached_tokens}, 0) * 0.3125 / 1000000.0) +
           (COALESCE(${usage_completion_tokens}, 0) * 5.00 / 1000000.0)
         ), 6) ;;
  }

  measure: prompt_cache_hit_ratio {
    group_label: "Executive FinOps Spend"
    description: "What: Ratio of prompt tokens served from cache (0.0 to 1.0). | How: SUM of token count fields extracted from LLM usage metadata. | Why: Tracks context window consumption and prompt engineering efficiency across agent workflows."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(SUM(${usage_cached_tokens}), NULLIF(SUM(${usage_prompt_tokens}), 0)) ;;
  }

}