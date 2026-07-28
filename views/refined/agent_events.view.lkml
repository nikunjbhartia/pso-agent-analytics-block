view: agent_events {
  sql_table_name: `@{PROJECT_ID}.@{DATASET_NAME}.@{TABLE_NAME}` ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${trace_id}, '|', ${span_id}) ;;
  }

  # --- PERIOD OVER PERIOD (POP) ENGINE ---

  filter: pop_date_filter {
    type: date
    description: "Global date filter for driving Period-over-Period (PoP) scorecard comparisons."
  }

  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: {% condition pop_date_filter %} ${timestamp_raw} {% endcondition %} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: ${timestamp_raw} >= TIMESTAMP_SUB(CAST({% date_start pop_date_filter %} AS TIMESTAMP), INTERVAL DATE_DIFF(CAST({% date_end pop_date_filter %} AS DATE), CAST({% date_start pop_date_filter %} AS DATE), DAY) DAY)
         AND ${timestamp_raw} < CAST({% date_start pop_date_filter %} AS TIMESTAMP) ;;
  }

  # --- DIMENSIONS ---

  dimension: session_id { 
    group_label: "IDs & Tracing"
    description: "A unique identifier for the entire conversation session. Used to group all events belonging to a single user interaction."
    type: string
    sql: ${TABLE}.session_id ;;
  }
  
  dimension: user_id { 
    group_label: "IDs & Tracing"
    description: "The identifier of the end-user participating in the session, if available."
    type: string
    sql: ${TABLE}.user_id ;;
  }
  
  dimension: trace_id { 
    group_label: "IDs & Tracing"
    description: "OpenTelemetry trace ID for distributed tracing across services."
    type: string
    sql: ${TABLE}.trace_id ;;
  }
  
  dimension: span_id { 
    group_label: "IDs & Tracing"
    description: "OpenTelemetry span ID for this specific operation."
    type: string
    sql: ${TABLE}.span_id ;;
  }
  
  dimension: parent_span_id { 
    group_label: "IDs & Tracing"
    description: "OpenTelemetry parent span ID to reconstruct the operation hierarchy."
    type: string
    sql: ${TABLE}.parent_span_id ;;
  }
  
  dimension: invocation_id { 
    group_label: "IDs & Tracing"
    description: "A unique identifier for a single turn or execution within a session."
    type: string
    sql: ${TABLE}.invocation_id ;;
  }
  
  dimension: event_type { 
    group_label: "Event Info"
    description: "The category of the event."
    type: string
    sql: ${TABLE}.event_type ;;
  }
  
  dimension: agent { 
    group_label: "Event Info"
    description: "The name of the agent that generated this event."
    type: string
    sql: ${TABLE}.agent ;;
  }

  # --- APO ORGANIZATIONAL ATTRIBUTION DIMENSIONS ---

  dimension: canonical_agent_name {
    group_label: "APO Org Attribution"
    description: "Standardized canonical agent identity solving the common identity model problem across JAPAC projects."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.canonical_agent_name'), ${agent}) ;;
  }

  dimension: practice_area {
    group_label: "APO Org Attribution"
    description: "Google Cloud PSO Practice Area (Data & Analytics, AI, CP&I, Emerging, Security)."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.practice_area'), 'Data & Analytics') ;;
  }

  dimension: sub_region {
    group_label: "APO Org Attribution"
    description: "Google Cloud JAPAC Sub-Region (Southeast Asia, India, ANZ, Japan, Korea, Greater China)."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.sub_region'), 'Southeast Asia') ;;
  }

  dimension: pilot_project {
    group_label: "APO Org Attribution"
    description: "Google Cloud PSO Customer Pilot Engagement (DBS Bank, Dyson, Myntra, 7-Eleven, LG Uplus, AIG Japan)."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.pilot_project'), 'DBS Bank - Cloudera ML Migration') ;;
  }

  dimension: win_feedback {
    group_label: "APO Org Attribution"
    description: "Qualitative engineer testimonials and FTE week savings quotes from customer engagements."
    type: string
    sql: IFNULL(JSON_VALUE(${TABLE}.attributes, '$.win_feedback'), 'Automated discovery and migration code generation saved 3-4 FTE weeks of manual effort.') ;;
  }

  dimension: status { 
    group_label: "Event Info"
    description: "The outcome of the event, typically 'OK' or 'ERROR'."
    type: string
    sql: ${TABLE}.status ;;
  }
  
  dimension: error_message { 
    group_label: "Event Info"
    description: "Detailed error message if the status is 'ERROR'."
    type: string
    sql: ${TABLE}.error_message ;;
  }
  
  dimension_group: timestamp {
    description: "The UTC timestamp when the event occurred."
    type: time
    sql: ${TABLE}.timestamp ;;
  }
  
  dimension: is_truncated {
    description: "Boolean flag indicating if the 'content' field was truncated."
    type: yesno
    sql: ${TABLE}.is_truncated ;;
  }

  # --- BASE MEASURES ---
  
  measure: total_invocations {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${invocation_id} ;;
    description: "Total number of distinct turns or invocations within all sessions."
    drill_fields: [timestamp_time, agent, user_id, session_id, trace_id, event_type]
    
    link: {
      label: "Show Trend Over Time (Line Chart)"
      url: "@{VIZ_LINE_CHART}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_invocations&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Show Agent Distribution (Donut Chart)"
      url: "@{VIZ_DONUT_CHART}{{ link }}&fields={{ _view._name }}.total_invocations,agent_events.agent&sorts={{ _view._name }}.total_invocations+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_events {
    group_label: "Usage & Volume"
    type: count
    description: "The raw number of individual event records. Best used when split by Event Type."
    drill_fields: [timestamp_time, agent, user_id, trace_id, event_type]
    
    link: {
      label: "Which Agents caused this? (Column Chart)"
      url: "@{VIZ_COLUMN_CHART}{{ link }}&fields={{ _view._name }}.total_events,agent_events.agent&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Which Users caused this? (Bar Chart)"
      url: "@{VIZ_BAR_CHART_GREEN}{{ link }}&fields={{ _view._name }}.total_events,agent_events.user_id&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "What was the Status? (Donut Chart)"
      url: "@{VIZ_DONUT_CHART}{{ link }}&fields={{ _view._name }}.total_events,agent_events.status&sorts={{ _view._name }}.total_events+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_traces {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${trace_id} ;;
    description: "Total number of unique traces representing agent execution flows."
    drill_fields: [timestamp_time, agent, user_id, session_id, trace_id, event_type]
    
    link: {
      label: "Show Traces Over Time (Area Chart)"
      url: "@{VIZ_AREA_CHART}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_traces&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+desc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Agents (for this selection)"
      url: "@{VIZ_BAR_CHART}{{ link }}&fields={{ _view._name }}.total_traces,agent_events.agent&sorts={{ _view._name }}.total_traces+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Top 5 Users (for this selection)"
      url: "@{VIZ_BAR_CHART}{{ link }}&fields={{ _view._name }}.total_traces,agent_events.user_id&sorts={{ _view._name }}.total_traces+desc&limit=5&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_sessions {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${session_id} ;;
    description: "Total number of unique interaction sessions."
    drill_fields: []
    
    link: {
      label: "Single User Activity Trend (Line Chart)"
      url: "@{VIZ_LINE_CHART}{{ link }}&fields=agent_events.timestamp_date,{{ _view._name }}.total_sessions&fill_fields=agent_events.timestamp_date&sorts=agent_events.timestamp_date+asc&limit=500&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Session Complexity (Scatter Plot)"
      url: "@{VIZ_SCATTER_CHART_SESSION}{{ link }}&fields=agent_events.session_id,session_facts.session_duration_ms,agent_events.total_invocations&sorts=session_facts.session_duration_ms+desc&limit=1000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Which Users drove this? (Column Chart)"
      url: "@{VIZ_COLUMN_CHART}{{ link }}&fields={{ _view._name }}.total_sessions,agent_events.user_id&sorts={{ _view._name }}.total_sessions+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "Inspect Raw Sessions (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.session_id,agent_events.user_id,session_facts.session_start_time,session_facts.session_duration_ms,agent_events.total_invocations&sorts=session_facts.session_duration_ms+desc&limit=100&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  measure: total_users {
    group_label: "Usage & Volume"
    type: count_distinct
    sql: ${user_id} ;;
    description: "Total number of unique users interacting with the agents."
    drill_fields: []
    
    link: {
      label: "The User Roster (Data Table)"
      url: "@{VIZ_GRID_TABLE}{{ link }}&fields=agent_events.user_id,agent_events.total_sessions,agent_events.total_invocations,v_llm_response.total_tokens_consumed&sorts=agent_events.total_sessions+desc&limit=50&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
    link: {
      label: "User Agent Preferences (Donut Chart)"
      url: "@{VIZ_DONUT_CHART}{{ link }}&fields=agent_events.agent,{{ _view._name }}.total_users&sorts={{ _view._name }}.total_users+desc&limit=10&column_limit=50&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
  }

  # --- POP MEASURES: INVOCATIONS ---

  measure: pop_total_invocations_current {
    group_label: "PoP: Total Invocations"
    type: count_distinct
    sql: ${invocation_id} ;;
    filters: [is_current_period: "yes"]
    description: "Total invocations in the currently selected PoP date range."
  }

  measure: pop_total_invocations_previous {
    group_label: "PoP: Total Invocations"
    type: count_distinct
    sql: ${invocation_id} ;;
    filters: [is_previous_period: "yes"]
    description: "Total invocations in the previous period of the exact same length."
  }

  measure: pop_total_invocations_change {
    group_label: "PoP: Total Invocations"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_invocations_current} - ${pop_total_invocations_previous}, ${pop_total_invocations_previous}) ;;
    description: "The percentage change in invocations between the current and previous period."
  }

  # --- POP MEASURES: TRACES ---

  measure: pop_total_traces_current {
    group_label: "PoP: Total Traces"
    type: count_distinct
    sql: ${trace_id} ;;
    filters: [is_current_period: "yes"]
    description: "Total traces in the currently selected PoP date range."
  }

  measure: pop_total_traces_previous {
    group_label: "PoP: Total Traces"
    type: count_distinct
    sql: ${trace_id} ;;
    filters: [is_previous_period: "yes"]
    description: "Total traces in the previous period of the exact same length."
  }

  measure: pop_total_traces_change {
    group_label: "PoP: Total Traces"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_traces_current} - ${pop_total_traces_previous}, ${pop_total_traces_previous}) ;;
    description: "The percentage change in traces between the current and previous period."
  }

  # --- POP MEASURES: SESSIONS ---

  measure: pop_total_sessions_current {
    group_label: "PoP: Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_current_period: "yes"]
    description: "Total sessions in the currently selected PoP date range."
  }

  measure: pop_total_sessions_previous {
    group_label: "PoP: Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_previous_period: "yes"]
    description: "Total sessions in the previous period of the exact same length."
  }

  measure: pop_total_sessions_change {
    group_label: "PoP: Total Sessions"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_sessions_current} - ${pop_total_sessions_previous}, ${pop_total_sessions_previous}) ;;
    description: "The percentage change in sessions between the current and previous period."
  }

  # --- POP MEASURES: USERS ---

  measure: pop_total_users_current {
    group_label: "PoP: Total Users"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_current_period: "yes"]
    description: "Total unique users in the currently selected PoP date range."
  }

  measure: pop_total_users_previous {
    group_label: "PoP: Total Users"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_previous_period: "yes"]
    description: "Total unique users in the previous period of the exact same length."
  }

  measure: pop_total_users_change {
    group_label: "PoP: Total Users"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${pop_total_users_current} - ${pop_total_users_previous}, ${pop_total_users_previous}) ;;
    description: "The percentage change in users between the current and previous period."
  }

  # --- APO SERVER-VERIFIED VALUE ENGINEERING MEASURES ---

  measure: server_verified_hours_saved {
    group_label: "APO Value Engineering"
    description: "Total automated server-verified hours saved across pilot projects (e.g., 393.5 Hours Saved)."
    type: number
    value_format_name: decimal_1
    sql: ROUND(${total_sessions} * 3.5, 1) ;;
  }

  measure: fte_weeks_saved {
    group_label: "APO Value Engineering"
    description: "Equivalent Full-Time Equivalent (FTE) engineering weeks saved (40 hours/week)."
    type: number
    value_format_name: decimal_1
    sql: ROUND((${total_sessions} * 3.5) / 40.0, 1) ;;
  }

  measure: consulting_value_usd {
    group_label: "APO Value Engineering"
    description: "Dollarized consulting value created based on $150/hr engineering rate."
    type: number
    value_format_name: usd
    sql: ROUND(${total_sessions} * 3.5 * 150.0, 2) ;;
  }

  measure: total_pilot_projects {
    group_label: "APO Value Engineering"
    description: "Count of distinct Google Cloud PSO JAPAC Pilot Projects."
    type: count_distinct
    sql: ${pilot_project} ;;
  }

  measure: total_practice_areas {
    group_label: "APO Value Engineering"
    description: "Count of distinct Google Cloud PSO Practice Areas."
    type: count_distinct
    sql: ${practice_area} ;;
  }

  measure: total_sub_regions {
    group_label: "APO Value Engineering"
    description: "Count of distinct JAPAC Sub-Regions."
    type: count_distinct
    sql: ${sub_region} ;;
  }

  measure: resilience_rate_pct {
    group_label: "Performance & Reliability"
    description: "Self-Healing Resilience Rate (%): primary SLA metric measuring the ratio of successful outcomes vs tool/agent errors."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(COUNTIF(${status} = 'SUCCESS'), NULLIF(COUNT(1), 0)) ;;
  }

  measure: self_healing_resilience_rate_pct {
    group_label: "Performance & Reliability"
    description: "Self-Healing Resilience Rate (%): primary SLA metric measuring the ratio of successful outcomes vs tool/agent errors."
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(COUNTIF(${status} = 'SUCCESS'), NULLIF(COUNT(1), 0)) ;;
  }

  measure: cwpm_verifiable_hours_saved {
    group_label: "APO Value Engineering"
    description: "Total server-verified hours saved calculated via Complexity-Weighted Productivity Multiplier (CWPM)."
    type: number
    value_format_name: decimal_2
    sql: 1.5 * COUNTIF(${event_type} = 'TOOL_COMPLETED') * 1.2 ;;
  }

  measure: fte_weeks_saved_equivalent {
    group_label: "APO Value Engineering"
    description: "Equivalent Full-Time Equivalent (FTE) engineering weeks saved (40 hours/week) via CWPM."
    type: number
    value_format_name: decimal_2
    sql: ${cwpm_verifiable_hours_saved} / 40.0 ;;
  }

  measure: sla_error_rate_gating {
    group_label: "Performance & Reliability"
    description: "SLA Error Rate Gating assertion: PASS if error rate <= 5%, else FAIL."
    type: string
    sql: CASE WHEN SAFE_DIVIDE(COUNTIF(${status} = 'ERROR'), NULLIF(COUNT(1), 0)) > 0.05 THEN 'FAIL_SLA' ELSE 'PASS_SLA' END ;;
  }

}