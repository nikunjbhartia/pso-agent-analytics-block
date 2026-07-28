# 📊 Google Cloud PSO JAPAC — APO Agent Analytics Looker Block (`pso-agent-analytics-block`)

This Looker Block is the canonical analytics and BI engine for **Google Cloud PSO JAPAC — APO (Agent Program Office)**. It integrates with Google ADK (`BigQueryAgentAnalyticsPlugin`) telemetry stored in Google Cloud BigQuery (`agent_events` + 24 unnested views) to deliver server-verified productivity attribution, full-stack observability, and executive reporting.

---

## 🏆 Why This Looker Block Was Built: Solving the "Before" Problems

Before APO Analytics, engineering and consulting teams faced four systemic challenges:
1. **Spreadsheets & Google Forms**: No system of record, no audit trail.
2. **No Per-Agent Attribution**: No verifiable signal showing which agents create value.
3. **No Common Identity Model**: The same agent was counted differently across projects.
4. **No Real-Time Signal**: Expansion and staffing decisions were made on stale, manual data.

### Three Measurable Outcomes That Drove Our Design:
*   ✅ **1. Verifiable**: Hours-saved attributed to a specific agent, project, and engineer. Server-verified from BigQuery telemetry—not self-reported spreadsheets.
*   ✅ **2. Self-Service**: APO leads and engineering managers run their own reports across **5 Practice Areas** and **6 JAPAC Sub-Regions** without engineering tickets.
*   ✅ **3. Real-Time**: Week-over-week adoption and expansion signal updated live.

---

## 🖥️ Three Canonical Looker Dashboards Included

### 1️⃣ `pso_apo_executive_portal` (The APO Portal Dashboard)
*   **Target Audience**: Google Cloud PSO JAPAC Leadership, APO Leads & Practice Managers.
*   **Headline Scorecards**:
    *   **Total Server-Verified Hours Saved** (`server_verified_hours_saved`) — Estimated 3.5h/session manual baseline (derived from Google Cloud PSO JAPAC pilot benchmarks where automated agent workflows replace ~3.5h of manual code generation and debugging).
    *   **Pilot Projects** (`total_pilot_projects`) — Count of active customer engagements (`DBS Bank`, `Dyson`, `Myntra`, etc.).
    *   **Agents Used** (`total_invocations`) — Count of distinct canonical agents deployed.
    *   **Sub-Regions** (`total_sub_regions`) — Regional penetration across JAPAC.
    *   **FTE Weeks Saved** (`fte_weeks_saved`) — Equivalent 40h/week engineering savings.
    *   **Consulting Value Created ($ USD)** (`consulting_value_usd`) — Dollarized at $350/hr Google Cloud PSO billable rate (based on $2,800/day PSO Consultant rate for an 8-hour work day, or $1,225/session).
*   **Interactive Visualizations**:
    *   `Server-Verified Hours Saved by Pilot Project & Practice Area` (Stacked Column Chart).
    *   `Hours Saved by Practice Area` (Bar Chart: **Data & Analytics**, **AI**, **CP&I**, **Emerging**, **Security**).
    *   `Top Agents by Hours Saved and Events` (Leaderboard Table: `CML to GCP Migration Agent`, `Transformation Agent`, `Hanshi TDD Agent`, etc.).
    *   `JAPAC Sub-Region Adoption Velocity over Time` (Line Chart: **SEA**, **India**, **ANZ**, **Japan**, **Korea**, **Greater China**).
    *   `Model Tier Spend Breakdown ($ USD)` (Donut Chart: `gemini-2.5-pro` vs. `gemini-2.5-flash`).
    *   `Feedback & Wins — Verifiable Engineer Testimonials` (Table of developer feedback and FTE week savings quotes).

---

### 2️⃣ `agent_analytics_performance` (Technical Reliability & SLAs)
*   **Target Audience**: Agent Developers, SREs & DevOps Leads.
*   **Key Visualizations**:
    *   Tool Latency Trend & LLM Latency Trend (ms).
    *   P50, P75, P90, and P99 Tool & LLM Latency distributions.
    *   Top 5 Agents by Errors & Top 5 Tools by Errors.
    *   Error Trend over time.

---

### 3️⃣ `agent_analytics_usage` (Tokens, Traces & Conversational Volume)
*   **Target Audience**: FinOps Managers, Product Managers & System Architects.
*   **Key Visualizations**:
    *   Total Tokens, Total Calls, Total Traces, Total Sessions.
    *   Tool Calls Over Time & LLM Call Trends.
    *   Top 5 Users by Token Consumption.
    *   Token Usage & Events split by Agent.

---

## 🛠️ Complete 81-Metric LookML Model Architecture

```
                                 ┌────────────────────────────────────────────────────────┐
                                 │     pso-agent-analytics-block (LookML Architecture)    │
                                 └───────────────────────────┬────────────────────────────┘
                                                             │
                    ┌────────────────────────────────────────┼────────────────────────────────────────┐
                    ▼                                        ▼                                        ▼
      ┌───────────────────────────┐            ┌───────────────────────────┐            ┌───────────────────────────┐
      │   Explore: agent_events   │            │   Refined View:           │            │   Refined View:           │
      │   (agent_events.explore)  │            │   agent_events.view.lkml  │            │   v_llm_response.view.lkml│
      └─────────────┬─────────────┘            └─────────────┬─────────────┘            └─────────────┬─────────────┘
                    │                                        │                                        │
                    ▼                                        ▼                                        ▼
        Joins: session_facts,                    APO Org Dimensions: practice_area,       Executive FinOps Spend:
        v_llm_response,                          sub_region, pilot_project,               total_spend_usd,
        v_tool_completed,                        canonical_agent_name, win_feedback       cost_per_session_usd,
        v_tool_error                             APO Value Measures: hours_saved,         cache_hit_ratio_pct,
                                                 fte_weeks_saved, consulting_usd          cache_savings_usd
```

---

## 📦 Installation & Looker Configuration

1. **Clone this repository into your Looker project**:
   ```bash
   git clone https://github.com/nikunjbhartia/pso-agent-analytics-block.git
   ```
2. **Configure Connection & Dataset Name**:
   *   In your Looker project settings or `manifest.lkml`, define your BigQuery connection name and dataset containing `agent_events`:
   ```lookml
   constant: CONNECTION_NAME {
     value: "your_bigquery_connection_name"
   }
   constant: PROJECT_ID {
     value: "your_google_cloud_project_id"
   }
   constant: DATASET_NAME {
     value: "agent_analytics"
   }
   constant: TABLE_NAME {
     value: "agent_events"
   }
   ```
3. **Deploy Dashboards**:
   *   Commit changes to your Looker Git repository and deploy to Production. All three dashboards will appear under LookML Dashboards!
