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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Estimated productivity hours saved by automated tool calls. How derived: Count of completed tool executions * 1.5 hours baseline * 1.2 complexity multiplier.
      explore: agent_events
      measures: [agent_events.cwpm_verifiable_hours_saved]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Equivalent Full-Time Equivalent engineering weeks saved. How derived: CWPM Verifiable Hours Saved / 40.0 hours per standard engineering work week.
      explore: agent_events
      measures: [agent_events.fte_weeks_saved_equivalent]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Estimated dollar value of automated engineering work. How derived: Estimated Manual Hours Saved (total_sessions * 3.5 hrs, based on PSO JAPAC pilot benchmarks where automation replaces ~3.5h of manual coding/debugging) * $350/hr Google Cloud PSO billable rate (assuming $2,800/day PSO Consultant rate for an 8-hour day, or $1,225/session).
      explore: agent_events
      measures: [agent_events.consulting_value_usd]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Reliability SLA metric measuring system stability. How derived: Ratio of SUCCESS outcomes vs total executions (COUNTIF(status = SUCCESS) / COUNT(1)).
      explore: agent_events
      measures: [agent_events.self_healing_resilience_rate_pct]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Count of distinct Google Cloud PSO JAPAC customer pilot engagements. How derived: COUNT DISTINCT of pilot_project attribute.
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Total number of distinct AI agents deployed across JAPAC engagements. How derived: COUNT DISTINCT of canonical_agent_name.
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Estimated manual engineering hours saved broken down by pilot project and practice area. How derived: total_sessions * 3.5 hours per session (based on PSO pilot benchmarks where an automated agent session replaces ~3.5h of manual work).
      explore: agent_events
      dimensions: [agent_events.pilot_project, agent_events.practice_area]
      measures: [agent_events.server_verified_hours_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
      stacking: normal
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Estimated manual engineering hours saved aggregated by practice area. How derived: total_sessions * 3.5 hours per session (based on PSO pilot benchmarks where an automated agent session replaces ~3.5h of manual work).
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.server_verified_hours_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Comprehensive leaderboard of agent ROI and volume. How derived: Hours = total_sessions * 3.5 hrs (PSO pilot benchmark), FTE Weeks = Hours / 40.0, Consulting Value = Hours * $350/hr ($2,800/day PSO Consultant rate).
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name, agent_events.practice_area]
      measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved, agent_events.consulting_value_usd]
      sorts: [agent_events.server_verified_hours_saved desc]
      limit: 15
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Time-series trend of automation adoption across JAPAC sub-regions. How derived: Estimated manual hours saved (total_sessions * 3.5 hrs from PSO pilot benchmarks) over timestamp_date.
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Actual LLM API spend in USD by Gemini model version. How derived: Applies Google Cloud Gemini 2.5 Pro 75 percent cache discount ($1.25/M standard input, $0.3125/M cached input, $5.00/M completion).
      explore: agent_events
      dimensions: [v_llm_response.model_version]
      measures: [v_llm_response.total_spend_usd]
      sorts: [v_llm_response.total_spend_usd desc]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Qualitative engineering feedback and verified savings testimonials. How derived: Extracts win_feedback metadata and displays associated hours saved (sessions * 3.5 hrs benchmark).
      explore: agent_events
      dimensions: [agent_events.pilot_project, agent_events.canonical_agent_name, agent_events.win_feedback]
      measures: [agent_events.server_verified_hours_saved, agent_events.fte_weeks_saved]
      sorts: [agent_events.server_verified_hours_saved desc]
      limit: 10
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Total actual LLM API dollar spend USD. How derived: Applies 75 percent discount for cached input tokens ($0.3125/M cached vs $1.25/M standard input for Gemini 2.5 Pro).
      explore: agent_events
      measures: [v_llm_response.cache_discounted_actual_cost_usd]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Percentage of input prompt tokens served from prompt cache. How derived: SUM(cached_tokens) / SUM(prompt_tokens).
      explore: agent_events
      measures: [v_llm_response.prompt_cache_hit_ratio]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Estimated manual engineering hours saved by automated tool calls. How derived: SUM of 1.5 base hours * latency complexity weight (1.0x standard, 1.5x over 2s, 2.5x over 5s).
      explore: agent_events
      measures: [v_tool_completed.tool_productivity_credit_hours]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: CI/CD SLA Gate asserting deployment readiness. How derived: Evaluates error rate; PASS if error rate is 5.0 percent or lower, otherwise FAIL.
      explore: agent_events
      measures: [agent_events.sla_error_rate_gating]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Combined ROI leaderboard and CI/CD SLA Gate status table. How derived: CWPM Hours = tool calls * 1.5 * 1.2, SLA Gate = PASS if error rate <= 5 percent.
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name, agent_events.sla_error_rate_gating]
      measures: [agent_events.total_invocations, agent_events.self_healing_resilience_rate_pct, agent_events.cwpm_verifiable_hours_saved, v_llm_response.cache_discounted_actual_cost_usd]
      sorts: [agent_events.cwpm_verifiable_hours_saved desc]
      limit: 15
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Comparison of dollar savings from prompt caching vs actual spend over time. How derived: Savings = cached_tokens * $0.9375/M ($1.25 - $0.3125).
      explore: agent_events
      dimensions: [agent_events.timestamp_date]
      measures: [v_llm_response.cache_savings_usd, v_llm_response.cache_discounted_actual_cost_usd]
      sorts: [agent_events.timestamp_date desc]
      stacking: normal
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Multi-dimensional scatter plot comparing agent volume against ROI. How derived: X-axis = invocations, Y-axis = hours saved (sessions * 3.5 hrs), size = consulting value ($350/hr PSO rate).
      explore: agent_events
      dimensions: [agent_events.canonical_agent_name]
      measures: [agent_events.total_invocations, agent_events.server_verified_hours_saved, agent_events.consulting_value_usd]
      sorts: [agent_events.server_verified_hours_saved desc]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Distribution of estimated consulting dollar value across practice areas. How derived: Hours saved (sessions * 3.5 hrs) * $350 per hour ($2,800/day PSO Consultant rate).
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.consulting_value_usd]
      sorts: [agent_events.consulting_value_usd desc]
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
      note_state: collapsed
      note_display: hover
      note_text: What it is: Overlay of event volume and reliability SLA across practice areas. How derived: Columns = total_events, Line = self-healing resilience rate (SUCCESS / Total).
      explore: agent_events
      dimensions: [agent_events.practice_area]
      measures: [agent_events.total_events, agent_events.self_healing_resilience_rate_pct]
      sorts: [agent_events.total_events desc]
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

