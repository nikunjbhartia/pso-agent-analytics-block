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

  tabs:
  - name: Executive ROI & Value
    label: Executive ROI & Value
    title: Executive ROI & Value
  - name: Pilot Projects & Practice Areas
    label: Pilot Projects & Practice Areas
    title: Pilot Projects & Practice Areas
  - name: Model Tier & FinOps Economics
    label: Model Tier & FinOps Economics
    title: Model Tier & FinOps Economics
  - name: SLA Governance & Testimonials
    label: SLA Governance & Testimonials
    title: SLA Governance & Testimonials
  elements:
  - type: button
    name: nav_btn_perf_Executive_ROI_&_Value
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: Executive ROI & Value
  - type: button
    name: nav_btn_usage_Executive_ROI_&_Value
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: Executive ROI & Value
  - type: button
    name: nav_btn_perf_Pilot_Projects_&_Practice_Areas
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: Pilot Projects & Practice Areas
  - type: button
    name: nav_btn_usage_Pilot_Projects_&_Practice_Areas
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: Pilot Projects & Practice Areas
  - type: button
    name: nav_btn_perf_Model_Tier_&_FinOps_Economics
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: Model Tier & FinOps Economics
  - type: button
    name: nav_btn_usage_Model_Tier_&_FinOps_Economics
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: Model Tier & FinOps Economics
  - type: button
    name: nav_btn_perf_SLA_Governance_&_Testimonials
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 4
    height: 1
    tab_name: SLA Governance & Testimonials
  - type: button
    name: nav_btn_usage_SLA_Governance_&_Testimonials
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"center","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 5
    width: 4
    height: 1
    tab_name: SLA Governance & Testimonials

    tab_name: Executive ROI & Value
    row: 2
    col: 0
    width: 12
    height: 7
  - name: total_hours_saved_card
    title: "CWPM Verifiable Hours Saved"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.cwpm_verifiable_hours_saved]
    tab_name: Executive ROI & Value
    row: 2
    col: 0
    width: 8
    height: 4
  - name: fte_weeks_saved_card
    title: "FTE Weeks Saved Equivalent"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The total hours saved expressed as full-time engineering work weeks. <br><br>How it is calculated: Total Hours Saved divided by 40 hours per standard work week. <br><br>Why it matters: Helps executives and team leaders understand how many extra full-time engineers of capacity the AI agents are contributing. <br><br>Drill down: Click this tile to see the breakdown by customer pilot project.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.fte_weeks_saved_equivalent]
    tab_name: Executive ROI & Value
    row: 6
    col: 0
    width: 8
    height: 4
  - name: consulting_value_usd_card
    title: "Consulting Value Created ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The estimated dollar value of the professional engineering work automated by our AI agents. <br><br>How it is calculated: Total automated hours saved multiplied by the standard Google Cloud consulting rate of $350 per hour. <br><br>Why it matters: Converts time savings into concrete financial ROI and consulting value creation for executive reporting. <br><br>Drill down: Click this tile to inspect consulting value created across practice areas.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.consulting_value_usd]
    tab_name: Executive ROI & Value
    row: 10
    col: 0
    width: 8
    height: 4
  - name: resilience_rate_pct_card
    title: "Self-Healing Resilience Rate (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The percentage of agent tool errors that were automatically self-corrected and resolved by the AI agent without human intervention. <br><br>How it is calculated: Automatically recovered tool errors divided by total tool errors. <br><br>Why it matters: Measures how resilient and self-reliant our AI agents are when encountering temporary API or network glitches. <br><br>Drill down: Click this tile to see resilience performance across individual agents.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.self_healing_resilience_rate_pct]
    tab_name: Executive ROI & Value
    row: 14
    col: 0
    width: 8
    height: 4
  - name: total_pilot_projects_card
    title: "Pilot Projects"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The total number of distinct customer pilot projects actively using our AI agents (e.g., DBS Bank, Dyson, Myntra). <br><br>How it is calculated: Count of unique customer project names logged in agent sessions. <br><br>Why it matters: Tracks customer adoption and shows how broadly our AI solutions are deployed across the region. <br><br>Drill down: Click this tile to view active customer engagements.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_pilot_projects]
    tab_name: Executive ROI & Value
    row: 18
    col: 12
    width: 12
    height: 7
  - name: total_agents_used_card
    title: "Agents Used"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The total number of distinct AI agents deployed and actively running across all customer projects. <br><br>How it is calculated: Count of unique agent names present in telemetry logs. <br><br>Why it matters: Measures the breadth and diversity of our AI agent catalog in active use. <br><br>Drill down: Click this tile to view the full agent leaderboard.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_invocations]

  # --- ROW 2: PRACTICE AREA & PILOT PROJECT ATTRIBUTION ---
    tab_name: Executive ROI & Value
    row: 25
    col: 12
    width: 12
    height: 7
  - name: hours_saved_by_pilot_project
    title: "Server-Verified Hours Saved by Pilot Project & Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.pilot_project, agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    stacking: normal
    tab_name: Executive ROI & Value
    row: 32
    col: 12
    width: 12
    height: 7
  - name: hours_saved_by_practice_area
    title: "Hours Saved by Practice Area"
    type: looker_bar
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]

  # --- ROW 3: TOP AGENTS LEADERBOARD & SUB-REGION ADOPTION VELOCITY ---
    tab_name: Executive ROI & Value
    row: 39
    col: 12
    width: 12
    height: 7
  - name: top_agents_by_hours_saved
    title: "Top Agents by Hours Saved and Events"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name, agent_events.practice_area]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved, agent_events.consulting_value_usd, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 15
    tab_name: Pilot Projects & Practice Areas
    row: 2
    col: 0
    width: 24
    height: 8
  - name: adoption_velocity_by_sub_region
    title: "JAPAC Sub-Region Adoption Velocity over Time"
    type: looker_line
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.timestamp_date, agent_events.sub_region]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.timestamp_date desc]

  # --- ROW 4: EXECUTIVE FINOPS & VERIFIABLE ENGINEER TESTIMONIALS ---
    tab_name: Executive ROI & Value
    row: 46
    col: 12
    width: 12
    height: 7
  - name: model_tier_spend_breakdown
    title: "Model Tier Spend Breakdown ($ USD)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_llm_response.model_version]
    measures: [v_llm_response.total_spend_usd]
    sorts: [v_llm_response.total_spend_usd desc]
    tab_name: Model Tier & FinOps Economics
    row: 2
    col: 0
    width: 12
    height: 7
  - name: verifiable_engineer_wins
    title: "Feedback & Wins — Verifiable Engineer Testimonials"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.pilot_project, agent_events.canonical_agent_name, agent_events.win_feedback]
    measures: [agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 10

  # --- ROW 5: FINOPS CACHE DISCOUNT, RESILIENCE & GRAPH-DERIVED METRICS ---
    tab_name: Executive ROI & Value
    row: 53
    col: 12
    width: 12
    height: 7
  - name: cache_discount_spend_card
    title: "75% Cache-Discount Actual Spend ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The actual dollar cost spent on Gemini model usage after applying prompt caching discounts. <br><br>How it is calculated: Cost of cached tokens plus cost of newly evaluated tokens based on official Google Cloud Gemini pricing. <br><br>Why it matters: Tracks our actual FinOps cloud spending and demonstrates the cost savings achieved through prompt caching. <br><br>Drill down: Click this tile to view daily spend trends.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.cache_discounted_actual_cost_usd]
    tab_name: Executive ROI & Value
    row: 60
    col: 12
    width: 12
    height: 7
  - name: prompt_cache_hit_ratio_card
    title: "Prompt Cache Hit Ratio (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The percentage of input prompt tokens that were served from high-speed cache instead of being re-processed from scratch. <br><br>How it is calculated: Cached prompt tokens divided by total prompt tokens submitted. <br><br>Why it matters: Higher cache hit ratios drastically reduce LLM latency and cut Gemini token costs by up to 75%. <br><br>Drill down: Click this tile to view cache efficiency by model tier.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.prompt_cache_hit_ratio]
    tab_name: Model Tier & FinOps Economics
    row: 2
    col: 0
    width: 12
    height: 4
  - name: tool_productivity_credit_card
    title: "Tool Productivity Credit Hours (CWPM)"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Total engineering effort hours credited to individual automated tools and remote functions. <br><br>How it is calculated: Sum of productivity hours earned across all completed tool calls. <br><br>Why it matters: Identifies exactly which backend tools and integrations deliver the highest labor savings. <br><br>Drill down: Click this tile to filter tool productivity leaderboards.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_tool_completed.tool_productivity_credit_hours]
    tab_name: Executive ROI & Value
    row: 67
    col: 12
    width: 12
    height: 7
  - name: sla_error_rate_gate_card
    title: "CI/CD SLA Gate Assertion"
    type: single_value
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The frequency and total count of errors encountered during agent tool executions. <br><br>How it is calculated: Total count of error events logged by backend plugins. <br><br>Why it matters: Identifies API failures, schema mismatches, and integration bottlenecks. <br><br>Drill down: Click this tile to inspect detailed error logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.sla_error_rate_gating]
    tab_name: Executive ROI & Value
    row: 74
    col: 12
    width: 12
    height: 7
  - name: graph_trace_dag_and_sla_gate_table
    title: "Trace DAG & CI/CD SLA Gate Performance by Agent"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Automated quality check that confirms whether our AI agents are meeting their required speed and reliability SLAs. <br><br>How it is calculated: Evaluates whether agent error rates and latencies are within acceptable enterprise thresholds (PASS or FAIL). <br><br>Why it matters: Provides an immediate governance gate to ensure production-grade reliability before deployment. <br><br>Drill down: Click this tile to inspect individual agent SLA status.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name, agent_events.sla_error_rate_gating]
    measures: [agent_events.total_invocations, agent_events.self_healing_resilience_rate_pct, agent_events.cwpm_verifiable_hours_saved, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.cwpm_verifiable_hours_saved desc]
    limit: 15

  # --- ROW 6: DIVERSE STACKED AREA & SCATTER PLOT ANALYTICS ---
    tab_name: Executive ROI & Value
    row: 81
    col: 12
    width: 12
    height: 7
  - name: finops_cache_savings_over_time
    title: "75% Gemini Prompt Cache Savings vs. Actual Spend over Time ($ USD)"
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.timestamp_date]
    measures: [v_llm_response.cache_savings_usd, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.timestamp_date desc]
    stacking: normal
    tab_name: Executive ROI & Value
    row: 88
    col: 12
    width: 12
    height: 7
  - name: agent_roi_complexity_scatter
    title: "Agent Complexity & ROI Scatter Plot (Invocations vs. Verifiable Hours Saved)"
    type: looker_scatter
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.consulting_value_usd]
    sorts: [agent_events.server_verified_hours_saved desc]

  # --- ROW 7: DIVERSE DONUT & RESILIENCE COLUMN BREAKDOWN ---
    tab_name: Executive ROI & Value
    row: 95
    col: 12
    width: 12
    height: 7
  - name: consulting_value_by_practice_area_donut
    title: "Consulting Value Created by Practice Area ($ USD Donut)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: The estimated dollar value of the professional engineering work automated by our AI agents. <br><br>How it is calculated: Total automated hours saved multiplied by the standard Google Cloud consulting rate of $350 per hour. <br><br>Why it matters: Converts time savings into concrete financial ROI and consulting value creation for executive reporting. <br><br>Drill down: Click this tile to inspect consulting value created across practice areas.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.consulting_value_usd]
    sorts: [agent_events.consulting_value_usd desc]
    tab_name: Executive ROI & Value
    row: 102
    col: 12
    width: 12
    height: 7
  - name: resilience_sla_by_practice_area_column
    title: "Tool Execution Volume & Self-Healing Resilience SLA by Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.total_events, agent_events.self_healing_resilience_rate_pct]
    sorts: [agent_events.total_events desc]
    tab_name: Executive ROI & Value
    row: 109
    col: 12
    width: 12
    height: 7
  - name: bqml_roi_30day_forecast_chart
    title: "BigQuery AI: 30-Day Predictive ROI & Consulting Value Forecast"
    type: looker_area
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_bqml_roi_forecast.forecast_date, v_bqml_roi_forecast.data_type]
    measures: [v_bqml_roi_forecast.predicted_hours_saved, v_bqml_roi_forecast.confidence_lower_bound_hours, v_bqml_roi_forecast.confidence_upper_bound_hours]
    sorts: [v_bqml_roi_forecast.forecast_date asc]
    tab_name: Executive ROI & Value
    row: 116
    col: 12
    width: 12
    height: 7
  - name: session_trace_dag_lineage_graph
    title: "Multi-Agent Session DAG & Trace Delegation Lineage Graph"
    type: looker_column
    note_state: collapsed
    note_display: hover
    note_text: "<div style=\"text-align: left;\">What it is: Total number of user interaction sessions and conversations with AI agents. <br><br>How it is calculated: Count of unique session IDs recorded in telemetry. <br><br>Why it matters: Measures overall user engagement, traffic volume, and adoption velocity. <br><br>Drill down: Click this tile to inspect individual session traces.</div>"
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_session_trace_dag.session_id, v_session_trace_dag.from_agent, v_session_trace_dag.to_target]
    measures: [v_session_trace_dag.total_dag_hops, v_session_trace_dag.avg_dag_hop_latency_ms]
    sorts: [v_session_trace_dag.total_dag_hops desc]

    tab_name: Executive ROI & Value
    row: 123
    col: 12
    width: 12
    height: 7
