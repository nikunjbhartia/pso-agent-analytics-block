# Google Cloud PSO JAPAC — APO Agent Analytics Canonical Metric Catalog (`METRICS.md`)

This document is the authoritative catalog of all **74 distinct analytical metrics and scorecards** captured across the three canonical LookML dashboards in `pso-agent-analytics-block`. Every visual data tile is accompanied by a standardized **Executive 4-Part Hover Note** (`What | How | Why it matters | Drill`) and is calculated directly from BigQuery ADK telemetry (`agent_events` base table + 24 unnested flat views + External Object Tables).

---

## 1. `pso_apo_executive_portal` (23 Executive & Value Engineering Metrics)
*   **Target Audience**: Google Cloud PSO JAPAC Leadership, APO Practice Leads, Value Engineers & Data Architects.
*   **Primary Objective**: Server-Verified Value Engineering, ROI attribution, consulting billable leverage, and predictive forecasting.

| Chart / Scorecard Name | What It Measures | BigQuery Source Field(s) | Derivation Logic & Formula |
| :--- | :--- | :--- | :--- |
| **CWPM Verifiable Hours Saved** | Estimated productivity hours saved by automated tool calls | `v_tool_completed.tool_name`, `total_ms` | `COUNT(tool_calls) * 1.5h base * 1.2 complexity multiplier` |
| **FTE Weeks Saved Equivalent** | Full-Time Equivalent engineering weeks saved | `server_verified_hours_saved` | `Estimated Manual Hours Saved / 40.0 hours per work week` |
| **Consulting Value Created ($ USD)** | Dollarized consulting value created by automated engineering | `agent_events.session_id` | `total_sessions * 3.5h (pilot benchmark) * $350/hr ($2,800/day PSO Consultant rate) = $1,225/session` |
| **Self-Healing Resilience Rate (%)** | System stability and CI/CD SLA deployment readiness | `agent_events.status` | `COUNTIF(status = SUCCESS) / COUNT(1) * 100.0` |
| **Pilot Projects** | Count of distinct customer pilot engagements | `agent_events.pilot_project` | `COUNT DISTINCT pilot_project` (`DBS Bank`, `Dyson`, `Myntra`, etc.) |
| **Agents Used** | Count of distinct AI agents deployed | `agent_events.canonical_agent_name` | `COUNT DISTINCT canonical_agent_name` |
| **Hours Saved by Pilot Project & Practice Area** | Breakdown of hours saved across projects and practices | `agent_events.pilot_project`, `practice_area` | `total_sessions * 3.5h` stacked by project and practice |
| **Hours Saved by Practice Area** | Automation savings aggregated by practice area | `agent_events.practice_area` | `total_sessions * 3.5h` across **AI**, **Data Analytics**, **CP&I**, **Security**, **Emerging** |
| **Top Agents by Hours Saved and Events** | Comprehensive leaderboard of agent ROI and volume | `canonical_agent_name`, `session_id` | `Hours = sessions * 3.5h`, `FTE Weeks = Hours / 40`, `Consulting $ = Hours * $350/hr` |
| **JAPAC Sub-Region Adoption Velocity over Time** | Daily time-series of automation adoption across sub-regions | `sub_region`, `timestamp_date` | `total_sessions * 3.5h` across **ANZ**, **SEA**, **India**, **Japan**, **Korea**, **Greater China** |
| **Model Tier Spend Breakdown ($ USD)** | Actual LLM API dollar spend by Gemini model version | `model_version`, `usage_tokens` | Applies Google Cloud Gemini 2.5 Pro **75% prompt cache discount** (`$1.25/M` input, `$0.3125/M` cached input, `$5.00/M` output) |
| **Feedback & Wins — Verifiable Engineer Testimonials** | Qualitative developer feedback and verified savings quotes | `win_feedback`, `session_id` | Extracts metadata quotes and displays associated hours saved (`sessions * 3.5h`) |
| **75% Cache-Discount Actual Spend ($ USD)** | Total actual LLM API dollar spend in USD | `v_llm_response.cache_discounted_cost` | SUM of discounted token spend across all Gemini model calls |
| **Prompt Cache Hit Ratio (%)** | Percentage of prompt tokens served from prompt cache | `usage_cached_tokens`, `usage_prompt_tokens` | `SUM(usage_cached_tokens) / SUM(usage_prompt_tokens) * 100.0` |
| **Tool Productivity Credit Hours (CWPM)** | Estimated manual engineering hours saved by tool workflows | `v_tool_completed.total_ms` | `SUM(1.5 base hours * [1.0x standard, 1.5x >2s, 2.5x >5s])` |
| **CI/CD SLA Gate Assertion** | CI/CD gatekeeper asserting deployment readiness | `agent_events.status` | Evaluates error rate: `PASS` if error rate `<= 5.0%`, otherwise `FAIL` |
| **DAG Lineage & SLA Gate Leaderboard** | Combined ROI and CI/CD SLA Gate status table | `canonical_agent_name`, `status` | Unifies `CWPM Hours` with `SLA Gate PASS/FAIL` status |
| **75% Gemini Prompt Cache Savings vs. Actual Spend** | Stacked area comparison of dollar savings vs. spend | `cache_savings_usd`, `total_spend_usd` | `Savings = cached_tokens * $0.9375/M ($1.25 - $0.3125)` over time |
| **Agent Complexity & ROI Scatter Plot** | Multi-dimensional scatter plot of agent volume vs. ROI | `invocations`, `hours_saved`, `consulting_usd` | `X = invocations`, `Y = hours saved`, `Bubble Size = consulting value ($350/hr)` |
| **Consulting Value by Practice Area ($ USD Donut)** | Distribution of consulting value across practice areas | `practice_area`, `consulting_value_usd` | Donut chart of `Hours saved * $350/hr` by practice area |
| **Tool Volume & Resilience SLA by Practice Area** | Overlay of event volume and reliability SLA | `total_events`, `self_healing_resilience_rate` | Column = `total_events`, Line = `resilience rate (SUCCESS / Total)` |
| **BigQuery AI: 30-Day Predictive ROI & Value Forecast** | 30-day AI prediction of hours saved and consulting value | `v_bqml_roi_forecast.forecast_date` | Historical actuals + 30-day linear regression projection with **90%/110% confidence bounds** |
| **Multi-Agent Session DAG & Trace Lineage Graph** | Hierarchical execution flow across sessions and trace hops | `v_session_trace_dag.from_agent`, `to_target` | Visualizes `from_agent -> to_target` delegation hops from `AGENT_TRANSFER`, `A2A_INTERACTION`, and `TOOL_COMPLETED` |

