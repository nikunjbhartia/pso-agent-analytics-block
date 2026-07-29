- dashboard: agent_analytics_performance
  title: Agent Analytics - Performance
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: ''
  layout: newspaper
  tabs:
  - name: Latency
    label: Latency
    title: Latency
  - name: Errors
    label: Errors
    title: Errors
  - name: AI Recommendations
    label: AI Recommendations
    title: AI Recommendations
  elements:
  - name: nav_header_latency
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Latency
  - name: nav_header_errors
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Errors
  - name: nav_header_recs
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: AI Recommendations
  - title: Average Tool Latency (ms)
    name: Average Tool Latency (ms)
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Average time in milliseconds for tools to execute.  | How: Average of total_ms across all TOOL_COMPLETED events.  | Why it matters: Monitors backend API performance and user wait time.  | Drill: Click tile to see tool latency breakdown."
    fields: [v_tool_completed.average_tool_latency]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
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

    row: 2
    col: 0
    width: 7
    height: 6
    tab_name: Latency
  - title: Tool Latency Trend
    name: Tool Latency Trend
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Historical trend of tool execution latency over time.  | How: Average of total_ms aggregated by timestamp_date.  | Why it matters: Identifies performance degradation or API slowdowns over time.  | Drill: Click date to inspect daily latency."
    fields: [v_tool_completed.timestamp_date, v_tool_completed.average_tool_latency]
    fill_fields: [v_tool_completed.timestamp_date]
    sorts: [v_tool_completed.timestamp_date desc]
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      v_tool_completed.p50_tool_latency: "#f9ab00"
      v_tool_completed.average_tool_latency: "#f9ab00"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}

    row: 2
    col: 7
    width: 17
    height: 6
    tab_name: Latency
  - title: Average LLM Latency (in ms)
    name: Average LLM Latency (in ms)
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Average round-trip time in milliseconds for LLM requests.  | How: Average of total_ms across all LLM_RESPONSE events.  | Why it matters: Tracks model responsiveness and generation speed.  | Drill: Click tile to see LLM latency trend."
    fields: [v_llm_response.average_llm_latency]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: false
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '14'
    orientation: auto
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    series_colors:
      v_tool_completed.p50_tool_latency: "#f9ab00"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    style_v_tool_completed.p50_tool_latency: "#3A4245"
    show_title_v_tool_completed.p50_tool_latency: true
    title_placement_v_tool_completed.p50_tool_latency: above
    value_format_v_tool_completed.p50_tool_latency: ''
    title_hidden: true

    row: 11
    col: 0
    width: 8
    height: 6
    tab_name: Latency
  - title: LLM Latency Trend
    name: LLM Latency Trend
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Historical trend of LLM response times over time.  | How: Average of total_ms aggregated by timestamp_date.  | Why it matters: Monitors API latency anomalies across Gemini model versions.  | Drill: Click date to inspect LLM latency."
    fields: [v_llm_response.average_llm_latency, agent_events.timestamp_date]
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
    series_colors:
      v_tool_completed.p50_tool_latency: "#f9ab00"
      v_llm_response.average_llm_latency: "#e8710a"
    series_labels: {}
    font_size_main: '14'
    orientation: auto
    hidden_fields: []
    hidden_points_if_no: []
    ordering: none
    show_null_labels: false
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    style_v_tool_completed.p50_tool_latency: "#3A4245"
    show_title_v_tool_completed.p50_tool_latency: true
    title_placement_v_tool_completed.p50_tool_latency: above
    value_format_v_tool_completed.p50_tool_latency: ''
    style_v_llm_response.average_llm_latency: "#3A4245"
    show_title_v_llm_response.average_llm_latency: true
    title_placement_v_llm_response.average_llm_latency: above
    value_format_v_llm_response.average_llm_latency: ''

    row: 11
    col: 8
    width: 16
    height: 6
    tab_name: Latency
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Tool Latency"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 6
    width: 13
    height: 2
    tab_name: Latency
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"LLM Latency"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 13
    col: 0
    width: 24
    height: 2
    tab_name: Latency
  - type: button
    name: button_871
    rich_content_json: '{"text":"Usage Report","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#E52592","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 19
    width: 5
    height: 2
    tab_name: Latency
  - title: P50 Tool Latency
    name: P50 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Median (50th percentile) tool execution latency in milliseconds.  | How: 50th percentile of total_ms across TOOL_COMPLETED events.  | Why it matters: Reflects typical user experience for tool executions.  | Drill: Click tile to inspect median tool latency."
    fields: [v_tool_completed.p50_tool_latency, v_tool_completed.p75_tool_latency,
      v_tool_completed.p90_tool_latency, v_tool_completed.p99_tool_latency]
    filters:
      agent_events.agent: ''
      agent_events.span_id: ''
      agent_events.trace_id: ''
      agent_events.user_id: ''
      agent_events.timestamp_date: 7 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    global_tooltip_options:
      custom_tooltips_enabled: false
      template: |2-

        <div class="section">
          <div class="header">P50 Tool Latency</div>
          <div class="value">{{ v_tool_completed.p50_tool_latency }}</div>
        </div>
        <div class="section">
          <div class="header">P75 Tool Latency</div>
          <div class="value">{{ v_tool_completed.p75_tool_latency }}</div>
        </div>
        <div class="section">
          <div class="header">P90 Tool Latency</div>
          <div class="value">{{ v_tool_completed.p90_tool_latency }}</div>
        </div>
        <div class="section">
          <div class="header">P99 Tool Latency</div>
          <div class="value">{{ v_tool_completed.p99_tool_latency }}</div>
        </div>
      style:
        font_size: 12
        font_family: Roboto, 'Noto Sans', 'Noto Sans JP', 'Noto Sans CJK KR', 'Noto
          Sans Arabic UI', 'Noto Sans Devanagari UI', 'Noto Sans Hebrew', 'Noto Sans
          Thai UI', Helvetica, Arial, sans-serif
        font_color: "#FFFFFF"
        background_color: "#262D33"
        border_radius: 4
        border_color: transparent
        box_shadow: none
        align: left
    single_value_title: P50 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p75_tool_latency, v_tool_completed.p90_tool_latency,
      v_tool_completed.p99_tool_latency]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '14'
    orientation: auto
    style_v_tool_completed.p50_tool_latency: "#3A4245"
    show_title_v_tool_completed.p50_tool_latency: true
    title_placement_v_tool_completed.p50_tool_latency: above
    value_format_v_tool_completed.p50_tool_latency: ''
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    series_colors:
      v_tool_completed.p50_tool_latency: "#f9ab00"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    style_v_tool_completed.p90_tool_latency: "#3A4245"
    show_title_v_tool_completed.p90_tool_latency: true
    title_placement_v_tool_completed.p90_tool_latency: above
    value_format_v_tool_completed.p90_tool_latency: ''
    show_comparison_v_tool_completed.p90_tool_latency: false
    style_v_tool_completed.p99_tool_latency: "#3A4245"
    show_title_v_tool_completed.p99_tool_latency: true
    title_placement_v_tool_completed.p99_tool_latency: above
    value_format_v_tool_completed.p99_tool_latency: ''
    show_comparison_v_tool_completed.p99_tool_latency: false

    row: 8
    col: 0
    width: 6
    height: 3
    tab_name: Latency
  - title: P75 Tool Latency
    name: P75 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 75th percentile tool execution latency in milliseconds.  | How: 75th percentile of total_ms across TOOL_COMPLETED events.  | Why it matters: Reflects latency for the slower quartile of tool executions.  | Drill: Click tile to view P75 breakdown."
    fields: [v_tool_completed.p50_tool_latency, v_tool_completed.p75_tool_latency,
      v_tool_completed.p90_tool_latency, v_tool_completed.p99_tool_latency]
  