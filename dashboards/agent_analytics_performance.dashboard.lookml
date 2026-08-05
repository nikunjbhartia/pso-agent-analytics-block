- dashboard: agent_analytics_performance
  title: Agent Analytics - Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: ''
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
  - name: Tool Name
    title: Tool Name
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: v_tool_completed.tool_name

  elements:
  - type: button
    name: nav_btn_portal_Latency
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: Latency
  - type: button
    name: nav_btn_usage_Latency
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: Latency
  - type: button
    name: nav_btn_portal_Errors
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: Errors
  - type: button
    name: nav_btn_usage_Errors
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: Errors
  - type: button
    name: nav_btn_portal_AI_Recommendations
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: AI Recommendations
  - type: button
    name: nav_btn_usage_AI_Recommendations
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: AI Recommendations
  - name: Average Tool Latency (ms)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Average time in milliseconds for tools to execute.  <br><br>How: Average of total_ms across all TOOL_COMPLETED events.  <br><br>Why it matters: Monitors backend API performance and user wait time.  <br><br>Drill: Click tile to see tool latency breakdown.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 2
    col: 0
    width: 8
    height: 4
  - name: Tool Latency Trend
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Historical trend of tool execution latency over time.  <br><br>How: Average of total_ms aggregated by timestamp_date.  <br><br>Why it matters: Identifies performance degradation or API slowdowns over time.  <br><br>Drill: Click date to inspect daily latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 10
    col: 0
    width: 24
    height: 7
  - name: Average LLM Latency (in ms)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Average round-trip time in milliseconds for LLM requests.  <br><br>How: Average of total_ms across all LLM_RESPONSE events.  <br><br>Why it matters: Tracks model responsiveness and generation speed.  <br><br>Drill: Click tile to see LLM latency trend.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 17
    col: 0
    width: 8
    height: 4
  - name: LLM Latency Trend
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Historical trend of LLM response times over time.  <br><br>How: Average of total_ms aggregated by timestamp_date.  <br><br>Why it matters: Monitors API latency anomalies across Gemini model versions.  <br><br>Drill: Click date to inspect LLM latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 25
    col: 0
    width: 24
    height: 7
  - name: P50 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    align: left
    single_value_title: P50 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p75_tool_latency, v_tool_completed.p90_tool_latency,
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
    note_text: "<div style='text-align: left;'>What: Median (50th percentile) tool execution latency in milliseconds.  <br><br>How: 50th percentile of total_ms across TOOL_COMPLETED events.  <br><br>Why it matters: Reflects typical user experience for tool executions.  <br><br>Drill: Click tile to inspect median tool latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 2
    col: 8
    width: 8
    height: 4
  - name: P75 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    align: left
    single_value_title: P75 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p90_tool_latency, v_tool_completed.p99_tool_latency,
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
    note_text: "<div style='text-align: left;'>What: 75th percentile tool execution latency in milliseconds.  <br><br>How: 75th percentile of total_ms across TOOL_COMPLETED events.  <br><br>Why it matters: Reflects latency for the slower quartile of tool executions.  <br><br>Drill: Click tile to view P75 breakdown.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 2
    col: 16
    width: 8
    height: 4
  - name: P90 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    align: left
    single_value_title: P90 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p99_tool_latency, v_tool_completed.p50_tool_latency,
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
    note_text: "<div style='text-align: left;'>What: 90th percentile tool execution latency in milliseconds.  <br><br>How: 90th percentile of total_ms across TOOL_COMPLETED events.  <br><br>Why it matters: Identifies tail latency affecting the 10% slowest tool calls.  <br><br>Drill: Click tile to inspect P90 latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 6
    col: 0
    width: 12
    height: 4
  - name: P99 Tool Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    align: left
    single_value_title: P99 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p50_tool_latency, v_tool_completed.p75_tool_latency,
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
    note_text: "<div style='text-align: left;'>What: 99th percentile (tail latency) tool execution latency in milliseconds.  <br><br>How: 99th percentile of total_ms across TOOL_COMPLETED events.  <br><br>Why it matters: Critical SRE metric for worst-case API timeouts and delays.  <br><br>Drill: Click tile to inspect P99 tail latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 6
    col: 12
    width: 12
    height: 4
  - name: P50 Llm Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Median (50th percentile) LLM response latency in milliseconds.  <br><br>How: 50th percentile of total_ms across LLM_RESPONSE events.  <br><br>Why it matters: Core responsiveness KPI for conversational agents.  <br><br>Drill: Click tile to see P50 trend.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 17
    col: 8
    width: 8
    height: 4
  - name: P75 Llm Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: 75th percentile LLM response latency in milliseconds.  <br><br>How: 75th percentile of total_ms across LLM_RESPONSE events.  <br><br>Why it matters: Tracks generation speed for longer context prompts.  <br><br>Drill: Click tile to inspect P75 latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 17
    col: 16
    width: 8
    height: 4
  - name: P90 Llm Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: 90th percentile LLM response latency in milliseconds.  <br><br>How: 90th percentile of total_ms across LLM_RESPONSE events.  <br><br>Why it matters: Identifies slow LLM responses impacting user experience.  <br><br>Drill: Click tile to see P90 trend.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 21
    col: 0
    width: 12
    height: 4
  - name: P99 Llm Latency
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: 99th percentile (tail latency) LLM response latency in milliseconds.  <br><br>How: 99th percentile of total_ms across LLM_RESPONSE events.  <br><br>Why it matters: Critical SLA metric for tail LLM response delays.  <br><br>Drill: Click tile to inspect P99 tail latency.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Latency
    row: 21
    col: 12
    width: 12
    height: 4
  - name: Total Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of backend tool execution errors.  <br><br>How: COUNT of TOOL_ERROR events.  <br><br>Why it matters: Identifies API failures and integration instability.  <br><br>Drill: Click tile to inspect error logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 2
    col: 0
    width: 12
    height: 4
  - name: Tool Errors Trend
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily time-series tracking volume of tool failures.  <br><br>How: COUNT of TOOL_ERROR events aggregated by timestamp_date.  <br><br>Why it matters: Reveals error spikes and system instability over time.  <br><br>Drill: Click date spike to view failing tools.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 6
    col: 0
    width: 24
    height: 7
  - name: Top 5 Agents By Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Ranking of agents by number of tool errors encountered.  <br><br>How: COUNT of TOOL_ERROR events grouped by agent.  <br><br>Why it matters: Shows which agents experience the most tool failures.  <br><br>Drill: Click agent to filter error logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 13
    col: 0
    width: 12
    height: 7
  - name: Top 5 Tools by Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Leaderboard of the most unstable backend tools.  <br><br>How: COUNT of TOOL_ERROR events grouped by tool_name.  <br><br>Why it matters: Focuses debugging efforts on the most error-prone APIs.  <br><br>Drill: Click tool to inspect error tracebacks.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 13
    col: 12
    width: 12
    height: 7
  - name: Total Agent Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of agent-level execution errors and crashes.  <br><br>How: COUNT of AGENT_ERROR events from v_agent_error.  <br><br>Why it matters: Core measure of overall agent execution stability.  <br><br>Drill: Click tile to inspect error tracebacks.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 20
    col: 0
    width: 24
    height: 7
  - name: Self-Healing Resilience Rate (%)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What it is: The percentage of agent tool errors that were automatically self-corrected and resolved by the AI agent without human intervention. <br><br>How it is calculated: Automatically recovered tool errors divided by total tool errors. <br><br>Why it matters: Measures how resilient and self-reliant our AI agents are when encountering temporary API or network glitches. <br><br>Drill down: Click this tile to see resilience performance across individual agents.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 2
    col: 12
    width: 12
    height: 4
  - name: LLM-as-a-Judge Avg Quality Score (%)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Qualitative LLM-as-a-Judge evaluation score (0-100%).  <br><br>How: Evaluates response accuracy, relevance, and tool faithfulness.  <br><br>Why it matters: Assures high conversational quality and correctness.  <br><br>Drill: Click tile to inspect evaluation scorecards.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: AI Recommendations
    row: 2
    col: 0
    width: 8
    height: 4
  - name: User Feedback Satisfaction Rate (%)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Percentage of positive user feedback ratings.  <br><br>How: COUNTIF(user_feedback_rating = 'THUMBS_UP') / COUNT(1) * 100.0.  <br><br>Why it matters: Directly measures customer happiness and satisfaction.  <br><br>Drill: Click tile to view user feedback records.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: AI Recommendations
    row: 2
    col: 8
    width: 8
    height: 4
  - name: Self-Correction Loop Success Rate (%)
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Rate at which agents successfully self-correct and recover after encountering an error.  <br><br>How: Percentage of recovered SUCCESS sessions that followed an ERROR event.  <br><br>Why it matters: Demonstrates autonomous self-healing and error recovery.  <br><br>Drill: Click tile to view recovered sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: AI Recommendations
    row: 2
    col: 16
    width: 8
    height: 4
  - name: Enterprise Edge-Case: A2A Circular Delegation Ping-Pong Loops
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [v_session_trace_dag.session_id, v_session_trace_dag.from_agent, v_session_trace_dag.to_target, v_session_trace_dag.is_circular_delegation]
    measures: [v_session_trace_dag.circular_loop_count, v_session_trace_dag.avg_dag_hop_latency_ms]
    filters:
      v_session_trace_dag.is_circular_delegation: "YES - CIRCULAR LOOP"
    sorts: [v_session_trace_dag.circular_loop_count desc]
    note_text: "<div style='text-align: left;'>What: Highlights recursive A2A delegation loops between agents.  <br><br>How: Filters where from_agent equals to_target.  <br><br>Why it matters: Detects infinite orchestration ping-pong loops that bloat token consumption.  <br><br>Drill: Filter by Session ID to inspect full trace stack.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 27
    col: 0
    width: 24
    height: 8
  - name: Enterprise Edge-Case: HITL Confirmation Request Volume & Latency
    type: looker_column
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.timestamp_date, v_hitl_confirmation_request.tool_name]
    measures: [v_hitl_confirmation_request.total_hitl_confirmation_requests]
    sorts: [agent_events.timestamp_date asc]
    note_text: "<div style='text-align: left;'>What: Tracks Human-In-The-Loop confirmation request volume and latency.  <br><br>How: Aggregates HITL_CONFIRMATION_REQUEST events by tool_name and date.  <br><br>Why it matters: Identifies where workflows pause awaiting human sign-off.  <br><br>Drill: Filter by Date or Tool Name.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 35
    col: 0
    width: 24
    height: 8
  - name: Enterprise Edge-Case: Tool Error Breakdown by Failing Function
    type: looker_bar
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [v_tool_error.tool_name]
    measures: [v_tool_error.total_tool_errors]
    sorts: [v_tool_error.total_tool_errors desc]
    note_text: "<div style='text-align: left;'>What: Breakdown of failing backend tools and error counts.  <br><br>How: Aggregates TOOL_ERROR occurrences by tool_name.  <br><br>Why it matters: Focuses SRE remediation on the most unstable API integrations.  <br><br>Drill: Filter by Tool Name.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: Errors
    row: 43
    col: 0
    width: 24
    height: 8
  - name: LLM-as-a-Judge: Actionable Model Improvement Recommendations
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.canonical_agent_name, v_agent_evaluation.judge_improvement_recommendation]
    measures: [v_agent_evaluation.avg_judge_quality_score, v_agent_evaluation.feedback_satisfaction_rate_pct]
    sorts: [v_agent_evaluation.avg_judge_quality_score asc]
    note_text: "<div style='text-align: left;'>What: Diagnostic recommendations on how to improve model performance based on LLM-as-a-Judge evaluation and user interactions.  <br><br>How: Aggregated from LLM-as-a-Judge recommendation metadata and error diagnostics.  <br><br>Why it matters: Converts qualitative scores into actionable prompt engineering and tool optimization steps.  <br><br>Drill: Filter by Agent Name to inspect specific interaction recommendations.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: AI Recommendations
    row: 6
    col: 0
    width: 24
    height: 8
  - name: AI Recommendation Provenance: Gemini vs. SDK vs. Diagnostics
    type: looker_pie
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [v_agent_evaluation.recommendation_source]
    measures: [agent_events.total_events]
    sorts: [agent_events.total_events desc]
    note_text: "<div style='text-align: left;'>What: Breakdown of where model improvement recommendations originated.  <br><br>How: Aggregated by recommendation_source (gemini-2.5-flash, gemini-2.5-pro, sdk_evaluator, static_case_fallback).  <br><br>Why it matters: Monitors share of recommendations backed by real BigQuery AI.GENERATE calls vs. SDK and empirical error diagnostics.  <br><br>Drill: Click slice to filter recommendations.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    tab_name: AI Recommendations
    row: 14
    col: 0
    width: 24
    height: 7