---

## 2. `agent_analytics_usage` (25 Usage & Token Economics Metrics)
*   **Target Audience**: Enterprise Customer Executives, FinOps Managers, System Architects & Product Managers.
*   **Primary Objective**: Token economics, session volume, multi-agent delegation counts, user adoption, and multimodal GCS storage offloading.

| Chart / Scorecard Name | What It Measures | BigQuery Source Field(s) | Derivation Logic & Formula |
| :--- | :--- | :--- | :--- |
| **Token Usage split by Agent** | Breakdown of total token consumption across agents | `v_llm_response.usage_total_tokens` | `SUM(usage_total_tokens)` grouped by `agent` |
| **Top 5 users with most Tokens consumption** | Leaderboard of top 5 end-users by token usage | `v_llm_response.usage_total_tokens` | `SUM(usage_total_tokens)` grouped by `user_id` |
| **Total Tokens Consumption Over the Time** | Daily time-series tracking token consumption | `v_llm_response.usage_total_tokens` | `SUM(usage_total_tokens)` aggregated by `timestamp_date` |
| **Total Tokens** | Aggregate count of prompt and completion tokens | `usage_prompt_tokens`, `usage_completion_tokens` | `SUM(usage_prompt_tokens + usage_completion_tokens)` |
| **Top 5 users with most Traces** | Leaderboard of top 5 power users by trace volume | `agent_events.trace_id` | `COUNT DISTINCT trace_id` grouped by `user_id` |
| **Total Traces** | Total number of execution traces recorded | `agent_events.trace_id` | `COUNT DISTINCT trace_id` across all sessions |
| **Traces split by Agent** | Distribution of trace volume across agents | `agent_events.trace_id` | `COUNT DISTINCT trace_id` grouped by `agent` |
| **Total Traces Generation Over the Time** | Daily trend of trace volume generated over time | `agent_events.trace_id` | `COUNT DISTINCT trace_id` aggregated by `timestamp_date` |
| **Total Sessions** | Total count of end-to-end user sessions | `agent_events.session_id` | `COUNT DISTINCT session_id` |
| **Number of Sessions Trend** | Daily time-series trend of user session volume | `agent_events.session_id` | `COUNT DISTINCT session_id` aggregated by `timestamp_date` |
| **Top 5 Agents Split by Session Count** | Leaderboard of top 5 agents by number of sessions | `agent_events.session_id` | `COUNT DISTINCT session_id` grouped by `agent` |
| **Total Agent Transfers** | Total count of multi-agent delegation handoffs | `v_agent_transfer.event_type` | `COUNT(1)` from `v_agent_transfer` (`event_type = 'AGENT_TRANSFER'`) |
| **Total A2A Interactions** | Total count of Agent-to-Agent protocol interactions | `v_a2a_interaction.event_type` | `COUNT(1)` from `v_a2a_interaction` (`event_type = 'A2A_INTERACTION'`) |
| **Total HITL Confirmation Requests** | Count of Human-In-The-Loop confirmation requests | `v_hitl_confirmation_request.tool_name` | `COUNT(1)` from `v_hitl_confirmation_request` (`event_type = 'HITL_CONFIRMATION_REQUEST'`) |
| **Tool Invocations** | Ranking of backend tools by invocation frequency | `v_tool_completed.tool_name` | `COUNT(1)` from `v_tool_completed` grouped by `tool_name` |
| **Events By Agent** | Breakdown of total lifecycle events across agents | `agent_events.event_type` | `COUNT(1)` grouped by `agent` |
| **Tool Calls Over Time** | Daily execution trend of specific tools over time | `v_tool_completed.tool_name` | `COUNT(1)` aggregated by `timestamp_date` and `tool_name` |
| **Total Calls** | Absolute count of requests sent to backend tools | `v_tool_completed.tool_name` | `COUNT(1)` of `TOOL_COMPLETED` events |
| **LLM Call Trends** | Granular scatter plot showing LLM request frequency | `v_llm_response.timestamp` | Plots individual `LLM_RESPONSE` events over time |
| **Top 5 Agents by LLM Calls** | Ranking of agents triggering the most LLM calls | `v_llm_response.agent` | `COUNT(1)` of `LLM_RESPONSE` grouped by `agent` |
| **Total Users** | Count of unique end users interacting with agents | `agent_events.user_id` | `COUNT DISTINCT user_id` |
| **User Growth Over Time** | Daily count of active unique users over time | `agent_events.user_id` | `COUNT DISTINCT user_id` aggregated by `timestamp_date` |
| **Top 5 Users by Session** | Leaderboard of power users by session count | `agent_events.session_id` | `COUNT DISTINCT session_id` grouped by `user_id` |
| **Top 5 Users by Events** | Ranking of users by raw volume of lifecycle events | `agent_events.event_type` | `COUNT(1)` grouped by `user_id` |
| **GCS Multimodal Bucket Offloading & Object Table** | Breakdown of GCS offloaded objects and object table size | `v_gcs_multimodal_offload.asset_type`, `gcs_multimodal_object_table.size` | Aggregates offloaded GCS URIs by `asset_type` (`IMAGE`, `DOCUMENT`, `AUDIO`, `VIDEO`, `LARGE_PAYLOAD_JSON`) and Object Table bytes |

