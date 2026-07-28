- dashboard: pso_apo_executive_portal
  title: "APO Portal: Google Cloud PSO JAPAC Agent Program Office"
  layout: newspaper
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
      field: agent_events.practice_area
      default_value: ""
    - name: sub_region_filter
      title: "JAPAC Sub-Region"
      type: field_filter
      explore: agent_events
      field: agent_events.sub_region
      default_value: ""
    - name: pilot_project_filter
      title: "Pilot Project"
      type: field_filter
      explore: agent_events
      field: agent_events.pilot_project
      default_value: ""
    - name: agent_name_filter
      title: "Canonical Agent Name"
      type: field_filter
      explore: agent_events
      field: agent_events.canonical_agent_name
      default_value: ""

  elements:
    # --- ROW 1: EXECUTIVE HEADLINE SCORECARDS ("Verifiable & Real-Time") ---

    - name: total_hours_saved_card
      title: "CWPM Verifiable Hours Saved"
      type: single_value
      explore: agent_events
      measures: [agent_events.cwpm_verifiable_hours_saved]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: SUM(manual_baseline_hours * session_complexity_weight). Assumes 3.5 hrs baseline manual engineering time per automated session * 1.5x complexity weight."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 0
      width: 4
      height: 3

    - name: fte_weeks_saved_card
      title: "FTE Weeks Saved Equivalent"
      type: single_value
      explore: agent_events
      measures: [agent_events.fte_weeks_saved_equivalent]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: CWPM Verifiable Hours Saved / 40.0 hours per standard engineering work week."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 4
      width: 4
      height: 3

    - name: consulting_value_usd_card
      title: "Consulting Value Created ($ USD)"
      type: single_value
      explore: agent_events
      measures: [agent_events.consulting_value_usd]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: Server-Verified Hours Saved * $150/hr standard Google Cloud PSO engineering consulting rate."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 8
      width: 4
      height: 3

    - name: resilience_rate_pct_card
      title: "Self-Healing Resilience Rate (%)"
      type: single_value
      explore: agent_events
      measures: [agent_events.self_healing_resilience_rate_pct]
      note_state: collapsed
      note_display: hover
      note_text: "Reliability SLA Note: Primary self-healing resilience metric measuring ratio of SUCCESS outcomes vs total executions."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 12
      width: 4
      height: 3

    - name: total_pilot_projects_card
      title: "Pilot Projects"
      type: single_value
      explore: agent_events
      measures: [agent_events.total_pilot_projects]
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 16
      width: 4
      height: 3

    - name: total_agents_used_card
      title: "Agents Used"
      type: single_value
      explore: agent_events
      measures: [agent_events.total_invocations]
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 0
      col: 20
      width: 4
      height: 3

    # --- ROW 2: PRACTICE AREA & PILOT PROJECT ATTRIBUTION ---

    - name: hours_saved_by_pilot_project
      title: "Server-Verified Hours Saved by Pilot Project & Practice Area"
      type: looker_column
      explore: agent_events
      dimensions: [agent_events.pilot_project, agent_events.practice_area]
      measures: [agent_events.server_verified_hours_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
      stacking: normal
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: SUM(manual_baseline_hours) across pilot projects, assuming an average manual baseline of 3.5 hours per automated session."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 3
      col: 0
      width: 14
      height: 7

    - name: hours_saved_by_practice_area
      title: "Hours Saved by Practice Area"
      type: looker_bar
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.server_verified_hours_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: SUM(manual_baseline_hours) aggregated by practice area (3.5 hrs baseline per session)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 3
      col: 14
      width: 10
      height: 7

    # --- ROW 3: TOP AGENTS LEADERBOARD & SUB-REGION ADOPTION VELOCITY ---

    - name: top_agents_by_hours_saved
      title: "Top Agents by Hours Saved and Events"
      type: looker_grid
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name, agent_events.practice_area]
      measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved, agent_events.consulting_value_usd]
      sorts: [agent_events.server_verified_hours_saved desc]
      limit: 15
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Notes: Hours saved = SUM(manual_baseline_hours). FTE weeks = Hours / 40. Consulting Value = Hours * $150/hr."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 10
      col: 0
      width: 14
      height: 7

    - name: adoption_velocity_by_sub_region
      title: "JAPAC Sub-Region Adoption Velocity over Time"
      type: looker_line
      explore: agent_events
      dimensions: [agent_events.timestamp_date, agent_events.sub_region]
      measures: [agent_events.server_verified_hours_saved]
      sorts: [agent_events.timestamp_date desc]
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 10
      col: 14
      width: 10
      height: 7

    # --- ROW 4: EXECUTIVE FINOPS & VERIFIABLE ENGINEER TESTIMONIALS ---

    - name: model_tier_spend_breakdown
      title: "Model Tier Spend Breakdown ($ USD)"
      type: looker_pie
      explore: agent_events
      dimensions: [v_llm_response.model_version]
      measures: [v_llm_response.total_spend_usd]
      sorts: [v_llm_response.total_spend_usd desc]
      note_state: collapsed
      note_display: hover
      note_text: "FinOps Note: Spend calculated across model tiers incorporating 75% prompt caching discount where applicable."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 17
      col: 0
      width: 8
      height: 7

    - name: verifiable_engineer_wins
      title: "Feedback & Wins — Verifiable Engineer Testimonials"
      type: looker_grid
      explore: agent_events
      dimensions: [agent_events.pilot_project, agent_events.canonical_agent_name, agent_events.win_feedback]
      measures: [agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
      limit: 10
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Note: Verifiable Hours Saved estimated via SUM(manual_baseline_hours), defaulting to 3.5 hrs per session."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 17
      col: 8
      width: 16
      height: 7

    # --- ROW 5: FINOPS CACHE DISCOUNT, RESILIENCE & GRAPH-DERIVED METRICS ---

    - name: cache_discount_spend_card
      title: "75% Cache-Discount Actual Spend ($ USD)"
      type: single_value
      explore: agent_events
      measures: [v_llm_response.cache_discounted_actual_cost_usd]
      note_state: collapsed
      note_display: hover
      note_text: "FinOps Note: Applies 75% discount for cached input tokens ($0.25/M cached vs $1.00/M standard for Gemini 2.5 Pro)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 24
      col: 0
      width: 6
      height: 4

    - name: prompt_cache_hit_ratio_card
      title: "Prompt Cache Hit Ratio (%)"
      type: single_value
      explore: agent_events
      measures: [v_llm_response.prompt_cache_hit_ratio]
      note_state: collapsed
      note_display: hover
      note_text: "FinOps Note: Percentage of input tokens served from prompt cache (cached tokens / total prompt tokens)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 24
      col: 6
      width: 6
      height: 4

    - name: tool_productivity_credit_card
      title: "Tool Productivity Credit Hours (CWPM)"
      type: single_value
      explore: agent_events
      measures: [v_tool_completed.tool_productivity_credit_hours]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Formula: Each successful tool completion awards 1.5 hours * complexity weight based on latency (>2s = 1.5x, >5s = 2.5x)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 24
      col: 12
      width: 6
      height: 4

    - name: sla_error_rate_gate_card
      title: "CI/CD SLA Gate Assertion"
      type: single_value
      explore: agent_events
      measures: [agent_events.sla_error_rate_gating]
      note_state: collapsed
      note_display: hover
      note_text: "SLA Gate Note: Asserts CI/CD deployment readiness; PASS if error rate <= 5.0%, otherwise FAIL."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 24
      col: 18
      width: 6
      height: 4

    - name: graph_trace_dag_and_sla_gate_table
      title: "Trace DAG & CI/CD SLA Gate Performance by Agent"
      type: looker_grid
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name, agent_events.sla_error_rate_gating]
      measures: [agent_events.total_invocations, agent_events.self_healing_resilience_rate_pct, agent_events.cwpm_verifiable_hours_saved, v_llm_response.cache_discounted_actual_cost_usd]
      sorts: [agent_events.cwpm_verifiable_hours_saved desc]
      limit: 15
      note_state: collapsed
      note_display: hover
      note_text: "Estimation & SLA Notes: CWPM Hours = 1.5 * tool completions * 1.2. SLA Gate = PASS if error rate <= 5%."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 28
      col: 0
      width: 24
      height: 7

    # --- ROW 6: DIVERSE STACKED AREA & SCATTER PLOT ANALYTICS ---

    - name: finops_cache_savings_over_time
      title: "75% Gemini Prompt Cache Savings vs. Actual Spend over Time ($ USD)"
      type: looker_area
      explore: agent_events
      dimensions: [agent_events.timestamp_date]
      measures: [v_llm_response.cache_savings_usd, v_llm_response.cache_discounted_actual_cost_usd]
      sorts: [agent_events.timestamp_date desc]
      stacking: normal
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Note: Evaluates 75% prompt cache discount savings based on standard Gemini 2.5 Pro pricing ($1.00/M input vs $0.25/M cached input)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 35
      col: 0
      width: 12
      height: 8

    - name: agent_roi_complexity_scatter
      title: "Agent Complexity & ROI Scatter Plot (Invocations vs. Verifiable Hours Saved)"
      type: looker_scatter
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name]
      measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.consulting_value_usd]
      sorts: [agent_events.server_verified_hours_saved desc]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Note: Plots invocation volume against verifiable hours saved (3.5 hrs baseline per session) and consulting value ($150/hr)."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 35
      col: 12
      width: 12
      height: 8

    # --- ROW 7: DIVERSE DONUT & RESILIENCE COLUMN BREAKDOWN ---

    - name: consulting_value_by_practice_area_donut
      title: "Consulting Value Created by Practice Area ($ USD Donut)"
      type: looker_pie
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.consulting_value_usd]
      sorts: [agent_events.consulting_value_usd desc]
      note_state: collapsed
      note_display: hover
      note_text: "Estimation Note: Dollarized value created per practice area assuming $150/hr consulting engineering rate."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 43
      col: 0
      width: 12
      height: 7

    - name: resilience_sla_by_practice_area_column
      title: "Tool Execution Volume & Self-Healing Resilience SLA by Practice Area"
      type: looker_column
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.total_events, agent_events.self_healing_resilience_rate_pct]
      sorts: [agent_events.total_events desc]
      note_state: collapsed
      note_display: hover
      note_text: "Reliability SLA Note: Primary self-healing resilience metric measuring ratio of SUCCESS outcomes vs total executions."
      listen:
        date_filter: agent_events.timestamp_date
        practice_area_filter: agent_events.practice_area
        sub_region_filter: agent_events.sub_region
        pilot_project_filter: agent_events.pilot_project
        agent_name_filter: agent_events.canonical_agent_name
      row: 43
      col: 12
      width: 12
      height: 7

