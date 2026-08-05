- dashboard: agent_analytics_usage
  title: "Agent Analytics - Usage"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: yes
  description: "''"
  tabs:
  - name: "Agent & Sessions"
    label: "Agent & Sessions"
    title: "Agent & Sessions"
  - name: "LLM & Token Economics"
    label: "LLM & Token Economics"
    title: "LLM & Token Economics"
  - name: "Tool Usage & Provenance"
    label: "Tool Usage & Provenance"
    title: "Tool Usage & Provenance"
  - name: "Conversation & Lineage"
    label: "Conversation & Lineage"
    title: "Conversation & Lineage"

  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: "last 30 days"
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.timestamp_date
  - name: Trace ID
    title: Trace ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.trace_id
  - name: Agent
    title: Agent
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.agent
  - name: User ID
    title: User ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.user_id
  - name: Span ID
    title: Span ID
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bigquery_agent_analytics_model
    explore: agent_events
    field: agent_events.span_id

  elements:
  - type: button
    name: "nav_btn_portal_Agent_and_Sessions"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Agent & Sessions"
  - type: button
    name: "nav_btn_perf_Agent_and_Sessions"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Agent & Sessions"
  - type: button
    name: "nav_btn_portal_LLM_and_Token_Economics"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "LLM & Token Economics"
  - type: button
    name: "nav_btn_perf_LLM_and_Token_Economics"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "LLM & Token Economics"
  - type: button
    name: "nav_btn_portal_Tool_Usage_and_Provenance"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Tool Usage & Provenance"
  - type: button
    name: "nav_btn_perf_Tool_Usage_and_Provenance"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Tool Usage & Provenance"
  - type: button
    name: "nav_btn_portal_Conversation_and_Lineage"
    rich_content_json: '{"text":"Executive Portal","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#5F6368","href":"/dashboards/bigquery_agent_analytics_model::pso_apo_executive_portal"}'
    row: 0
    col: 0
    width: 3
    height: 1
    tab_name: "Conversation & Lineage"
  - type: button
    name: "nav_btn_perf_Conversation_and_Lineage"
    rich_content_json: '{"text":"Performance Dashboard","description":"","newTab":false,"alignment":"left","size":"medium","style":"FILLED","color":"#1A73E8","href":"/dashboards/bigquery_agent_analytics_model::agent_analytics_performance"}'
    row: 0
    col: 3
    width: 3
    height: 1
    tab_name: "Conversation & Lineage"
  - name: "Token Usage split by Agent"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Breakdown of total token consumption across agents.  <br><br>How: SUM(usage_total_tokens) grouped by agent.  <br><br>Why it matters: Identifies token-heavy agents for optimization.  <br><br>Drill: Click agent bar to inspect token split.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 6
    col: 12
    width: 12
    height: 7
  - name: "Top 5 users with most Tokens consumption"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 users by token usage.  <br><br>How: SUM(usage_total_tokens) grouped by user_id.  <br><br>Why it matters: Highlights power users and token distribution.  <br><br>Drill: Click user bar to view user session history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 12
    width: 12
    height: 4
  - name: "Total Tokens Consumption Over the Time"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily time-series area chart tracking token consumption over time.  <br><br>How: SUM(usage_total_tokens) aggregated by timestamp_date.  <br><br>Why it matters: Monitors platform adoption and API quota utilization.  <br><br>Drill: Click date point to inspect daily traffic.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "Total Tokens"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total aggregate number of tokens consumed across all sessions.  <br><br>How: SUM(usage_prompt_tokens + usage_completion_tokens).  <br><br>Why it matters: Core top-line consumption metric.  <br><br>Drill: Click tile to see token trend.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "Top 5 users with most Traces"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 power users by trace volume.  <br><br>How: COUNT DISTINCT of trace_id grouped by user_id.  <br><br>Why it matters: Shows which users execute the deepest multi-turn workflows.  <br><br>Drill: Click user to inspect trace logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 13
    col: 0
    width: 12
    height: 7
  - name: "Total Traces"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total number of execution traces recorded.  <br><br>How: COUNT DISTINCT of trace_id across all sessions.  <br><br>Why it matters: Measures overall end-to-end workflow invocations.  <br><br>Drill: Click tile to filter by agent.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Traces split by Agent"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Distribution of trace volume across agents.  <br><br>How: COUNT DISTINCT of trace_id grouped by agent.  <br><br>Why it matters: Reveals traffic distribution across agent workloads.  <br><br>Drill: Click agent to filter dashboard.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 22
    col: 0
    width: 24
    height: 7
  - name: "Total Traces Generation Over the Time"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily trend of trace volume generated over time.  <br><br>How: COUNT DISTINCT of trace_id aggregated by timestamp_date.  <br><br>Why it matters: Tracks platform engagement growth over time.  <br><br>Drill: Click date to inspect daily traces.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Total Sessions"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of end-to-end user sessions.  <br><br>How: COUNT DISTINCT of session_id.  <br><br>Why it matters: Primary measure of active customer conversations.  <br><br>Drill: Click tile to view session breakdown.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 0
    width: 8
    height: 4
  - name: "Number of Sessions Trend"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily time-series trend of user session volume over time.  <br><br>How: COUNT DISTINCT of session_id aggregated by timestamp_date.  <br><br>Why it matters: Shows daily conversational adoption.  <br><br>Drill: Click date to inspect sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 6
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Agents Split by Session Count"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Leaderboard of top 5 agents by number of sessions.  <br><br>How: COUNT DISTINCT of session_id grouped by agent.  <br><br>Why it matters: Identifies the most popular conversational agents.  <br><br>Drill: Click agent to filter sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 13
    col: 12
    width: 12
    height: 7
  - name: "Total Agent Transfers"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of multi-agent delegation and handoff events.  <br><br>How: COUNT of AGENT_TRANSFER events from v_agent_transfer.  <br><br>Why it matters: Tracks multi-agent supervisor-worker collaboration.  <br><br>Drill: Click tile to view transfer matrix.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 0
    width: 8
    height: 4
  - name: "Total A2A Interactions"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of Agent-to-Agent protocol communication events.  <br><br>How: COUNT of A2A_INTERACTION events from v_a2a_interaction.  <br><br>Why it matters: Measures decentralized agent-to-agent protocol traffic.  <br><br>Drill: Click tile to view A2A tasks.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 8
    width: 8
    height: 4
  - name: "Total HITL Confirmation Requests"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Total count of Human-In-The-Loop confirmation requests.  <br><br>How: COUNT of HITL_CONFIRMATION_REQUEST events from v_hitl_confirmation_request.  <br><br>Why it matters: Measures where human governance and sign-off occur.  <br><br>Drill: Click tile to view HITL tools.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 2
    col: 16
    width: 8
    height: 4
  - name: "Tool Invocations"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Ranking of backend tools by invocation frequency.  <br><br>How: COUNT of TOOL_COMPLETED events grouped by tool_name.  <br><br>Why it matters: Highlights which APIs and integrations are relied upon most.  <br><br>Drill: Click tool to view latency and error rate.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 2
    col: 12
    width: 12
    height: 4
  - name: "Events By Agent"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Breakdown of total lifecycle events across agents.  <br><br>How: COUNT of raw event rows grouped by agent.  <br><br>Why it matters: Shows raw telemetry volume per agent.  <br><br>Drill: Click agent to filter events.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 13
    col: 12
    width: 12
    height: 7
  - name: "Tool Calls Over Time"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily execution trend of specific tools over time.  <br><br>How: COUNT of TOOL_COMPLETED events aggregated by timestamp_date and tool_name.  <br><br>Why it matters: Reveals evolving tool usage patterns over time.  <br><br>Drill: Click date/tool to inspect executions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 6
    col: 0
    width: 12
    height: 7
  - name: "Total Calls"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Absolute count of requests sent to backend tools.  <br><br>How: COUNT of TOOL_COMPLETED events.  <br><br>Why it matters: Overall volume of external tool and API executions.  <br><br>Drill: Click tile to inspect tools.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 2
    col: 0
    width: 12
    height: 4
  - name: "LLM Call Trends"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Granular scatter plot showing frequency and clustering of LLM requests.  <br><br>How: Plots individual LLM_RESPONSE events over time.  <br><br>Why it matters: Identifies peak usage periods and request density.  <br><br>Drill: Select time range to filter LLM calls.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 13
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Agents by LLM Calls"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Ranking of agents triggering the most LLM calls.  <br><br>How: COUNT of LLM_RESPONSE events grouped by agent.  <br><br>Why it matters: Identifies agents driving backend LLM load.  <br><br>Drill: Click agent to inspect LLM calls.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 13
    col: 12
    width: 12
    height: 7
  - name: "Total Users"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Count of unique end users who interacted with agents.  <br><br>How: COUNT DISTINCT of user_id.  <br><br>Why it matters: Primary user adoption and penetration metric.  <br><br>Drill: Click tile to see user growth.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 2
    col: 16
    width: 8
    height: 4
  - name: "User Growth Over Time"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Daily count of active unique users over time.  <br><br>How: COUNT DISTINCT of user_id aggregated by timestamp_date.  <br><br>Why it matters: Measures DAU retention and adoption velocity.  <br><br>Drill: Click date to inspect active users.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 20
    col: 0
    width: 12
    height: 7
  - name: "Top 5 Users by Session"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Leaderboard of power users by session count.  <br><br>How: COUNT DISTINCT of session_id grouped by user_id.  <br><br>Why it matters: Highlights champions and power users.  <br><br>Drill: Click user to inspect sessions.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 20
    col: 12
    width: 12
    height: 7
  - name: "Top 5 Users by Events"
    model: bigquery_agent_analytics_model
    explore: agent_events
    note_text: "<div style='text-align: left;'>What: Ranking of users by raw volume of lifecycle events generated.  <br><br>How: COUNT of event rows grouped by user_id.  <br><br>Why it matters: Identifies users running the most intensive agent workflows.  <br><br>Drill: Click user to inspect event logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Agent & Sessions"
    row: 27
    col: 0
    width: 12
    height: 7
  - name: "GCS Multimodal Bucket Offloading & Object Table Content"
    type: looker_column
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [v_gcs_multimodal_offload.asset_type, gcs_multimodal_object_table.content_type]
    measures: [v_gcs_multimodal_offload.total_gcs_offloaded_assets, gcs_multimodal_object_table.total_size_bytes]
    sorts: [v_gcs_multimodal_offload.total_gcs_offloaded_assets desc]
    note_text: "<div style='text-align: left;'>What: Breakdown of multimodal payloads and large objects offloaded to GCS bucket japac-pso-agent-analytics.  <br><br>How: Aggregates offloaded GCS URIs by asset_type (IMAGE, DOCUMENT, AUDIO, VIDEO, LARGE_PAYLOAD_JSON) and event_type.  <br><br>Why it matters: Monitors multimodal storage footprint and BigQuery object table ingestion.  <br><br>Drill: Click asset type bar to inspect specific GCS URIs and traces.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 6
    col: 0
    width: 24
    height: 7
  - name: "Conversation Analytics: Multi-Turn Interaction Flow & Token Latency"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.session_id, agent_events.event_type, agent_events.agent, v_tool_completed.tool_name, agent_events.status]
    measures: [v_llm_response.total_tokens_consumed, agent_events.total_events]
    sorts: [agent_events.session_id desc, agent_events.total_events desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What: Turn-by-turn breakdown of user prompts, agent responses, tool calls, and token/latency metrics.  <br><br>How: Queries agent_events joined with v_llm_response, v_tool_completed, and v_agent_evaluation.  <br><br>Why it matters: Enables granular conversational analytics and turn debugging across sessions.  <br><br>Drill: Click Session ID to inspect full conversation history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 6
    col: 0
    width: 24
    height: 8
  - name: "Multi-Agent DAG Delegation & Decision Paths"
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    note_state: collapsed
    note_display: hover
    explore: agent_events
    dimensions: [agent_events.session_id, v_agent_transfer.from_agent, v_agent_transfer.to_agent]
    measures: [agent_events.total_events]
    sorts: [agent_events.total_events desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Visual trace DAG and conversation lineage showing how agents delegate tasks to tools and subagents. <br><br>How it is calculated: Hierarchical trace and span ID relationships captured by open-telemetry plugins. <br><br>Why it matters: Allows engineering teams to debug execution paths and verify multi-agent delegation logic. <br><br>Drill down: Click a node to trace full session history.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Conversation & Lineage"
    row: 14
    col: 0
    width: 24
    height: 8
  - name: "Real-Time UDF Evaluation Scorecard"
    model: bigquery_agent_analytics_model
    explore: udf_realtime_scorecard
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    fields: [udf_realtime_scorecard.practice_area, udf_realtime_scorecard.agent, udf_realtime_scorecard.total_sessions, udf_realtime_scorecard.total_spans, udf_realtime_scorecard.avg_latency_score, udf_realtime_scorecard.avg_ttft_score, udf_realtime_scorecard.avg_token_efficiency_score, udf_realtime_scorecard.avg_cost_score, udf_realtime_scorecard.avg_error_rate_score]
    sorts: [udf_realtime_scorecard.total_sessions desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 20
    col: 0
    width: 24
    height: 8
  - name: "Interactive SQL-Driven Trace Drilldown"
    model: bigquery_agent_analytics_model
    explore: remote_function_trace_drilldown
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    fields: [remote_function_trace_drilldown.session_id, remote_function_trace_drilldown.agent, remote_function_trace_drilldown.session_start_time, remote_function_trace_drilldown.span_count, remote_function_trace_drilldown.error_count, remote_function_trace_drilldown.sdk_version, remote_function_trace_drilldown.analyzed_session_id]
    sorts: [remote_function_trace_drilldown.session_start_time desc]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "Tool Usage & Provenance"
    row: 20
    col: 0
    width: 24
    height: 8
  - name: "Production vs Baseline Drift Scorecard"
    model: bigquery_agent_analytics_model
    explore: remote_function_drift_scorecard
    type: looker_grid
    truncate_text: no
    wrap_text: yes
    fields: [remote_function_drift_scorecard.comparison_tier, remote_function_drift_scorecard.drift_metric, remote_function_drift_scorecard.kolmogorov_smirnov_stat, remote_function_drift_scorecard.p_value, remote_function_drift_scorecard.drift_status, remote_function_drift_scorecard.last_evaluated_date]
    sorts: [remote_function_drift_scorecard.drift_metric]
    limit: 50
    note_text: "<div style='text-align: left;'>What it is: Key operational metric derived from automated agent telemetry logs. <br><br>How it is calculated: Calculated from row-level event and session records in BigQuery. <br><br>Why it matters: Provides visibility into agent performance, reliability, and executive ROI. <br><br>Drill down: Click this tile to cross-filter the dashboard or inspect underlying logs.</div>"
    listen:
      Date: agent_events.timestamp_date
      Trace ID: agent_events.trace_id
      Agent: agent_events.agent
      User ID: agent_events.user_id
      Span ID: agent_events.span_id
    tab_name: "LLM & Token Economics"
    row: 28
    col: 0
    width: 24
    height: 7
