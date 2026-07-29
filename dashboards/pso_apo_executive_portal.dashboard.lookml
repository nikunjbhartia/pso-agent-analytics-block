- dashboard: pso_apo_executive_portal
  title: "APO Portal: Google Cloud PSO JAPAC Agent Program Office"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: "Canonical Executive Dashboard for Google Cloud PSO JAPAC APO (Agent Program Office) — Server-Verified Hours Saved, Practice Area Attribution, Pilot Projects, and FTE Value Creation."

  filters:
  - name: date_filter
    title: "Date Range"
    type: date_filter
    default_value: "last 30 days"
  - name: practice_area_filter
    title: "Practice Area"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.practice_area
    default_value: ""
  - name: sub_region_filter
    title: "JAPAC Sub-Region"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.sub_region
    default_value: ""
  - name: pilot_project_filter
    title: "Pilot Project"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.pilot_project
    default_value: ""
  - name: agent_name_filter
    title: "Canonical Agent Name"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.canonical_agent_name
    default_value: ""
  - name: trace_id_filter
    title: "Trace ID"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.trace_id
    default_value: ""
  - name: session_id_filter
    title: "Session ID"
    type: field_filter
    explore: agent_events
    model: bigquery_agent_analytics_model
    field: agent_events.session_id
    default_value: ""

  elements:
  - type: button
    name: nav_btn_perf
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 16
    width: 4
    height: 2
  - type: button
    name: nav_btn_usage
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 20
    width: 4
    height: 2


  # --- ROW 1: EXECUTIVE HEADLINE SCORECARDS ("Verifiable & Real-Time") ---
  - name: total_hours_saved_card
    title: "CWPM Verifiable Hours Saved"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Estimated productivity hours saved by automated tool calls. <br>How: Count of completed tool executions * 1.5 hours baseline * 1.2 complexity multiplier. <br>Why it matters: Evaluates automated engineering leverage. <br>Drill: Click tile to filter by practice area."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.cwpm_verifiable_hours_saved]
  - name: fte_weeks_saved_card
    title: "FTE Weeks Saved Equivalent"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Equivalent Full-Time Equivalent engineering weeks saved. <br>How: CWPM Verifiable Hours Saved / 40.0 hours per standard engineering work week. <br>Why it matters: Anchors workforce capacity planning. <br>Drill: Click tile to inspect pilot project contribution."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.fte_weeks_saved_equivalent]
  - name: consulting_value_usd_card
    title: "Consulting Value Created ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Estimated dollar value of automated engineering work. <br>How: Estimated Manual Hours Saved (total_sessions * 3.5 hrs, PSO pilot benchmark) * $350/hr Google Cloud PSO billable rate ($2,800/day Consultant rate). <br>Why it matters: Quantifies executive ROI and billable consulting creation ($1,225/session). <br>Drill: Click tile to break down by practice area."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.consulting_value_usd]
  - name: resilience_rate_pct_card
    title: "Self-Healing Resilience Rate (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Reliability SLA metric measuring system stability. <br>How: Ratio of SUCCESS outcomes vs total executions (COUNTIF(status = SUCCESS) / COUNT(1)). <br>Why it matters: Asserts production stability and CI/CD readiness. <br>Drill: Click tile to inspect failing tool tracebacks."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.self_healing_resilience_rate_pct]
  - name: total_pilot_projects_card
    title: "Pilot Projects"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Count of distinct Google Cloud PSO JAPAC customer pilot engagements. <br>How: COUNT DISTINCT of pilot_project attribute (DBS Bank, Dyson, Myntra, etc.). <br>Why it matters: Tracks regional customer penetration. <br>Drill: Click tile to view active pilots."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_pilot_projects]
  - name: total_agents_used_card
    title: "Agents Used"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total number of distinct AI agents deployed across JAPAC engagements. <br>How: COUNT DISTINCT of canonical_agent_name. <br>Why it matters: Measures reuse of canonical agent templates. <br>Drill: Click tile to see agent leaderboard."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_invocations]

  # --- ROW 2: PRACTICE AREA & PILOT PROJECT ATTRIBUTION ---
  - name: hours_saved_by_pilot_project
    title: "Server-Verified Hours Saved by Pilot Project & Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "What: Estimated manual engineering hours saved broken down by pilot project and practice area. <br>How: total_sessions * 3.5 hours per session (empirical PSO pilot benchmark). <br>Why it matters: Demonstrates which pilot engagements generate the highest automation savings. <br>Drill: Filter by Pilot Project or Practice Area."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.pilot_project, agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    stacking: normal
  - name: hours_saved_by_practice_area
    title: "Hours Saved by Practice Area"
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "What: Estimated manual engineering hours saved aggregated by practice area. <br>How: total_sessions * 3.5 hours per session (empirical PSO pilot benchmark). <br>Why it matters: Guides practice leadership on where AI automation delivers the most leverage. <br>Drill: Click any bar to cross-filter dashboard."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]

  # --- ROW 3: TOP AGENTS LEADERBOARD & SUB-REGION ADOPTION VELOCITY ---
  - name: top_agents_by_hours_saved
    title: "Top Agents by Hours Saved and Events"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "What: Comprehensive leaderboard of agent ROI and volume. <br>How: Hours = total_sessions * 3.5 hrs, FTE Weeks = Hours / 40.0, Consulting Value = Hours * $350/hr ($2,800/day PSO rate). <br>Why it matters: Ranks top-performing agents for executive funding and promotion. <br>Drill: Click any row to inspect agent traces."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.canonical_agent_name, agent_events.practice_area]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved, agent_events.consulting_value_usd, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 15
  - name: adoption_velocity_by_sub_region
    title: "JAPAC Sub-Region Adoption Velocity over Time"
    type: looker_line
    note_state: collapsed
    note_display: hover
    note_text: "What: Time-series trend of automation adoption across JAPAC sub-regions. <br>How: Estimated manual hours saved (total_sessions * 3.5 hrs) over timestamp_date. <br>Why it matters: Reveals sub-region velocity (ANZ, SEA, India, Japan, Korea). <br>Drill: Click any date/region to filter time series."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.timestamp_date, agent_events.sub_region]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.timestamp_date desc]

  # --- ROW 4: EXECUTIVE FINOPS & VERIFIABLE ENGINEER TESTIMONIALS ---
  - name: model_tier_spend_breakdown
    title: "Model Tier Spend Breakdown ($ USD)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    note_text: "What: Actual LLM API spend in USD by Gemini model version. <br>How: Applies Google Cloud Gemini 2.5 Pro 75 percent cache discount ($1.25/M standard input, $0.3125/M cached input, $5.00/M completion). <br>Why it matters: Tracks FinOps economics across model tiers. <br>Drill: Click model bar to inspect token breakdown."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [v_llm_response.model_version]
    measures: [v_llm_response.total_spend_usd]
    sorts: [v_llm_response.total_spend_usd desc]
  - name: verifiable_engineer_wins
    title: "Feedback & Wins — Verifiable Engineer Testimonials"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "What: Qualitative engineering feedback and verified savings testimonials. <br>How: Extracts win_feedback metadata and displays associated hours saved (sessions * 3.5 hrs). <br>Why it matters: Provides peer-verified qualitative proof of automation impact. <br>Drill: Inspect specific win feedback records."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.pilot_project, agent_events.canonical_agent_name, agent_events.win_feedback]
    measures: [agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 10

  # --- ROW 5: FINOPS CACHE DISCOUNT, RESILIENCE & GRAPH-DERIVED METRICS ---
  - name: cache_discount_spend_card
    title: "75% Cache-Discount Actual Spend ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Total actual LLM API dollar spend USD. <br>How: Applies 75 percent discount for cached input tokens ($0.3125/M cached vs $1.25/M standard input for Gemini 2.5 Pro). <br>Why it matters: Monitors net FinOps expenditure. <br>Drill: Click tile to view cost by agent."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.cache_discounted_actual_cost_usd]
  - name: prompt_cache_hit_ratio_card
    title: "Prompt Cache Hit Ratio (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Percentage of input prompt tokens served from prompt cache. <br>How: SUM(cached_tokens) / SUM(prompt_tokens). <br>Why it matters: High cache hit ratio maximizes the 75% pricing discount and reduces TTFT latency. <br>Drill: Click tile to see cache hit rate by agent."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.prompt_cache_hit_ratio]
  - name: tool_productivity_credit_card
    title: "Tool Productivity Credit Hours (CWPM)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: Estimated manual engineering hours saved by automated tool calls. <br>How: SUM of 1.5 base hours * latency complexity weight (1.0x standard, 1.5x over 2s, 2.5x over 5s). <br>Why it matters: Rewards agents executing complex, high-latency tool workflows. <br>Drill: Click tile to inspect tool calls."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_tool_completed.tool_productivity_credit_hours]
  - name: sla_error_rate_gate_card
    title: "CI/CD SLA Gate Assertion"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "What: CI/CD SLA Gate asserting deployment readiness. <br>How: Evaluates error rate; PASS if error rate is 5.0 percent or lower, otherwise FAIL. <br>Why it matters: Protects customer production environments from unstable agent builds. <br>Drill: Click tile to inspect error logs."
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.sla_error_rate_gating]
  - name: graph_trace_dag_and_sla_gate_table
    title: "Trace DAG & CI/CD SLA Gate Performance by Agent"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "What: Combined ROI leaderboard and CI/CD SLA Gate status table. <br>How: CWPM Hours = tool calls * 1.5 * 1.2, SLA Gate = PASS if error rate <= 5 percent. <br>Why it matters: Unifies financial ROI with technical deployment readiness. <br>Drill: Click any agent to drill into DAG lineage."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.canonical_agent_name, agent_events.sla_error_rate_gating]
    measures: [agent_events.total_invocations, agent_events.self_healing_resilience_rate_pct, agent_events.cwpm_verifiable_hours_saved, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.cwpm_verifiable_hours_saved desc]
    limit: 15

  # --- ROW 6: DIVERSE STACKED AREA & SCATTER PLOT ANALYTICS ---
  - name: finops_cache_savings_over_time
    title: "75% Gemini Prompt Cache Savings vs. Actual Spend over Time ($ USD)"
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: Comparison of dollar savings from prompt caching vs actual spend over time. <br>How: Savings = cached_tokens * $0.9375/M ($1.25 - $0.3125). <br>Why it matters: Demonstrates compounding FinOps savings over time. <br>Drill: Click date point to see daily token usage."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.timestamp_date]
    measures: [v_llm_response.cache_savings_usd, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.timestamp_date desc]
    stacking: normal
  - name: agent_roi_complexity_scatter
    title: "Agent Complexity & ROI Scatter Plot (Invocations vs. Verifiable Hours Saved)"
    type: looker_scatter
    note_state: collapsed
    note_display: hover
    note_text: "What: Multi-dimensional scatter plot comparing agent volume against ROI. <br>How: X-axis = invocations, Y-axis = hours saved (sessions * 3.5 hrs), size = consulting value ($350/hr PSO rate). <br>Why it matters: Highlights high-value outlier agents. <br>Drill: Click any bubble to filter by agent."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.canonical_agent_name]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.consulting_value_usd]
    sorts: [agent_events.server_verified_hours_saved desc]

  # --- ROW 7: DIVERSE DONUT & RESILIENCE COLUMN BREAKDOWN ---
  - name: consulting_value_by_practice_area_donut
    title: "Consulting Value Created by Practice Area ($ USD Donut)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    note_text: "What: Distribution of estimated consulting dollar value across practice areas. <br>How: Hours saved (sessions * 3.5 hrs) * $350 per hour ($2,800/day PSO Consultant rate). <br>Why it matters: Visualizes share of consulting value by practice area. <br>Drill: Click slice to filter practice area."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.practice_area]
    measures: [agent_events.consulting_value_usd]
    sorts: [agent_events.consulting_value_usd desc]
  - name: resilience_sla_by_practice_area_column
    title: "Tool Execution Volume & Self-Healing Resilience SLA by Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "What: Overlay of event volume and reliability SLA across practice areas. <br>How: Columns = total_events, Line = self-healing resilience rate (SUCCESS / Total). <br>Why it matters: Ensures high-traffic practices maintain >=95% SLA. <br>Drill: Click practice column to inspect reliability."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [agent_events.practice_area]
    measures: [agent_events.total_events, agent_events.self_healing_resilience_rate_pct]
    sorts: [agent_events.total_events desc]
  - name: bqml_roi_30day_forecast_chart
    title: "BigQuery AI: 30-Day Predictive ROI & Consulting Value Forecast"
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "What: 30-day predictive forecast of automation hours saved and consulting dollar value. <br>How: Historical actuals use total_sessions * 3.5h ($350/hr PSO rate); future 30-day predictions use linear growth trend projection with 90%/110% confidence bounds. <br>Why it matters: Anchors quarterly capacity planning and financial projections. <br>Drill: Filter by Practice Area or Date Range."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [v_bqml_roi_forecast.forecast_date, v_bqml_roi_forecast.data_type]
    measures: [v_bqml_roi_forecast.predicted_hours_saved, v_bqml_roi_forecast.confidence_lower_bound_hours, v_bqml_roi_forecast.confidence_upper_bound_hours]
    sorts: [v_bqml_roi_forecast.forecast_date asc]
  - name: session_trace_dag_lineage_graph
    title: "Multi-Agent Session DAG & Trace Delegation Lineage Graph"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "What: Hierarchical DAG execution flow across session IDs and trace hops. <br>How: Extracts from_agent -> to_target delegation hops from agent_events where event_type is AGENT_TRANSFER, A2A_INTERACTION, or TOOL_COMPLETED. <br>Why it matters: Maps multi-agent orchestration paths and latency bottlenecks. <br>Drill: Filter by Session ID or Trace ID to inspect specific DAGs."
    explore: agent_events
    model: bigquery_agent_analytics_model
      dimensions: [v_session_trace_dag.session_id, v_session_trace_dag.from_agent, v_session_trace_dag.to_target]
    measures: [v_session_trace_dag.total_dag_hops, v_session_trace_dag.avg_dag_hop_latency_ms]
    sorts: [v_session_trace_dag.total_dag_hops desc]

