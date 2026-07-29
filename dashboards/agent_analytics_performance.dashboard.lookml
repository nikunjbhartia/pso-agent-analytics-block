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
  - title: Average Tool Latency (ms)
    name: Average Tool Latency (ms)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Average time in milliseconds for tools to execute. | How: Average of total_ms across all TOOL_COMPLETED events. | Why it matters: Monitors backend API performance and user wait time. | Drill: Click tile to see tool latency breakdown."
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
    listen:
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
      Date: agent_events.timestamp_date
    row: 2
    col: 0
    width: 7
    height: 6
    tab_name: Latency
  - title: Tool Latency Trend
    name: Tool Latency Trend
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Historical trend of tool execution latency over time. | How: Average of total_ms aggregated by timestamp_date. | Why it matters: Identifies performance degradation or API slowdowns over time. | Drill: Click date to inspect daily latency."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 2
    col: 7
    width: 17
    height: 6
    tab_name: Latency
  - title: Average LLM Latency (in ms)
    name: Average LLM Latency (in ms)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Average round-trip time in milliseconds for LLM requests. | How: Average of total_ms across all LLM_RESPONSE events. | Why it matters: Tracks model responsiveness and generation speed. | Drill: Click tile to see LLM latency trend."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 15
    col: 0
    width: 8
    height: 6
    tab_name: Latency
  - title: LLM Latency Trend
    name: LLM Latency Trend
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Historical trend of LLM response times over time. | How: Average of total_ms aggregated by timestamp_date. | Why it matters: Monitors API latency anomalies across Gemini model versions. | Drill: Click date to inspect LLM latency."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 15
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
    rich_content_json: '{"text":"Usage Report","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#E52592","href":"/dashboards/agent-analytics::agent_analytics_usage"}'
    row: 0
    col: 19
    width: 5
    height: 2
    tab_name: Latency
  - title: P50 Tool Latency
    name: P50 Tool Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Median (50th percentile) tool execution latency in milliseconds. | How: 50th percentile of total_ms across TOOL_COMPLETED events. | Why it matters: Reflects typical user experience for tool executions. | Drill: Click tile to inspect median tool latency."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 10
    col: 0
    width: 6
    height: 3
    tab_name: Latency
  - title: P75 Tool Latency
    name: P75 Tool Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 75th percentile tool execution latency in milliseconds. | How: 75th percentile of total_ms across TOOL_COMPLETED events. | Why it matters: Reflects latency for the slower quartile of tool executions. | Drill: Click tile to view P75 breakdown."
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
    single_value_title: P75 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p90_tool_latency, v_tool_completed.p99_tool_latency,
      v_tool_completed.p50_tool_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 10
    col: 6
    width: 6
    height: 3
    tab_name: Latency
  - title: P90 Tool Latency
    name: P90 Tool Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 90th percentile tool execution latency in milliseconds. | How: 90th percentile of total_ms across TOOL_COMPLETED events. | Why it matters: Identifies tail latency affecting the 10% slowest tool calls. | Drill: Click tile to inspect P90 latency."
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
    single_value_title: P90 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p99_tool_latency, v_tool_completed.p50_tool_latency,
      v_tool_completed.p75_tool_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 10
    col: 12
    width: 6
    height: 3
    tab_name: Latency
  - title: P99 Tool Latency
    name: P99 Tool Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 99th percentile (tail latency) tool execution latency in milliseconds. | How: 99th percentile of total_ms across TOOL_COMPLETED events. | Why it matters: Critical SRE metric for worst-case API timeouts and delays. | Drill: Click tile to inspect P99 tail latency."
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
    single_value_title: P99 Tool Latency
    smart_single_value_size: false
    hidden_fields: [v_tool_completed.p50_tool_latency, v_tool_completed.p75_tool_latency,
      v_tool_completed.p90_tool_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 10
    col: 18
    width: 6
    height: 3
    tab_name: Latency
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"Tool Latency (in ms)"}],"align":"center"},{"type":"p","children":[{"text":"The
      P50, P75, P90, and P99 latency distributions for tool executions. Focus on P99
      to identify the worst-case timeouts."}],"id":"nj8zb","align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 8
    col: 0
    width: 24
    height: 2
    tab_name: Latency
  - title: P50 Llm Latency
    name: P50 Llm Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Median (50th percentile) LLM response latency in milliseconds. | How: 50th percentile of total_ms across LLM_RESPONSE events. | Why it matters: Core responsiveness KPI for conversational agents. | Drill: Click tile to see P50 trend."
    fields: [v_llm_response.p50_llm_latency, v_llm_response.p75_llm_latency, v_llm_response.p90_llm_latency,
      v_llm_response.p99_llm_latency]
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
    single_value_title: P50 Llm Latency
    smart_single_value_size: false
    hidden_fields: [v_llm_response.p75_llm_latency, v_llm_response.p90_llm_latency,
      v_llm_response.p99_llm_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 23
    col: 0
    width: 6
    height: 3
    tab_name: Latency
  - title: P75 Llm Latency
    name: P75 Llm Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 75th percentile LLM response latency in milliseconds. | How: 75th percentile of total_ms across LLM_RESPONSE events. | Why it matters: Tracks generation speed for longer context prompts. | Drill: Click tile to inspect P75 latency."
    fields: [v_llm_response.p50_llm_latency, v_llm_response.p75_llm_latency, v_llm_response.p90_llm_latency,
      v_llm_response.p99_llm_latency]
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
    single_value_title: P75 Llm Latency
    smart_single_value_size: false
    hidden_fields: [v_llm_response.p90_llm_latency, v_llm_response.p99_llm_latency,
      v_llm_response.p50_llm_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 23
    col: 12
    width: 6
    height: 3
    tab_name: Latency
  - title: P90 Llm Latency
    name: P90 Llm Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 90th percentile LLM response latency in milliseconds. | How: 90th percentile of total_ms across LLM_RESPONSE events. | Why it matters: Identifies slow LLM responses impacting user experience. | Drill: Click tile to see P90 trend."
    fields: [v_llm_response.p50_llm_latency, v_llm_response.p75_llm_latency, v_llm_response.p90_llm_latency,
      v_llm_response.p99_llm_latency]
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
    single_value_title: P90 Llm Latency
    smart_single_value_size: false
    hidden_fields: [v_llm_response.p99_llm_latency, v_llm_response.p50_llm_latency,
      v_llm_response.p75_llm_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 23
    col: 18
    width: 6
    height: 3
    tab_name: Latency
  - title: P99 Llm Latency
    name: P99 Llm Latency
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: 99th percentile (tail latency) LLM response latency in milliseconds. | How: 99th percentile of total_ms across LLM_RESPONSE events. | Why it matters: Critical SLA metric for tail LLM response delays. | Drill: Click tile to inspect P99 tail latency."
    fields: [v_llm_response.p50_llm_latency, v_llm_response.p75_llm_latency, v_llm_response.p90_llm_latency,
      v_llm_response.p99_llm_latency]
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
    single_value_title: P99 Llm Latency
    smart_single_value_size: false
    hidden_fields: [v_llm_response.p50_llm_latency, v_llm_response.p75_llm_latency,
      v_llm_response.p90_llm_latency]
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 23
    col: 6
    width: 6
    height: 3
    tab_name: Latency
  - name: " (Copy 2)"
    type: text
    title_text: " (Copy 2)"
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"LLM Latency (in ms)"}],"align":"center"},{"type":"p","children":[{"text":"The
      P50, P75, P90, and P99 latency distributions for LLM calls. Crucial for understanding
      the true user experience delay."}],"id":"nj8zb","align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 21
    col: 0
    width: 24
    height: 2
    tab_name: Latency
  - title: Total Errors
    name: Total Errors
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of backend tool execution errors. | How: COUNT of TOOL_ERROR events. | Why it matters: Identifies API failures and integration instability. | Drill: Click tile to inspect error logs."
    fields: [v_tool_error.pop_tool_errors_current, v_tool_error.pop_tool_errors_change]
    filters:
      agent_events.pop_date_filter: 7 days
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
    smart_single_value_size: false
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.pop_date_filter
    row: 0
    col: 0
    width: 8
    height: 7
    tab_name: Errors
  - title: Tool Errors Trend
    name: Tool Errors Trend
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily time-series tracking volume of tool failures. | How: COUNT of TOOL_ERROR events aggregated by timestamp_date. | Why it matters: Reveals error spikes and system instability over time. | Drill: Click date spike to view failing tools."
    fields: [agent_events.timestamp_date, v_tool_error.total_tool_errors]
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
      v_tool_error.total_tool_errors: "#a50e0e"
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs Last Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 0
    col: 8
    width: 16
    height: 7
    tab_name: Errors
  - title: Top 5 Agents By Errors
    name: Top 5 Agents By Errors
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Ranking of agents by number of tool errors encountered. | How: COUNT of TOOL_ERROR events grouped by agent. | Why it matters: Shows which agents experience the most tool failures. | Drill: Click agent to filter error logs."
    fields: [v_tool_error.total_tool_errors, agent_events.agent]
    sorts: [v_tool_error.total_tool_errors desc 0]
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
    series_colors:
      v_tool_error.total_tool_errors: "#e8710a"
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs Last Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 7
    col: 0
    width: 12
    height: 7
    tab_name: Errors
  - title: Top 5 Tools by Errors
    name: Top 5 Tools by Errors
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of the most unstable backend tools. | How: COUNT of TOOL_ERROR events grouped by tool_name. | Why it matters: Focuses debugging efforts on the most error-prone APIs. | Drill: Click tool to inspect error tracebacks."
    fields: [v_tool_error.total_tool_errors, v_tool_error.tool_name]
    sorts: [v_tool_error.total_tool_errors desc 0]
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
    series_colors:
      v_tool_error.total_tool_errors: "#f9ab00"
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs Last Period
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 7
    col: 12
    width: 12
    height: 7
    tab_name: Errors
  - title: Total Agent Errors
    name: Total Agent Errors
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of agent-level execution errors and crashes. | How: COUNT of AGENT_ERROR events from v_agent_error. | Why it matters: Core measure of overall agent execution stability. | Drill: Click tile to inspect error tracebacks."
    fields: [v_agent_error.total_agent_errors]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 14
    col: 0
    width: 12
    height: 4
    tab_name: Errors
  - title: Self-Healing Resilience Rate (%)
    name: Self-Healing Resilience Rate (%)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Reliability SLA metric measuring ratio of SUCCESS outcomes vs total executions. | How: COUNTIF(status = SUCCESS) / COUNT(1). | Why it matters: Asserts production stability and CI/CD deployment readiness. | Drill: Click tile to inspect failing traces."
    fields: [agent_events.self_healing_resilience_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 14
    col: 12
    width: 12
    height: 4
    tab_name: Errors
  - title: LLM-as-a-Judge Avg Quality Score (%)
    name: LLM-as-a-Judge Avg Quality Score (%)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Qualitative LLM-as-a-Judge evaluation score (0-100%). | How: Evaluates response accuracy, relevance, and tool faithfulness. | Why it matters: Assures high conversational quality and correctness. | Drill: Click tile to inspect evaluation scorecards."
    fields: [v_agent_evaluation.avg_judge_quality_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 18
    col: 0
    width: 8
    height: 4
    tab_name: Errors
  - title: User Feedback Satisfaction Rate (%)
    name: User Feedback Satisfaction Rate (%)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Percentage of positive user feedback ratings. | How: COUNTIF(user_feedback_rating = 'THUMBS_UP') / COUNT(1) * 100.0. | Why it matters: Directly measures customer happiness and satisfaction. | Drill: Click tile to view user feedback records."
    fields: [v_agent_evaluation.feedback_satisfaction_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 18
    col: 8
    width: 8
    height: 4
    tab_name: Errors
  - title: Self-Correction Loop Success Rate (%)
    name: Self-Correction Loop Success Rate (%)
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Rate at which agents successfully self-correct and recover after encountering an error. | How: Percentage of recovered SUCCESS sessions that followed an ERROR event. | Why it matters: Demonstrates autonomous self-healing and error recovery. | Drill: Click tile to view recovered sessions."
    fields: [v_agent_evaluation.self_correction_success_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 18
    col: 16
    width: 8
    height: 4
    tab_name: Errors
  - name: a2a_circular_ping_pong_loop_table
    title: "Enterprise Edge-Case: A2A Circular Delegation Ping-Pong Loops"
    type: looker_grid
    note_state: collapsed
    note_display: hover
    note_text: "What: Highlights recursive A2A delegation loops between agents. | How: Filters where from_agent equals to_target. | Why it matters: Detects infinite orchestration ping-pong loops that bloat token consumption. | Drill: Filter by Session ID to inspect full trace stack."
    explore: agent_events
    dimensions: [v_session_trace_dag.session_id, v_session_trace_dag.from_agent, v_session_trace_dag.to_target, v_session_trace_dag.is_circular_delegation]
    measures: [v_session_trace_dag.circular_loop_count, v_session_trace_dag.avg_dag_hop_latency_ms]
    filters:
      v_session_trace_dag.is_circular_delegation: "YES - CIRCULAR LOOP"
    sorts: [v_session_trace_dag.circular_loop_count desc]
    row: 22
    col: 0
    width: 12
    height: 7
    tab_name: Errors
  - name: hitl_human_approval_latency_bottlenecks
    title: "Enterprise Edge-Case: HITL Confirmation Request Volume & Latency"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "What: Tracks Human-In-The-Loop confirmation request volume and latency. | How: Aggregates HITL_CONFIRMATION_REQUEST events by tool_name and date. | Why it matters: Identifies where workflows pause awaiting human sign-off. | Drill: Filter by Date or Tool Name."
    explore: agent_events
    dimensions: [agent_events.timestamp_date, v_hitl_confirmation_request.tool_name]
    measures: [v_hitl_confirmation_request.total_hitl_confirmation_requests]
    sorts: [agent_events.timestamp_date asc]
    row: 22
    col: 12
    width: 12
    height: 7
    tab_name: Errors
  - name: tool_error_distribution_breakdown
    title: "Enterprise Edge-Case: Tool Error Breakdown by Failing Function"
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of failing backend tools and error counts. | How: Aggregates TOOL_ERROR occurrences by tool_name. | Why it matters: Focuses SRE remediation on the most unstable API integrations. | Drill: Filter by Tool Name."
    explore: agent_events
    dimensions: [v_tool_error.tool_name]
    measures: [v_tool_error.total_tool_errors]
    sorts: [v_tool_error.total_tool_errors desc]
    row: 29
    col: 0
    width: 24
    height: 7
    tab_name: Errors
  - name: judge_improvement_recommendations_table
    title: "LLM-as-a-Judge: Actionable Model Improvement Recommendations"
    type: looker_grid
    note_state: collapsed
    note_display: hover
    note_text: "What: Diagnostic recommendations on how to improve model performance based on LLM-as-a-Judge evaluation and user interactions. | How: Aggregated from LLM-as-a-Judge recommendation metadata and error diagnostics. | Why it matters: Converts qualitative scores into actionable prompt engineering and tool optimization steps. | Drill: Filter by Agent Name to inspect specific interaction recommendations."
    explore: agent_events
    dimensions: [agent_events.canonical_agent_name, v_agent_evaluation.judge_improvement_recommendation]
    measures: [v_agent_evaluation.avg_judge_quality_score, v_agent_evaluation.feedback_satisfaction_rate_pct]
    sorts: [v_agent_evaluation.avg_judge_quality_score asc]
    row: 36
    col: 0
    width: 14
    height: 7
    tab_name: AI Recommendations
  - name: recommendation_source_breakdown
    title: "AI Recommendation Provenance: Gemini vs. SDK vs. Diagnostics"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of where model improvement recommendations originated. | How: Aggregated by recommendation_source (gemini-2.5-flash, gemini-2.5-pro, sdk_evaluator, static_case_fallback). | Why it matters: Monitors share of recommendations backed by real BigQuery AI.GENERATE calls vs. SDK and empirical error diagnostics. | Drill: Click slice to filter recommendations."
    explore: agent_events
    dimensions: [v_agent_evaluation.recommendation_source]
    measures: [agent_events.total_events]
    sorts: [agent_events.total_events desc]
    row: 36
    col: 14
    width: 10
    height: 7
    tab_name: AI Recommendations
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: agent_events.timestamp_date
  - name: Trace ID
    title: Trace ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: agent_events.trace_id
  - name: Agent
    title: Agent
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: agent_events.agent
  - name: User ID
    title: User ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: agent_events.user_id
  - name: Span ID
    title: Span ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: agent_events.span_id
  - name: Tool Name
    title: Tool Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: agent-analytics
    explore: agent_events
    listens_to_filters: []
    field: v_tool_completed.tool_name
