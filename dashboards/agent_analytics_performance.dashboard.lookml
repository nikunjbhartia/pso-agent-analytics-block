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
  - type: button
    name: nav_btn_portal_Latency
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: Latency
  - type: button
    name: nav_btn_usage_Latency
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: Latency

  - type: button
    name: nav_btn_portal_Errors
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: Errors
  - type: button
    name: nav_btn_usage_Errors
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: Errors

  - type: button
    name: nav_btn_portal_AI_Recommendations
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: AI Recommendations
  - type: button
    name: nav_btn_usage_AI_Recommendations
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 8
    col: 6
    width: 6
    height: 3
    tab_name: Latency
  - title: P90 Tool Latency
    name: P90 Tool Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 8
    col: 12
    width: 6
    height: 3
    tab_name: Latency
  - title: P99 Tool Latency
    name: P99 Tool Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 8
    col: 18
    width: 6
    height: 3
    tab_name: Latency
  - title: P50 Llm Latency
    name: P50 Llm Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 17
    col: 0
    width: 6
    height: 3
    tab_name: Latency
  - title: P75 Llm Latency
    name: P75 Llm Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 17
    col: 12
    width: 6
    height: 3
    tab_name: Latency
  - title: P90 Llm Latency
    name: P90 Llm Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 17
    col: 18
    width: 6
    height: 3
    tab_name: Latency
  - title: P99 Llm Latency
    name: P99 Llm Latency
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 17
    col: 6
    width: 6
    height: 3
    tab_name: Latency
  - title: Total Errors
    name: Total Errors
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 2
    col: 0
    width: 8
    height: 7
    tab_name: Errors
  - title: Tool Errors Trend
    name: Tool Errors Trend
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 2
    col: 8
    width: 16
    height: 7
    tab_name: Errors
  - title: Top 5 Agents By Errors
    name: Top 5 Agents By Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 9
    col: 0
    width: 12
    height: 7
    tab_name: Errors
  - title: Top 5 Tools by Errors
    name: Top 5 Tools by Errors
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
      Tool Name: v_tool_completed.tool_name
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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

    row: 9
    col: 12
    width: 12
    height: 7
    tab_name: Errors
  - title: Total Agent Errors
    name: Total Agent Errors
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    fields: [v_agent_error.total_agent_errors]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true

    row: 16
    col: 0
    width: 12
    height: 4
    tab_name: Errors
  - title: Self-Healing Resilience Rate (%)
    name: Self-Healing Resilience Rate (%)
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    fields: [agent_events.self_healing_resilience_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true

    row: 16
    col: 12
    width: 12
    height: 4
    tab_name: Errors
  - title: LLM-as-a-Judge Avg Quality Score (%)
    name: LLM-as-a-Judge Avg Quality Score (%)
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    fields: [v_agent_evaluation.avg_judge_quality_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true

    row: 20
    col: 0
    width: 8
    height: 4
    tab_name: Errors
  - title: User Feedback Satisfaction Rate (%)
    name: User Feedback Satisfaction Rate (%)
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    fields: [v_agent_evaluation.feedback_satisfaction_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true

    row: 20
    col: 8
    width: 8
    height: 4
    tab_name: Errors
  - title: Self-Correction Loop Success Rate (%)
    name: Self-Correction Loop Success Rate (%)
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    fields: [v_agent_evaluation.self_correction_success_rate_pct]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true

    row: 20
    col: 16
    width: 8
    height: 4
    tab_name: Errors
  - name: a2a_circular_ping_pong_loop_table
    title: "Enterprise Edge-Case: A2A Circular Delegation Ping-Pong Loops"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: The average time in milliseconds for tool calls or LLM requests to complete. <br><br>How it is calculated: Average duration in milliseconds across completed execution events. <br><br>Why it matters: Directly reflects user wait times and system responsiveness. <br><br>Drill down: Click this tile to view latency distribution across tools or models.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: The frequency and total count of errors encountered during agent tool executions. <br><br>How it is calculated: Total count of error events logged by backend plugins. <br><br>Why it matters: Identifies API failures, schema mismatches, and integration bottlenecks. <br><br>Drill down: Click this tile to inspect detailed error logs.</div>"
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
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
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
    model: bigquery_agent_analytics_model
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
    model: bigquery_agent_analytics_model
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
    model: bigquery_agent_analytics_model
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
    model: bigquery_agent_analytics_model
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
    model: bigquery_agent_analytics_model
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
    model: bigquery_agent_analytics_model
    explore: agent_events
    listens_to_filters: []
    field: v_tool_completed.tool_name
