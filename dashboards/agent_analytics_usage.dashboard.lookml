- dashboard: agent_analytics_usage
  title: Agent Analytics - Usage
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: ''
  layout: newspaper
  tabs:
  - name: Agent & Sessions
  - name: LLM Interactions
  - name: Tool Usage
  - name: User Analytics
  - name: Conversation & Lineage
  - name: Real-Time UDFs & Remote Function Analytics
  elements:
  - title: Token Usage split by Agent
    name: Token Usage split by Agent
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of total token consumption across agents. | How: SUM(usage_total_tokens) grouped by agent. | Why it matters: Identifies token-heavy agents for optimization. | Drill: Click agent bar to inspect token split."
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
    hidden_series: [TechSupport - v_llm_response.total_tokens_consumed, SupportBot
        - v_llm_response.total_tokens_consumed]
    series_colors:
      TechSupport - v_llm_response.total_tokens_consumed: "#9334e6"
      v_llm_response.total_tokens_consumed: "#f9ab00"
    hidden_pivots: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Date: agent_events.timestamp_date
    row: 5
    col: 12
    width: 12
    height: 8
    tab_name: Token Consumption
  - title: Top 5 users with most Tokens consumption
    name: Top 5 users with most Tokens consumption
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of top 5 users by token usage. | How: SUM(usage_total_tokens) grouped by user_id. | Why it matters: Highlights power users and token distribution. | Drill: Click user bar to view user session history."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      Date: agent_events.timestamp_date
    row: 5
    col: 0
    width: 12
    height: 8
    tab_name: Token Consumption
  - title: Total Tokens Consumption Over the Time
    name: Total Tokens Consumption Over the Time
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily time-series area chart tracking token consumption over time. | How: SUM(usage_total_tokens) aggregated by timestamp_date. | Why it matters: Monitors platform adoption and API quota utilization. | Drill: Click date point to inspect daily traffic."
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
    series_colors:
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 0
    col: 9
    width: 15
    height: 5
    tab_name: Token Consumption
  - title: Total Tokens
    name: Total Tokens
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total aggregate number of tokens consumed across all sessions. | How: SUM(usage_prompt_tokens + usage_completion_tokens). | Why it matters: Core top-line consumption metric. | Drill: Click tile to see token trend."
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
    smart_single_value_size: false
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
    series_colors:
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.pop_date_filter
    row: 0
    col: 0
    width: 9
    height: 5
    tab_name: Token Consumption
  - title: Top 5 users with most Traces
    name: Top 5 users with most Traces
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of top 5 power users by trace volume. | How: COUNT DISTINCT of trace_id grouped by user_id. | Why it matters: Shows which users execute the deepest multi-turn workflows. | Drill: Click user to inspect trace logs."
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      Date: agent_events.timestamp_date
    row: 7
    col: 0
    width: 12
    height: 8
    tab_name: Agent & Sessions
  - title: Total Traces
    name: Total Traces
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total number of execution traces recorded. | How: COUNT DISTINCT of trace_id across all sessions. | Why it matters: Measures overall end-to-end workflow invocations. | Drill: Click tile to filter by agent."
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
    smart_single_value_size: false
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
    series_colors:
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.pop_date_filter
    row: 2
    col: 0
    width: 9
    height: 5
    tab_name: Agent & Sessions
  - title: Traces split by Agent
    name: Traces split by Agent
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Distribution of trace volume across agents. | How: COUNT DISTINCT of trace_id grouped by agent. | Why it matters: Reveals traffic distribution across agent workloads. | Drill: Click agent to filter dashboard."
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
    hidden_series: [TechSupport - v_llm_response.total_tokens_consumed, SupportBot
        - v_llm_response.total_tokens_consumed]
    series_colors:
      TechSupport - v_llm_response.total_tokens_consumed: "#9334e6"
      v_llm_response.total_tokens_consumed: "#f9ab00"
      agent_events.total_traces: "#f9ab00"
    hidden_pivots: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Date: agent_events.timestamp_date
    row: 7
    col: 12
    width: 12
    height: 8
    tab_name: Agent & Sessions
  - title: Total Traces Generation Over the Time
    name: Total Traces Generation Over the Time
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily trend of trace volume generated over time. | How: COUNT DISTINCT of trace_id aggregated by timestamp_date. | Why it matters: Tracks platform engagement growth over time. | Drill: Click date to inspect daily traces."
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
    series_colors:
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 2
    col: 9
    width: 15
    height: 5
    tab_name: Agent & Sessions
  - title: Total Sessions
    name: Total Sessions
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of end-to-end user sessions. | How: COUNT DISTINCT of session_id. | Why it matters: Primary measure of active customer conversations. | Drill: Click tile to view session breakdown."
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 17
    col: 0
    width: 8
    height: 7
    tab_name: Agent & Sessions
  - title: Number of Sessions Trend
    name: Number of Sessions Trend
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily time-series trend of user session volume over time. | How: COUNT DISTINCT of session_id aggregated by timestamp_date. | Why it matters: Shows daily conversational adoption. | Drill: Click date to inspect sessions."
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
    series_colors:
      agent_events.total_sessions: "#e52592"
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 17
    col: 8
    width: 16
    height: 7
    tab_name: Agent & Sessions
  - title: Top 5 Agents Split by Session Count
    name: Top 5 Agents Split by Session Count
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of top 5 agents by number of sessions. | How: COUNT DISTINCT of session_id grouped by agent. | Why it matters: Identifies the most popular conversational agents. | Drill: Click agent to filter sessions."
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
    series_colors:
      agent_events.total_sessions: "#e8710a"
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 24
    col: 1
    width: 22
    height: 9
    tab_name: Agent & Sessions
  - title: Total Agent Transfers
    name: Total Agent Transfers
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of multi-agent delegation and handoff events. | How: COUNT of AGENT_TRANSFER events from v_agent_transfer. | Why it matters: Tracks multi-agent supervisor-worker collaboration. | Drill: Click tile to view transfer matrix."
    fields: [v_agent_transfer.total_agent_transfers]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 33
    col: 0
    width: 8
    height: 4
    tab_name: Agent & Sessions
  - title: Total A2A Interactions
    name: Total A2A Interactions
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of Agent-to-Agent protocol communication events. | How: COUNT of A2A_INTERACTION events from v_a2a_interaction. | Why it matters: Measures decentralized agent-to-agent protocol traffic. | Drill: Click tile to view A2A tasks."
    fields: [v_a2a_interaction.total_a2a_interactions]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 33
    col: 8
    width: 8
    height: 4
    tab_name: Agent & Sessions
  - title: Total HITL Confirmation Requests
    name: Total HITL Confirmation Requests
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total count of Human-In-The-Loop confirmation requests. | How: COUNT of HITL_CONFIRMATION_REQUEST events from v_hitl_confirmation_request. | Why it matters: Measures where human governance and sign-off occur. | Drill: Click tile to view HITL tools."
    fields: [v_hitl_confirmation_request.total_hitl_confirmation_requests]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 33
    col: 16
    width: 8
    height: 4
    tab_name: Agent & Sessions
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Agent"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Agent & Sessions
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Sessions"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 15
    col: 0
    width: 24
    height: 2
    tab_name: Agent & Sessions
  - title: Tool Invocations
    name: Tool Invocations
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Ranking of backend tools by invocation frequency. | How: COUNT of TOOL_COMPLETED events grouped by tool_name. | Why it matters: Highlights which APIs and integrations are relied upon most. | Drill: Click tool to view latency and error rate."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
    defaults_version: 1
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 6
    col: 0
    width: 12
    height: 7
    tab_name: Tool Usage
  - title: Events By Agent
    name: Events By Agent
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of total lifecycle events across agents. | How: COUNT of raw event rows grouped by agent. | Why it matters: Shows raw telemetry volume per agent. | Drill: Click agent to filter events."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 6
    col: 12
    width: 12
    height: 7
    tab_name: Tool Usage
  - title: Tool Calls Over Time
    name: Tool Calls Over Time
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily execution trend of specific tools over time. | How: COUNT of TOOL_COMPLETED events aggregated by timestamp_date and tool_name. | Why it matters: Reveals evolving tool usage patterns over time. | Drill: Click date/tool to inspect executions."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 0
    col: 0
    width: 24
    height: 6
    tab_name: Tool Usage
  - title: Total Calls
    name: Total Calls
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Absolute count of requests sent to backend tools. | How: COUNT of TOOL_COMPLETED events. | Why it matters: Overall volume of external tool and API executions. | Drill: Click tile to inspect tools."
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
    smart_single_value_size: false
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.pop_date_filter
    row: 0
    col: 0
    width: 8
    height: 6
    tab_name: LLM Interactions
  - title: LLM Call Trends
    name: LLM Call Trends
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Granular scatter plot showing frequency and clustering of LLM requests. | How: Plots individual LLM_RESPONSE events over time. | Why it matters: Identifies peak usage periods and request density. | Drill: Select time range to filter LLM calls."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
      v_llm_response.total_llm_calls: "#8ab4f8"
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 0
    col: 8
    width: 16
    height: 6
    tab_name: LLM Interactions
  - title: Top 5 Agents by LLM Calls
    name: Top 5 Agents by LLM Calls
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Ranking of agents triggering the most LLM calls. | How: COUNT of LLM_RESPONSE events grouped by agent. | Why it matters: Identifies agents driving backend LLM load. | Drill: Click agent to inspect LLM calls."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
      v_llm_response.total_llm_calls: "#f28b82"
    show_null_points: true
    interpolation: monotone
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 6
    col: 1
    width: 21
    height: 8
    tab_name: LLM Interactions
  - title: Total Users
    name: Total Users
    model: agent-analytics
    explore: agent_events
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Count of unique end users who interacted with agents. | How: COUNT DISTINCT of user_id. | Why it matters: Primary user adoption and penetration metric. | Drill: Click tile to see user growth."
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
    series_colors:
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
    smart_single_value_size: false
    comparison_label: V Previous Period
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.pop_date_filter
    row: 2
    col: 0
    width: 8
    height: 7
    tab_name: User Analytics
  - title: User Growth Over Time
    name: User Growth Over Time
    model: agent-analytics
    explore: agent_events
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Daily count of active unique users over time. | How: COUNT DISTINCT of user_id aggregated by timestamp_date. | Why it matters: Measures DAU retention and adoption velocity. | Drill: Click date to inspect active users."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
      v_llm_response.total_llm_calls: "#f28b82"
      agent_events.total_users: "#1e8e3e"
    ordering: none
    show_null_labels: false
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
      Date: agent_events.timestamp_date
    row: 2
    col: 8
    width: 16
    height: 7
    tab_name: User Analytics
  - title: Top 5 Users by Session
    name: Top 5 Users by Session
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of power users by session count. | How: COUNT DISTINCT of session_id grouped by user_id. | Why it matters: Highlights champions and power users. | Drill: Click user to inspect sessions."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#e8710a"
      execute_sql - agent_events.total_events: "#e8710a"
      v_llm_response.total_llm_calls: "#f28b82"
      agent_events.total_users: "#1e8e3e"
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 9
    col: 0
    width: 12
    height: 7
    tab_name: User Analytics
  - title: Top 5 Users by Events
    name: Top 5 Users by Events
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Ranking of users by raw volume of lifecycle events generated. | How: COUNT of event rows grouped by user_id. | Why it matters: Identifies users running the most intensive agent workflows. | Drill: Click user to inspect event logs."
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
    series_colors:
      agent_events.total_invocations: "#1e8e3e"
      agent_events.total_events: "#f9ab00"
      execute_sql - agent_events.total_events: "#e8710a"
      v_llm_response.total_llm_calls: "#f28b82"
      agent_events.total_users: "#1e8e3e"
    show_null_points: false
    interpolation: monotone
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
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
    listen:
      Date: agent_events.timestamp_date
      Agent: agent_events.agent
      Span ID: agent_events.span_id
      Trace ID: agent_events.trace_id
      User ID: agent_events.user_id
    row: 9
    col: 12
    width: 12
    height: 7
    tab_name: User Analytics
  - type: button
    name: button_854
    rich_content_json: '{"text":"Performance Report","description":"","newTab":false,"alignment":"center","size":"small","style":"FILLED","color":"#E52592","href":"/dashboards/agent-analytics::agent_analytics_performance"}'
    row: 0
    col: 19
    width: 5
    height: 1
    tab_name: User Analytics
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 1
    col: 0
    width: 21
    height: 1
    tab_name: User Analytics
  - name: gcs_multimodal_offload_breakdown
    title: "GCS Multimodal Bucket Offloading & Object Table Content"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of multimodal payloads and large objects offloaded to GCS bucket japac-pso-agent-analytics. | How: Aggregates offloaded GCS URIs by asset_type (IMAGE, DOCUMENT, AUDIO, VIDEO, LARGE_PAYLOAD_JSON) and event_type. | Why it matters: Monitors multimodal storage footprint and BigQuery object table ingestion. | Drill: Click asset type bar to inspect specific GCS URIs and traces."
    explore: agent_events
    dimensions: [v_gcs_multimodal_offload.asset_type, gcs_multimodal_object_table.content_type]
    measures: [v_gcs_multimodal_offload.total_gcs_offloaded_assets, gcs_multimodal_object_table.total_size_bytes]
    sorts: [v_gcs_multimodal_offload.total_gcs_offloaded_assets desc]
    row: 17
    col: 0
    width: 24
    height: 7
    tab_name: Tool Usage
  - name: conversation_flow_turn_analytics
    title: "Conversation Analytics: Multi-Turn Interaction Flow & Token Latency"
    type: looker_grid
    note_state: collapsed
    note_display: hover
    note_text: "What: Turn-by-turn breakdown of user prompts, agent responses, tool calls, and token/latency metrics. | How: Queries agent_events joined with v_llm_response, v_tool_completed, and v_agent_evaluation. | Why it matters: Enables granular conversational analytics and turn debugging across sessions. | Drill: Click Session ID to inspect full conversation history."
    explore: agent_events
    dimensions: [agent_events.session_id, agent_events.event_type, agent_events.agent, v_tool_completed.tool_name, agent_events.status]
    measures: [v_llm_response.total_tokens_consumed, agent_events.total_events]
    sorts: [agent_events.session_id desc, agent_events.total_events desc]
    limit: 50
    row: 0
    col: 0
    width: 24
    height: 9
    tab_name: Conversation & Lineage
  - name: multi_agent_dag_decision_lineage
    title: "Multi-Agent DAG Delegation & Decision Paths"
    type: looker_grid
    note_state: collapsed
    note_display: hover
    note_text: "What: Maps agent-to-agent delegation sequence and session lineage across supervisor and worker agents. | How: Queries v_agent_transfer and v_a2a_interaction joined with agent_events. | Why it matters: Provides complete DAG visibility and decision lineage tracking for multi-agent architectures. | Drill: Click Source or Target Agent to trace delegation graph."
    explore: agent_events
    dimensions: [agent_events.session_id, v_agent_transfer.from_agent, v_agent_transfer.to_agent]
    measures: [agent_events.total_events]
    sorts: [agent_events.total_events desc]
    limit: 50
    row: 9
    col: 0
    width: 24
    height: 8
    tab_name: Conversation & Lineage
  - title: Real-Time UDF Evaluation Scorecard (Zero-Batch Latency, TTFT & Cost Scores)
    name: Real-Time UDF Evaluation Scorecard
    model: agent-analytics
    explore: udf_realtime_scorecard
    type: looker_grid
    fields: [udf_realtime_scorecard.practice_area, udf_realtime_scorecard.agent, udf_realtime_scorecard.total_sessions, udf_realtime_scorecard.total_spans, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score, udf_realtime_scorecard.avg_token_efficiency_score, udf_realtime_scorecard.avg_cost_score, udf_realtime_scorecard.avg_error_rate_score]
    sorts: [udf_realtime_scorecard.total_sessions desc]
    limit: 50
    row: 0
    col: 0
    width: 24
    height: 6
    tab_name: Real-Time UDFs & Remote Function Analytics
  - title: Interactive SQL-Driven Trace Drilldown (Remote Function 'analyze')
    name: Interactive SQL-Driven Trace Drilldown
    model: agent-analytics
    explore: remote_function_trace_drilldown
    type: looker_grid
    fields: [remote_function_trace_drilldown.session_id, remote_function_trace_drilldown.agent, remote_function_trace_drilldown.session_start_time, remote_function_trace_drilldown.span_count, remote_function_trace_drilldown.error_count, remote_function_trace_drilldown.sdk_version, remote_function_trace_drilldown.analyzed_session_id]
    sorts: [remote_function_trace_drilldown.session_start_time desc]
    limit: 50
    row: 6
    col: 0
    width: 12
    height: 7
    tab_name: Real-Time UDFs & Remote Function Analytics
  - title: Production vs Baseline Drift Scorecard (Remote Function 'drift')
    name: Production vs Baseline Drift Scorecard
    model: agent-analytics
    explore: remote_function_drift_scorecard
    type: looker_grid
    fields: [remote_function_drift_scorecard.comparison_tier, remote_function_drift_scorecard.drift_metric, remote_function_drift_scorecard.kolmogorov_smirnov_stat, remote_function_drift_scorecard.p_value, remote_function_drift_scorecard.drift_status, remote_function_drift_scorecard.last_evaluated_date]
    sorts: [remote_function_drift_scorecard.drift_metric]
    limit: 50
    row: 6
    col: 12
    width: 12
    height: 7
    tab_name: Real-Time UDFs & Remote Function Analytics
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 14 day
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
