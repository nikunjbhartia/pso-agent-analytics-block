---
- dashboard: agent_analytics_usage
  title: Agent Analytics - Usage
  preferred_viewer: dashboards-next
  description: ''
  layout: newspaper
  elements:
  - title: Token Usage split by Agent
    name: Token Usage split by Agent
    model: agent-analytics
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: What it is: Breakdown of total token consumption across agents. How derived: SUM(usage_total_tokens) grouped by agent.
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
    note_text: What it is: Leaderboard of top 5 users by token usage. How derived: SUM(usage_total_tokens) grouped by user_id.
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
    note_text: What it is: Daily time-series area chart tracking token consumption over time. How derived: SUM(usage_total_tokens) aggregated by timestamp_date.
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
    note_text: What it is: Total aggregate number of tokens consumed across all sessions. How derived: SUM(usage_prompt_tokens + usage_completion_tokens).
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
    note_text: What it is: Leaderboard of top 5 power users by trace volume. How derived: COUNT DISTINCT of trace_id grouped by user_id.
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
    note_text: What it is: Total number of execution traces recorded. How derived: COUNT DISTINCT of trace_id across all sessions.
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
    note_text: What it is: Distribution of trace volume across agents. How derived: COUNT DISTINCT of trace_id grouped by agent.
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
    note_text: What it is: Daily trend of trace volume generated over time. How derived: COUNT DISTINCT of trace_id aggregated by timestamp_date.
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
    note_text: What it is: Total count of end-to-end user sessions. How derived: COUNT DISTINCT of session_id.
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
    note_text: What it is: Daily time-series trend of user session volume over time. How derived: COUNT DISTINCT of session_id aggregated by timestamp_date.
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
    note_text: What it is: Leaderboard of top 5 agents by number of sessions. How derived: COUNT DISTINCT of session_id grouped by agent.
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
    note_text: What it is: Total count of multi-agent delegation and handoff events. How derived: COUNT of AGENT_TRANSFER events from v_agent_transfer.
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
    note_text: What it is: Total count of Agent-to-Agent protocol communication events. How derived: COUNT of A2A_INTERACTION events from v_a2a_interaction.
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
    note_text: What it is: Total count of Human-In-The-Loop confirmation requests. How derived: COUNT of HITL_CONFIRMATION_REQUEST events from v_hitl_confirmation_request.
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
    note_text: What it is: Ranking of backend tools by invocation frequency. How derived: COUNT of TOOL_COMPLETED events grouped by tool_name.
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
    note_text: What it is: Breakdown of total lifecycle events across agents. How derived: COUNT of raw event rows grouped by agent.
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
    note_text: What it is: Daily execution trend of specific tools over time. How derived: COUNT of TOOL_COMPLETED events aggregated by timestamp_date and tool_name.
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
    note_text: What it is: Absolute count of requests sent to backend tools. How derived: COUNT of TOOL_COMPLETED events.
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
    note_text: What it is: Granular scatter plot showing frequency and clustering of LLM requests. How derived: Plots individual LLM_RESPONSE events over time.
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
    note_text: What it is: Ranking of agents triggering the most LLM calls. How derived: COUNT of LLM_RESPONSE events grouped by agent.
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
    note_text: What it is: Count of unique end users who interacted with agents. How derived: COUNT DISTINCT of user_id.
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
    note_text: What it is: Daily count of active unique users over time. How derived: COUNT DISTINCT of user_id aggregated by timestamp_date.
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
    note_text: What it is: Leaderboard of power users by session count. How derived: COUNT DISTINCT of session_id grouped by user_id.
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
    note_text: What it is: Ranking of users by raw volume of lifecycle events generated. How derived: COUNT of event rows grouped by user_id.
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
