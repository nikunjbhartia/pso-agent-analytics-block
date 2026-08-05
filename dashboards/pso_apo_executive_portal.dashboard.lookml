- dashboard: pso_apo_executive_portal
  title: "APO Portal: Google Cloud PSO JAPAC Agent Program Office"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: "Canonical Executive Dashboard for Google Cloud PSO JAPAC APO (Agent Program Office) — Server-Verified Hours Saved, Practice Area Attribution, Pilot Projects, and FTE Value Creation."
  tabs:
  - name: "Executive ROI & Value"
    label: "Executive ROI & Value"
    title: "Executive ROI & Value"
  - name: "Pilot Projects & Practice Areas"
    label: "Pilot Projects & Practice Areas"
    title: "Pilot Projects & Practice Areas"
  - name: "Model Tier & FinOps Economics"
    label: "Model Tier & FinOps Economics"
    title: "Model Tier & FinOps Economics"
  - name: "SLA Governance & Testimonials"
    label: "SLA Governance & Testimonials"
    title: "SLA Governance & Testimonials"

  filters:
  - name: date_filter
    title: "Date Range"
    type: date_filter
    default_value: "last 30 days"
    allow_multiple_values: true
    required: false
  - name: practice_area_filter
    title: "Practice Area"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.practice_area
  - name: sub_region_filter
    title: "JAPAC Sub-Region"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.sub_region
  - name: pilot_project_filter
    title: "Pilot Project"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.pilot_project
  - name: agent_name_filter
    title: "Canonical Agent Name"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.canonical_agent_name
  - name: trace_id_filter
    title: "Trace ID"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.trace_id
  - name: session_id_filter
    title: "Session ID"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.session_id

  elements:
  - type: button
    name: "nav_btn_perf_Executive_ROI_and_Value"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Executive ROI & Value"
  - type: button
    name: "nav_btn_usage_Executive_ROI_and_Value"
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Executive ROI & Value"
  - type: button
    name: "nav_btn_perf_Pilot_Projects_and_Practice_Areas"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Pilot Projects & Practice Areas"
  - type: button
    name: "nav_btn_usage_Pilot_Projects_and_Practice_Areas"
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Pilot Projects & Practice Areas"
  - type: button
    name: "nav_btn_perf_Model_Tier_and_FinOps_Economics"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Model Tier & FinOps Economics"
  - type: button
    name: "nav_btn_usage_Model_Tier_and_FinOps_Economics"
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Model Tier & FinOps Economics"
  - type: button
    name: "nav_btn_perf_SLA_Governance_and_Testimonials"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "SLA Governance & Testimonials"
  - type: button
    name: "nav_btn_usage_SLA_Governance_and_Testimonials"
    rich_content_json: '{"text":"Usage Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_usage"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "SLA Governance & Testimonials"
  - name: "CWPM Verifiable Hours Saved"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.cwpm_verifiable_hours_saved]
    note_text: "<div style='text-align: left;'>What: Estimated productivity hours saved by automated tool calls.  <br><br>How: Count of completed tool executions * 1.5 hours baseline * 1.2 complexity multiplier.  <br><br>Why it matters: Evaluates automated engineering leverage.  <br><br>Drill: Click tile to filter by practice area.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 2
    col: 0
    width: 8
    height: 4
  - name: "FTE Weeks Saved Equivalent"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.fte_weeks_saved_equivalent]
    note_text: "<div style='text-align: left;'>What: Equivalent Full-Time Equivalent engineering weeks saved.  <br><br>How: CWPM Verifiable Hours Saved / 40.0 hours per standard engineering work week.  <br><br>Why it matters: Anchors workforce capacity planning.  <br><br>Drill: Click tile to inspect pilot project contribution.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Consulting Value Created ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.consulting_value_usd]
    note_text: "<div style='text-align: left;'>What: Estimated dollar value of automated engineering work.  <br><br>How: Estimated Manual Hours Saved (total_sessions * 3.5 hrs, PSO pilot benchmark) * $350/hr Google Cloud PSO billable rate ($2,800/day Consultant rate).  <br><br>Why it matters: Quantifies executive ROI and billable consulting creation ($1,225/session).  <br><br>Drill: Click tile to break down by practice area.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 2
    col: 16
    width: 8
    height: 4
  - name: "Self-Healing Resilience Rate (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.self_healing_resilience_rate_pct]
    note_text: "<div style='text-align: left;'>What it is: The percentage of agent tool errors that were automatically self-corrected and resolved by the AI agent without human intervention. <br><br>How it is calculated: Automatically recovered tool errors divided by total tool errors. <br><br>Why it matters: Measures how resilient and self-reliant our AI agents are when encountering temporary API or network glitches. <br><br>Drill down: Click this tile to see resilience performance across individual agents.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 6
    col: 0
    width: 8
    height: 4
  - name: "Pilot Projects"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_pilot_projects]
    note_text: "<div style='text-align: left;'>What: Count of distinct Google Cloud PSO JAPAC customer pilot engagements.  <br><br>How: COUNT DISTINCT of pilot_project attribute (DBS Bank, Dyson, Myntra, etc.).  <br><br>Why it matters: Tracks regional customer penetration.  <br><br>Drill: Click tile to view active pilots.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 6
    col: 8
    width: 8
    height: 4
  - name: "Agents Used"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.total_invocations]
    # --- ROW 2: PRACTICE AREA & PILOT PROJECT ATTRIBUTION ---
    note_text: "<div style='text-align: left;'>What: Total number of distinct AI agents deployed across JAPAC engagements.  <br><br>How: COUNT DISTINCT of canonical_agent_name.  <br><br>Why it matters: Measures reuse of canonical agent templates.  <br><br>Drill: Click tile to see agent leaderboard.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 6
    col: 16
    width: 8
    height: 4
  - name: "Server-Verified Hours Saved by Pilot Project & Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.pilot_project, agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    stacking: normal
    note_text: "<div style='text-align: left;'>What: Estimated manual engineering hours saved broken down by pilot project and practice area.  <br><br>How: total_sessions * 3.5 hours per session (empirical PSO pilot benchmark).  <br><br>Why it matters: Demonstrates which pilot engagements generate the highest automation savings.  <br><br>Drill: Filter by Pilot Project or Practice Area.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Pilot Projects & Practice Areas"
    row: 2
    col: 0
    width: 12
    height: 7
  - name: "Hours Saved by Practice Area"
    type: looker_bar
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    # --- ROW 3: TOP AGENTS LEADERBOARD & SUB-REGION ADOPTION VELOCITY ---
    note_text: "<div style='text-align: left;'>What: Estimated manual engineering hours saved aggregated by practice area.  <br><br>How: total_sessions * 3.5 hours per session (empirical PSO pilot benchmark).  <br><br>Why it matters: Guides practice leadership on where AI automation delivers the most leverage.  <br><br>Drill: Click any bar to cross-filter dashboard.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 10
    col: 0
    width: 12
    height: 7
  - name: "Top Agents by Hours Saved and Events"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name, agent_events.practice_area]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved, agent_events.consulting_value_usd, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 15
    note_text: "<div style='text-align: left;'>What: Comprehensive leaderboard of agent ROI and volume.  <br><br>How: Hours = total_sessions * 3.5 hrs, FTE Weeks = Hours / 40.0, Consulting Value = Hours * $350/hr ($2,800/day PSO rate).  <br><br>Why it matters: Ranks top-performing agents for executive funding and promotion.  <br><br>Drill: Click any row to inspect agent traces.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Pilot Projects & Practice Areas"
    row: 16
    col: 0
    width: 24
    height: 8
  - name: "JAPAC Sub-Region Adoption Velocity over Time"
    type: looker_line
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.timestamp_date, agent_events.sub_region]
    measures: [agent_events.server_verified_hours_saved]
    sorts: [agent_events.timestamp_date desc]
    # --- ROW 4: EXECUTIVE FINOPS & VERIFIABLE ENGINEER TESTIMONIALS ---
    note_text: "<div style='text-align: left;'>What: Time-series trend of automation adoption across JAPAC sub-regions.  <br><br>How: Estimated manual hours saved (total_sessions * 3.5 hrs) over timestamp_date.  <br><br>Why it matters: Reveals sub-region velocity (ANZ, SEA, India, Japan, Korea).  <br><br>Drill: Click any date/region to filter time series.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 10
    col: 12
    width: 12
    height: 7
  - name: "Model Tier Spend Breakdown ($ USD)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_llm_response.model_version]
    measures: [v_llm_response.total_spend_usd]
    sorts: [v_llm_response.total_spend_usd desc]
    note_text: "<div style='text-align: left;'>What: Actual LLM API spend in USD by Gemini model version.  <br><br>How: Applies Google Cloud Gemini 2.5 Pro 75 percent cache discount ($1.25/M standard input, $0.3125/M cached input, $5.00/M completion).  <br><br>Why it matters: Tracks FinOps economics across model tiers.  <br><br>Drill: Click model bar to inspect token breakdown.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Model Tier & FinOps Economics"
    row: 6
    col: 0
    width: 12
    height: 7
  - name: "Feedback & Wins — Verifiable Engineer Testimonials"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.pilot_project, agent_events.canonical_agent_name, agent_events.win_feedback]
    measures: [agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved]
    sorts: [agent_events.server_verified_hours_saved desc]
    limit: 10
    # --- ROW 5: FINOPS CACHE DISCOUNT, RESILIENCE & GRAPH-DERIVED METRICS ---
    note_text: "<div style='text-align: left;'>What: Qualitative engineering feedback and verified savings testimonials.  <br><br>How: Extracts win_feedback metadata and displays associated hours saved (sessions * 3.5 hrs).  <br><br>Why it matters: Provides peer-verified qualitative proof of automation impact.  <br><br>Drill: Inspect specific win feedback records.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "SLA Governance & Testimonials"
    row: 14
    col: 0
    width: 24
    height: 8
  - name: "75% Cache-Discount Actual Spend ($ USD)"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.cache_discounted_actual_cost_usd]
    note_text: "<div style='text-align: left;'>What: Total actual LLM API dollar spend USD.  <br><br>How: Applies 75 percent discount for cached input tokens ($0.3125/M cached vs $1.25/M standard input for Gemini 2.5 Pro).  <br><br>Why it matters: Monitors net FinOps expenditure.  <br><br>Drill: Click tile to view cost by agent.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Model Tier & FinOps Economics"
    row: 2
    col: 12
    width: 12
    height: 4
  - name: "Prompt Cache Hit Ratio (%)"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_llm_response.prompt_cache_hit_ratio]
    note_text: "<div style='text-align: left;'>What: Percentage of input prompt tokens served from prompt cache.  <br><br>How: SUM(cached_tokens) / SUM(prompt_tokens).  <br><br>Why it matters: High cache hit ratio maximizes the 75% pricing discount and reduces TTFT latency.  <br><br>Drill: Click tile to see cache hit rate by agent.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Model Tier & FinOps Economics"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "Tool Productivity Credit Hours (CWPM)"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [v_tool_completed.tool_productivity_credit_hours]
    note_text: "<div style='text-align: left;'>What: Estimated manual engineering hours saved by automated tool calls.  <br><br>How: SUM of 1.5 base hours * latency complexity weight (1.0x standard, 1.5x over 2s, 2.5x over 5s).  <br><br>Why it matters: Rewards agents executing complex, high-latency tool workflows.  <br><br>Drill: Click tile to inspect tool calls.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "SLA Governance & Testimonials"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "CI/CD SLA Gate Assertion"
    type: single_value
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    measures: [agent_events.sla_error_rate_gating]
    note_text: "<div style='text-align: left;'>What: CI/CD SLA Gate asserting deployment readiness.  <br><br>How: Evaluates error rate; PASS if error rate is 5.0 percent or lower, otherwise FAIL.  <br><br>Why it matters: Protects customer production environments from unstable agent builds.  <br><br>Drill: Click tile to inspect error logs.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "SLA Governance & Testimonials"
    row: 2
    col: 12
    width: 12
    height: 4
  - name: "Trace DAG & CI/CD SLA Gate Performance by Agent"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name, agent_events.sla_error_rate_gating]
    measures: [agent_events.total_invocations, agent_events.self_healing_resilience_rate_pct, agent_events.cwpm_verifiable_hours_saved, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.cwpm_verifiable_hours_saved desc]
    limit: 15
    # --- ROW 6: DIVERSE STACKED AREA & SCATTER PLOT ANALYTICS ---
    note_text: "<div style='text-align: left;'>What it is: Visual trace DAG and conversation lineage showing how agents delegate tasks to tools and subagents. <br><br>How it is calculated: Hierarchical trace and span ID relationships captured by open-telemetry plugins. <br><br>Why it matters: Allows engineering teams to debug execution paths and verify multi-agent delegation logic. <br><br>Drill down: Click a node to trace full session history.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "SLA Governance & Testimonials"
    row: 6
    col: 0
    width: 24
    height: 8
  - name: "75% Gemini Prompt Cache Savings vs Actual Spend over Time ($ USD)"
    type: looker_area
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.timestamp_date]
    measures: [v_llm_response.cache_savings_usd, v_llm_response.cache_discounted_actual_cost_usd]
    sorts: [agent_events.timestamp_date desc]
    stacking: normal
    note_text: "<div style='text-align: left;'>What: Comparison of dollar savings from prompt caching vs actual spend over time.  <br><br>How: Savings = cached_tokens * $0.9375/M ($1.25 - $0.3125).  <br><br>Why it matters: Demonstrates compounding FinOps savings over time.  <br><br>Drill: Click date point to see daily token usage.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Model Tier & FinOps Economics"
    row: 6
    col: 12
    width: 12
    height: 7
  - name: "Agent Complexity & ROI Scatter Plot (Invocations vs Verifiable Hours Saved)"
    type: looker_scatter
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.canonical_agent_name]
    measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.consulting_value_usd]
    sorts: [agent_events.server_verified_hours_saved desc]
    # --- ROW 7: DIVERSE DONUT & RESILIENCE COLUMN BREAKDOWN ---
    note_text: "<div style='text-align: left;'>What: Multi-dimensional scatter plot comparing agent volume against ROI.  <br><br>How: X-axis = invocations, Y-axis = hours saved (sessions * 3.5 hrs), size = consulting value ($350/hr PSO rate).  <br><br>Why it matters: Highlights high-value outlier agents.  <br><br>Drill: Click any bubble to filter by agent.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Pilot Projects & Practice Areas"
    row: 9
    col: 12
    width: 12
    height: 7
  - name: "Consulting Value Created by Practice Area ($ USD Donut)"
    type: looker_pie
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.consulting_value_usd]
    sorts: [agent_events.consulting_value_usd desc]
    note_text: "<div style='text-align: left;'>What: Distribution of estimated consulting dollar value across practice areas.  <br><br>How: Hours saved (sessions * 3.5 hrs) * $350 per hour ($2,800/day PSO Consultant rate).  <br><br>Why it matters: Visualizes share of consulting value by practice area.  <br><br>Drill: Click slice to filter practice area.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Pilot Projects & Practice Areas"
    row: 2
    col: 12
    width: 12
    height: 7
  - name: "Tool Execution Volume & Self-Healing Resilience SLA by Practice Area"
    type: looker_column
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [agent_events.practice_area]
    measures: [agent_events.total_events, agent_events.self_healing_resilience_rate_pct]
    sorts: [agent_events.total_events desc]
    note_text: "<div style='text-align: left;'>What it is: The percentage of agent tool errors that were automatically self-corrected and resolved by the AI agent without human intervention. <br><br>How it is calculated: Automatically recovered tool errors divided by total tool errors. <br><br>Why it matters: Measures how resilient and self-reliant our AI agents are when encountering temporary API or network glitches. <br><br>Drill down: Click this tile to see resilience performance across individual agents.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Pilot Projects & Practice Areas"
    row: 9
    col: 0
    width: 12
    height: 7
  - name: "BigQuery AI: 30-Day Predictive ROI & Consulting Value Forecast"
    type: looker_area
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_bqml_roi_forecast.forecast_date, v_bqml_roi_forecast.data_type]
    measures: [v_bqml_roi_forecast.predicted_hours_saved, v_bqml_roi_forecast.confidence_lower_bound_hours, v_bqml_roi_forecast.confidence_upper_bound_hours]
    sorts: [v_bqml_roi_forecast.forecast_date asc]
    note_text: "<div style='text-align: left;'>What it is: Predictive 30-day ROI and hours-saved forecast generated using BigQuery ML. <br><br>How it is calculated: ARIMA time-series model trained on historical verified hours saved. <br><br>Why it matters: Gives leadership forward-looking visibility into future engineering capacity savings. <br><br>Drill down: Click a data point to inspect forecast confidence intervals.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "Executive ROI & Value"
    row: 17
    col: 0
    width: 24
    height: 7
  - name: "Multi-Agent Session DAG & Trace Delegation Lineage Graph"
    type: looker_column
    note_state: collapsed
    note_display: hover
    explore: agent_events
    model: bigquery_agent_analytics_model
    dimensions: [v_session_trace_dag.session_id, v_session_trace_dag.from_agent, v_session_trace_dag.to_target]
    measures: [v_session_trace_dag.total_dag_hops, v_session_trace_dag.avg_dag_hop_latency_ms]
    sorts: [v_session_trace_dag.total_dag_hops desc]
    note_text: "<div style='text-align: left;'>What it is: Visual trace DAG and conversation lineage showing how agents delegate tasks to tools and subagents. <br><br>How it is calculated: Hierarchical trace and span ID relationships captured by open-telemetry plugins. <br><br>Why it matters: Allows engineering teams to debug execution paths and verify multi-agent delegation logic. <br><br>Drill down: Click a node to trace full session history.</div>"
    listen:
      date_filter: agent_events.timestamp_date
      practice_area_filter: agent_events.practice_area
      sub_region_filter: agent_events.sub_region
      pilot_project_filter: agent_events.pilot_project
      agent_name_filter: agent_events.canonical_agent_name
      trace_id_filter: agent_events.trace_id
      session_id_filter: agent_events.session_id
    tab_name: "SLA Governance & Testimonials"
    row: 22
    col: 0
    width: 24
    height: 8
