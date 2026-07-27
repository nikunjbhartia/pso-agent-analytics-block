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
      title: "Total Hours Saved"
      type: single_value
      explore: agent_events
      measures: [agent_events.server_verified_hours_saved]
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
      col: 4
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
      col: 8
      width: 4
      height: 3

    - name: total_sub_regions_card
      title: "Sub-Regions"
      type: single_value
      explore: agent_events
      measures: [agent_events.total_sub_regions]
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

    - name: fte_weeks_saved_card
      title: "FTE Weeks Saved"
      type: single_value
      explore: agent_events
      measures: [agent_events.fte_weeks_saved]
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

    - name: consulting_value_usd_card
      title: "Consulting Value Created ($ USD)"
      type: single_value
      explore: agent_events
      measures: [agent_events.consulting_value_usd]
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