---

## 3. `agent_analytics_performance` (26 Performance, SLA & Reliability Metrics)
*   **Target Audience**: Customer SREs, DevOps Engineers, Agent Evaluators & Reliability Teams.
*   **Primary Objective**: P50/P75/P90/P99 latencies, LLM-as-a-Judge quality evaluation, user feedback satisfaction, autonomous self-correction loops, and enterprise edge-case detection.

| Chart / Scorecard Name | What It Measures | BigQuery Source Field(s) | Derivation Logic & Formula |
| :--- | :--- | :--- | :--- |
| **Average Tool Latency (ms)** | Average execution time in ms for backend tools | `v_tool_completed.total_ms` | `AVG(total_ms)` across `TOOL_COMPLETED` events |
| **Tool Latency Trend** | Historical trend of tool execution latency over time | `v_tool_completed.total_ms` | `AVG(total_ms)` aggregated by `timestamp_date` |
| **Average LLM Latency (in ms)** | Average round-trip time in ms for LLM requests | `v_llm_response.total_ms` | `AVG(total_ms)` across `LLM_RESPONSE` events |
| **LLM Latency Trend** | Historical trend of LLM response times over time | `v_llm_response.total_ms` | `AVG(total_ms)` aggregated by `timestamp_date` |
| **P50 Tool Latency** | Median (50th percentile) tool execution latency | `v_tool_completed.total_ms` | `50th percentile` of `total_ms` across `TOOL_COMPLETED` |
| **P75 Tool Latency** | 75th percentile tool execution latency | `v_tool_completed.total_ms` | `75th percentile` of `total_ms` across `TOOL_COMPLETED` |
| **P90 Tool Latency** | 90th percentile tool execution latency | `v_tool_completed.total_ms` | `90th percentile` of `total_ms` across `TOOL_COMPLETED` |
| **P99 Tool Latency** | 99th percentile (tail latency) tool execution latency | `v_tool_completed.total_ms` | `99th percentile` of `total_ms` across `TOOL_COMPLETED` |
| **P50 Llm Latency** | Median (50th percentile) LLM response latency | `v_llm_response.total_ms` | `50th percentile` of `total_ms` across `LLM_RESPONSE` |
| **P75 Llm Latency** | 75th percentile LLM response latency | `v_llm_response.total_ms` | `75th percentile` of `total_ms` across `LLM_RESPONSE` |
| **P90 Llm Latency** | 90th percentile LLM response latency | `v_llm_response.total_ms` | `90th percentile` of `total_ms` across `LLM_RESPONSE` |
| **P99 Llm Latency** | 99th percentile (tail latency) LLM response latency | `v_llm_response.total_ms` | `99th percentile` of `total_ms` across `LLM_RESPONSE` |
| **Total Tool Errors** | Total count of backend tool execution errors | `v_tool_error.event_type` | `COUNT(1)` of `TOOL_ERROR` events |
| **Tool Errors Trend** | Daily time-series tracking volume of tool failures | `v_tool_error.event_type` | `COUNT(1)` of `TOOL_ERROR` events aggregated by `timestamp_date` |
| **Tool Error by Agent** | Ranking of agents by number of tool errors encountered | `v_tool_error.agent` | `COUNT(1)` of `TOOL_ERROR` events grouped by `agent` |
| **Top 5 Tool Errors** | Leaderboard of the most unstable backend tools | `v_tool_error.tool_name` | `COUNT(1)` of `TOOL_ERROR` events grouped by `tool_name` |
| **Total Agent Errors** | Total count of agent-level execution errors | `v_agent_error.event_type` | `COUNT(1)` of `AGENT_ERROR` events (`error_traceback`, `total_ms`) |
| **Self-Healing Resilience Rate (%)** | Reliability SLA metric measuring system stability | `agent_events.status` | `COUNTIF(status = SUCCESS) / COUNT(1) * 100.0` |
| **LLM-as-a-Judge Avg Quality Score (%)** | Qualitative LLM-as-a-Judge evaluation score (0-100%) | `v_agent_evaluation.judge_score` | Evaluates response accuracy, relevance, and tool faithfulness |
| **User Feedback Satisfaction Rate (%)** | Percentage of positive user feedback ratings | `v_agent_evaluation.user_rating` | `COUNTIF(user_feedback_rating = 'THUMBS_UP') / COUNT(1) * 100.0` |
| **Self-Correction Loop Success Rate (%)** | Autonomous recovery rate after encountering errors | `v_agent_evaluation.is_recovered` | Percentage of `SUCCESS` sessions that recovered after an `ERROR` event |
| **A2A Circular Delegation Ping-Pong Loops** | Highlights recursive multi-agent loops | `v_session_trace_dag.from_agent`, `to_target` | Detects recursive A2A ping-pong loops (`from_agent = to_target`) |
| **HITL Confirmation Request Volume & Latency** | Tracks Human-In-The-Loop approval volume and latency | `v_hitl_confirmation_request.tool_name` | Aggregates `HITL_CONFIRMATION_REQUEST` events by tool and date |
| **Tool Error Breakdown by Failing Function** | Breakdown of failing backend tools and error counts | `v_tool_error.tool_name` | Aggregates `TOOL_ERROR` occurrences by `tool_name` |
| **LLM-as-a-Judge: Actionable Model Improvement Recommendations** | Actionable engineering recommendations to improve model/prompt accuracy | `v_agent_evaluation.judge_improvement_recommendation` | Extracted from judge recommendation metadata or diagnosed via error traceback and quality score |
| **AI Recommendation Provenance: Gemini vs. SDK vs. Diagnostics** | Breakdown of where model improvement recommendations originated | `v_agent_evaluation.recommendation_source` | Aggregates `recommendation_source` (`gemini-2.5-flash`, `gemini-2.5-pro`, `sdk_evaluator`, `static_case_fallback`) |
