- dashboard: agent_analytics_usage
  title: Agent Analytics - Usage
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: ''
  layout: newspaper
  tabs:
  - name: Agent & Sessions
    label: Agent & Sessions
    title: Agent & Sessions
  - name: LLM & Token Economics
    label: LLM & Token Economics
    title: LLM & Token Economics
  - name: Tool Usage & Provenance
    label: Tool Usage & Provenance
    title: Tool Usage & Provenance
  - name: Conversation & Lineage
    label: Conversation & Lineage
    title: Conversation & Lineage
  elements:
  - name: nav_header_sessions
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Agent & Sessions
  - name: nav_header_llm
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: LLM & Token Economics
  - name: nav_header_tools
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Tool Usage & Provenance
  - name: nav_header_lineage
    type: text
    title_text: ""
    body_text: "### [🏠 APO Executive Portal](/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal) &nbsp;&nbsp;|&nbsp;&nbsp; [📈 Performance Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_performance) &nbsp;&nbsp;|&nbsp;&nbsp; [📊 Usage Dashboard](/dashboards/bigquery_agent_analytics_model::agent_analytics_usage)"
    row: 0
    col: 0
    width: 24
    height: 2
    tab_name: Conversation & Lineage
  - title: Token Usage split by Agent
    name: Token Usage split by Agent
    model: bigquery_agent_analytics_model
    explore: agent_events
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Breakdown of total token consumption across agents.  | How: SUM(usage_total_tokens) grouped by agent.  | Why it matters: Identifies token-heavy agents for optimization.  | Drill: Click agent bar to inspect token split."
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

    row: 13
    col: 12
    width: 12
    height: 8
    tab_name: LLM & Token Economics
  - title: Top 5 users with most Tokens consumption
    name: Top 5 users with most Tokens consumption
    model: bigquery_agent_analytics_model
    explore: agent_events
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Leaderboard of top 5 users by token usage.  | How: SUM(usage_total_tokens) grouped by user_id.  | Why it matters: Highlights power users and token distribution.  | Drill: Click user bar to view user session history."
    fields: [agent_events.user_id, v_llm_response.total_tokens_consumed]
  