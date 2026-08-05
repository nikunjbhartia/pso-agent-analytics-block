- dashboard: agent_analytics_usage
  title: "Agent Analytics - Usage"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: "''"
  tabs:
  - name: "Agent & Sessions"
    label: "Agent & Sessions"
    title: "Agent & Sessions"
  - name: "LLM & Token Economics"
    label: "LLM & Token Economics"
    title: "LLM & Token Economics"
  - name: "Tool Usage & Provenance"
    label: "Tool Usage & Provenance"
    title: "Tool Usage & Provenance"
  - name: "Conversation & Lineage"
    label: "Conversation & Lineage"
    title: "Conversation & Lineage"

  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: "last 30 days"
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.timestamp_date
  - name: Trace ID
    title: Trace ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.trace_id
  - name: Agent
    title: Agent
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.agent
  - name: User ID
    title: User ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.user_id
  - name: Span ID
    title: Span ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.span_id

  elements:
  - type: button
    name: "nav_btn_portal_Agent_and_Sessions"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: "Agent & Sessions"
  - type: button
    name: "nav_btn_perf_Agent_and_Sessions"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 4
    width: 4
    height: 1
    tab_name: "Agent & Sessions"
  - type: button
    name: "nav_btn_portal_LLM_and_Token_Economics"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: "LLM & Token Economics"
  - type: button
    name: "nav_btn_perf_LLM_and_Token_Economics"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 4
    width: 4
    height: 1
    tab_name: "LLM & Token Economics"
  - type: button
    name: "nav_btn_portal_Tool_Usage_and_Provenance"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: "Tool Usage & Provenance"
  - type: button
    name: "nav_btn_perf_Tool_Usage_and_Provenance"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 4
    width: 4
    height: 1
    tab_name: "Tool Usage & Provenance"
  - type: button
    name: "nav_btn_portal_Conversation_and_Lineage"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: "Conversation & Lineage"
  - type: button
    name: "nav_btn_perf_Conversation_and_Lineage"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 4
    width: 4
    height: 1
    tab_name: "Conversation & Lineage"
  - name: "Token Usage split by Agent"
    type: looker_pie
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.agent, v_llm_response.total_tokens_consumed]
    filters:
      v_llm_response.total_tokens_consumed: NOT NULL
    sorts: [v_llm_response.total_tokens_consumed desc]
    limit: 5
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Breakdown of total token consumption across agents.  <br><br>How: SUM(usage_total_tokens) grouped by agent.  <br><br>Why it matters: Identifies token-heavy agents for optimization.  <br><br>Drill: Click agent bar to inspect token split.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 9
    col: 12
    width: 12
    height: 7
  - name: "Top 5 users with most Tokens consumption"
    type: looker_bar
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.user_id, v_llm_response.total_tokens_consumed]
    filters:
      agent_events.timestamp_date: 7 days
    limit: 5
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_pivots: {}
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 users by token usage.  <br><br>How: SUM(usage_total_tokens) grouped by user_id.  <br><br>Why it matters: Highlights power users and token distribution.  <br><br>Drill: Click user bar to view user session history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 12
    width: 12
    height: 7
  - name: "Total Tokens Consumption Over the Time"
    type: looker_area
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_llm_response.total_tokens_consumed, agent_events.timestamp_date]
    fill_fields: [agent_events.timestamp_date]
    sorts: [agent_events.timestamp_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    v_llm_response.total_tokens_consumed: "#e8710a"
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Daily time-series area chart tracking token consumption over time.  <br><br>How: SUM(usage_total_tokens) aggregated by timestamp_date.  <br><br>Why it matters: Monitors platform adoption and API quota utilization.  <br><br>Drill: Click date point to inspect daily traffic.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "Total Tokens"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_llm_response.pop_total_tokens_current, v_llm_response.pop_total_tokens_change]
    filters:
      agent_events.pop_date_filter: 14 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: VS Previous Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    v_llm_response.total_tokens_consumed: "#e8710a"
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Total aggregate number of tokens consumed across all sessions.  <br><br>How: SUM(usage_prompt_tokens + usage_completion_tokens).  <br><br>Why it matters: Core top-line consumption metric.  <br><br>Drill: Click tile to see token trend.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "Top 5 users with most Traces"
    type: looker_bar
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.user_id, agent_events.total_traces]
    filters:
      agent_events.timestamp_date: 7 days
    sorts: [agent_events.total_traces desc 0]
    limit: 5
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 power users by trace volume.  <br><br>How: COUNT DISTINCT of trace_id grouped by user_id.  <br><br>Why it matters: Shows which users execute the deepest multi-turn workflows.  <br><br>Drill: Click user to inspect trace logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 13
    col: 0
    width: 12
    height: 7
  - name: "Total Traces"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.pop_total_traces_current, agent_events.pop_total_traces_change]
    filters:
      agent_events.pop_date_filter: 14 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: VS Previous Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    v_llm_response.total_tokens_consumed: "#e8710a"
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Total number of execution traces recorded.  <br><br>How: COUNT DISTINCT of trace_id across all sessions.  <br><br>Why it matters: Measures overall end-to-end workflow invocations.  <br><br>Drill: Click tile to filter by agent.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Traces split by Agent"
    type: looker_column
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.agent, agent_events.total_traces]
    filters:
      v_llm_response.total_tokens_consumed: NOT NULL
    sorts: [agent_events.total_traces desc 0]
    limit: 5
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    note_text: "<div style='text-align: left;'>What: Distribution of trace volume across agents.  <br><br>How: COUNT DISTINCT of trace_id grouped by agent.  <br><br>Why it matters: Reveals traffic distribution across agent workloads.  <br><br>Drill: Click agent to filter dashboard.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 22
    col: 0
    width: 24
    height: 7
  - name: "Total Traces Generation Over the Time"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.timestamp_date, agent_events.total_traces]
    fill_fields: [agent_events.timestamp_date]
    sorts: [agent_events.timestamp_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    v_llm_response.total_tokens_consumed: "#1e8e3e"
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Daily trend of trace volume generated over time.  <br><br>How: COUNT DISTINCT of trace_id aggregated by timestamp_date.  <br><br>Why it matters: Tracks platform engagement growth over time.  <br><br>Drill: Click date to inspect daily traces.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Total Sessions"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.pop_total_sessions_current, agent_events.pop_total_sessions_change]
    filters:
      agent_events.pop_date_filter: 7 days
      agent_events.agent: ''
      agent_events.span_id: ''
      agent_events.trace_id: ''
      agent_events.user_id: ''
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs Last Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    note_text: "<div style='text-align: left;'>What: Total count of end-to-end user sessions.  <br><br>How: COUNT DISTINCT of session_id.  <br><br>Why it matters: Primary measure of active customer conversations.  <br><br>Drill: Click tile to view session breakdown.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 0
    width: 8
    height: 4
  - name: "Number of Sessions Trend"
    type: looker_area
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_sessions, agent_events.timestamp_date]
    fill_fields: [agent_events.timestamp_date]
    filters:
      agent_events.agent: ''
      agent_events.span_id: ''
      agent_events.trace_id: ''
      agent_events.user_id: ''
      agent_events.timestamp_date: 7 days
    sorts: [agent_events.timestamp_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_sessions: "#e52592"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs Last Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Daily time-series trend of user session volume over time.  <br><br>How: COUNT DISTINCT of session_id aggregated by timestamp_date.  <br><br>Why it matters: Shows daily conversational adoption.  <br><br>Drill: Click date to inspect sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 6
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Agents Split by Session Count"
    type: looker_column
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_sessions, agent_events.agent]
    filters:
      agent_events.agent: ''
      agent_events.span_id: ''
      agent_events.trace_id: ''
      agent_events.user_id: ''
      agent_events.timestamp_date: 7 days
    sorts: [agent_events.total_sessions desc 0]
    limit: 5
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_sessions: "#e8710a"
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs Last Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 agents by number of sessions.  <br><br>How: COUNT DISTINCT of session_id grouped by agent.  <br><br>Why it matters: Identifies the most popular conversational agents.  <br><br>Drill: Click agent to filter sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 13
    col: 12
    width: 12
    height: 7
  - name: "Total Agent Transfers"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_agent_transfer.total_agent_transfers]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    note_text: "<div style='text-align: left;'>What: Total count of multi-agent delegation and handoff events.  <br><br>How: COUNT of AGENT_TRANSFER events from v_agent_transfer.  <br><br>Why it matters: Tracks multi-agent supervisor-worker collaboration.  <br><br>Drill: Click tile to view transfer matrix.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 0
    width: 8
    height: 4
  - name: "Total A2A Interactions"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_a2a_interaction.total_a2a_interactions]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    note_text: "<div style='text-align: left;'>What: Total count of Agent-to-Agent protocol communication events.  <br><br>How: COUNT of A2A_INTERACTION events from v_a2a_interaction.  <br><br>Why it matters: Measures decentralized agent-to-agent protocol traffic.  <br><br>Drill: Click tile to view A2A tasks.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Total HITL Confirmation Requests"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_hitl_confirmation_request.total_hitl_confirmation_requests]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    note_text: "<div style='text-align: left;'>What: Total count of Human-In-The-Loop confirmation requests.  <br><br>How: COUNT of HITL_CONFIRMATION_REQUEST events from v_hitl_confirmation_request.  <br><br>Why it matters: Measures where human governance and sign-off occur.  <br><br>Drill: Click tile to view HITL tools.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 16
    width: 8
    height: 4
  - name: "Tool Invocations"
    type: looker_bar
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_invocations, v_tool_completed.tool_name]
    filters:
      v_tool_completed.tool_name: "-NULL"
    sorts: [agent_events.total_invocations desc]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    defaults_version: 1
    series_colors:
      v_tool_completed.p50_tool_latency: "#12B5CB"
      v_tool_completed.p75_tool_latency: "#1A73E8"
    note_text: "<div style='text-align: left;'>What: Ranking of backend tools by invocation frequency.  <br><br>How: COUNT of TOOL_COMPLETED events grouped by tool_name.  <br><br>Why it matters: Highlights which APIs and integrations are relied upon most.  <br><br>Drill: Click tool to view latency and error rate.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 2
    col: 12
    width: 12
    height: 7
  - name: "Events By Agent"
    type: looker_column
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_events, agent_events.agent]
    filters:
      agent_events.event_type: '"TOOL_COMPLETED"'
    sorts: [agent_events.total_events desc 0]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Breakdown of total lifecycle events across agents.  <br><br>How: COUNT of raw event rows grouped by agent.  <br><br>Why it matters: Shows raw telemetry volume per agent.  <br><br>Drill: Click agent to filter events.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 17
    col: 12
    width: 12
    height: 7
  - name: "Tool Calls Over Time"
    type: looker_column
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_events, v_tool_completed.tool_name, agent_events.timestamp_date]
    pivots: [v_tool_completed.tool_name]
    fill_fields: [agent_events.timestamp_date]
    filters:
      agent_events.event_type: '"TOOL_COMPLETED"'
      agent_events.timestamp_date: 14 days
    sorts: [v_tool_completed.tool_name, agent_events.timestamp_date desc]
    limit: 5000
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    series_colors:
      v_tool_completed.p50_tool_latency: "#12B5CB"
      v_tool_completed.p75_tool_latency: "#1A73E8"
    note_text: "<div style='text-align: left;'>What: Daily execution trend of specific tools over time.  <br><br>How: COUNT of TOOL_COMPLETED events aggregated by timestamp_date and tool_name.  <br><br>Why it matters: Reveals evolving tool usage patterns over time.  <br><br>Drill: Click date/tool to inspect executions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 6
    col: 0
    width: 12
    height: 7
  - name: "Total Calls"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_llm_response.pop_llm_calls_current, v_llm_response.pop_llm_calls_change]
    filters:
      agent_events.pop_date_filter: 7 days
    limit: 5000
    column_limit: 5
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: V Previous Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Absolute count of requests sent to backend tools.  <br><br>How: COUNT of TOOL_COMPLETED events.  <br><br>Why it matters: Overall volume of external tool and API executions.  <br><br>Drill: Click tile to inspect tools.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "LLM Call Trends"
    type: looker_line
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_llm_response.total_llm_calls, agent_events.timestamp_minute]
    fill_fields: [agent_events.timestamp_minute]
    filters:
      agent_events.timestamp_date: 7 days
    sorts: [agent_events.timestamp_minute desc]
    limit: 5000
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#8ab4f8"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: V Previous Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Granular scatter plot showing frequency and clustering of LLM requests.  <br><br>How: Plots individual LLM_RESPONSE events over time.  <br><br>Why it matters: Identifies peak usage periods and request density.  <br><br>Drill: Select time range to filter LLM calls.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 13
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Agents by LLM Calls"
    type: looker_column
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [v_llm_response.total_llm_calls, agent_events.agent]
    filters:
      agent_events.timestamp_date: 7 days
    sorts: [v_llm_response.total_llm_calls desc 0]
    limit: 500
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#f28b82"
    show_null_points: true
    interpolation: monotone
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: V Previous Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Ranking of agents triggering the most LLM calls.  <br><br>How: COUNT of LLM_RESPONSE events grouped by agent.  <br><br>Why it matters: Identifies agents driving backend LLM load.  <br><br>Drill: Click agent to inspect LLM calls.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 16
    col: 12
    width: 12
    height: 7
  - name: "Total Users"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.pop_total_users_current, agent_events.pop_total_users_change]
    filters:
      agent_events.pop_date_filter: 7 days
    limit: 500
    column_limit: 5
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#f28b82"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: monotone
    comparison_label: V Previous Period
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Count of unique end users who interacted with agents.  <br><br>How: COUNT DISTINCT of user_id.  <br><br>Why it matters: Primary user adoption and penetration metric.  <br><br>Drill: Click tile to see user growth.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 16
    width: 8
    height: 4
  - name: "User Growth Over Time"
    type: looker_line
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.total_users, agent_events.timestamp_date]
    fill_fields: [agent_events.timestamp_date]
    filters:
      agent_events.timestamp_date: 7 days
    sorts: [agent_events.timestamp_date desc]
    limit: 500
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#f28b82"
    agent_events.total_users: "#1e8e3e"
    ordering: none
    show_null_labels: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: V Previous Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Daily count of active unique users over time.  <br><br>How: COUNT DISTINCT of user_id aggregated by timestamp_date.  <br><br>Why it matters: Measures DAU retention and adoption velocity.  <br><br>Drill: Click date to inspect active users.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 20
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Users by Session"
    type: looker_bar
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.user_id, agent_events.total_sessions]
    sorts: [agent_events.total_sessions desc 0]
    limit: 5
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: monotone
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#e8710a"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#f28b82"
    agent_events.total_users: "#1e8e3e"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: V Previous Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Leaderboard of power users by session count.  <br><br>How: COUNT DISTINCT of session_id grouped by user_id.  <br><br>Why it matters: Highlights champions and power users.  <br><br>Drill: Click user to inspect sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 20
    col: 12
    width: 12
    height: 7
  - name: "Top 5 Users by Events"
    type: looker_bar
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_state: collapsed
    note_display: hover
    fields: [agent_events.user_id, agent_events.total_events]
    sorts: [agent_events.total_events desc 0]
    limit: 5
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    agent_events.total_invocations: "#1e8e3e"
    agent_events.total_events: "#f9ab00"
    execute_sql - agent_events.total_events: "#e8710a"
    v_llm_response.total_llm_calls: "#f28b82"
    agent_events.total_users: "#1e8e3e"
    show_null_points: false
    interpolation: monotone
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: V Previous Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    note_text: "<div style='text-align: left;'>What: Ranking of users by raw volume of lifecycle events generated.  <br><br>How: COUNT of event rows grouped by user_id.  <br><br>Why it matters: Identifies users running the most intensive agent workflows.  <br><br>Drill: Click user to inspect event logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 27
    col: 0
    width: 12
    height: 7
  - name: "GCS Multimodal Bucket Offloading & Object Table Content"
    type: looker_grid
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [v_gcs_multimodal_offload.asset_type, gcs_multimodal_object_table.content_type]
    measures: [v_gcs_multimodal_offload.total_gcs_offloaded_assets, gcs_multimodal_object_table.total_size_bytes]
    sorts: [v_gcs_multimodal_offload.total_gcs_offloaded_assets desc]
    series_colors:
      v_tool_completed.p50_tool_latency: "#12B5CB"
      v_tool_completed.p75_tool_latency: "#1A73E8"
    note_text: "<div style='text-align: left;'>What: Breakdown of multimodal payloads and large objects offloaded to GCS bucket japac-pso-agent-analytics.  <br><br>How: Aggregates offloaded GCS URIs by asset_type (IMAGE, DOCUMENT, AUDIO, VIDEO, LARGE_PAYLOAD_JSON) and event_type.  <br><br>Why it matters: Monitors multimodal storage footprint and BigQuery object table ingestion.  <br><br>Drill: Click asset type bar to inspect specific GCS URIs and traces.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 9
    col: 0
    width: 24
    height: 8
  - name: "Conversation Analytics: Multi-Turn Interaction Flow & Token Latency"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.session_id, agent_events.event_type, agent_events.agent, v_tool_completed.tool_name, agent_events.status]
    measures: [v_llm_response.total_tokens_consumed, agent_events.total_events]
    sorts: [agent_events.session_id desc, agent_events.total_events desc]
    limit: 50
    series_colors:
      v_llm_response.total_tokens_consumed: "#A142F4"
      agent_events.total_llm_calls: "#12B5CB"
    note_text: "<div style='text-align: left;'>What: Turn-by-turn breakdown of user prompts, agent responses, tool calls, and token/latency metrics.  <br><br>How: Queries agent_events joined with v_llm_response, v_tool_completed, and v_agent_evaluation.  <br><br>Why it matters: Enables granular conversational analytics and turn debugging across sessions.  <br><br>Drill: Click Session ID to inspect full conversation history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 6
    col: 0
    width: 24
    height: 8
  - name: "Multi-Agent DAG Delegation & Decision Paths"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.session_id, v_agent_transfer.from_agent, v_agent_transfer.to_agent]
    measures: [agent_events.total_events]
    sorts: [agent_events.total_events desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Visual trace DAG and conversation lineage showing how agents delegate tasks to tools and subagents. <br><br>How it is calculated: Hierarchical trace and span ID relationships captured by open-telemetry plugins. <br><br>Why it matters: Allows engineering teams to debug execution paths and verify multi-agent delegation logic. <br><br>Drill down: Click a node to trace full session history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 14
    col: 0
    width: 24
    height: 8
  - name: "Real-Time UDF Evaluation Scorecard"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: udf_realtime_scorecard
    truncate_text: no
    wrap_text: yes
    fields: [udf_realtime_scorecard.practice_area, udf_realtime_scorecard.agent, udf_realtime_scorecard.total_sessions, udf_realtime_scorecard.total_spans, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score, udf_realtime_scorecard.avg_token_efficiency_score, udf_realtime_scorecard.avg_cost_score, udf_realtime_scorecard.avg_error_rate_score]
    sorts: [udf_realtime_scorecard.total_sessions desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    tab_name: "LLM & Token Economics"
    row: 23
    col: 0
    width: 24
    height: 8
  - name: "Interactive SQL-Driven Trace Drilldown"
    type: looker_grid
    model: bigquery_agent_analytics_model
    explore: remote_function_trace_drilldown
    truncate_text: no
    wrap_text: yes
    fields: [remote_function_trace_drilldown.session_id, remote_function_trace_drilldown.agent, remote_function_trace_drilldown.session_start_time, remote_function_trace_drilldown.span_count, remote_function_trace_drilldown.error_count, remote_function_trace_drilldown.sdk_version, remote_function_trace_drilldown.analyzed_session_id]
    sorts: [remote_function_trace_drilldown.session_start_time desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    tab_name: "Tool Usage & Provenance"
    row: 20
    col: 0
    width: 24
    height: 8
  - name: "Production vs Baseline Drift Scorecard"
    type: single_value
    model: bigquery_agent_analytics_model
    explore: remote_function_drift_scorecard
    truncate_text: no
    wrap_text: yes
    fields: [remote_function_drift_scorecard.comparison_tier, remote_function_drift_scorecard.drift_metric, remote_function_drift_scorecard.kolmogorov_smirnov_stat, remote_function_drift_scorecard.p_value, remote_function_drift_scorecard.drift_status, remote_function_drift_scorecard.last_evaluated_date]
    sorts: [remote_function_drift_scorecard.drift_metric]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    tab_name: "LLM & Token Economics"
    row: 31
    col: 0
    width: 24
    height: 7
