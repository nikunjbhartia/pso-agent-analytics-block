# BigQuery Agent Analytics — Enterprise Troubleshooting & SDK Doc Gaps Post-Mortem

**Version:** 1.0.0  
**Target Architecture:** Google Cloud PSO JAPAC Enterprise Agent Analytics Workspace  
**GCP Project ID:** `nikunjbhartia-test-clients`  
**BigQuery Dataset:** `agent_analytics`  
**Property Graph:** `agent_context_graph`  

---

## Executive Summary

During the end-to-end enterprise deployment of the **BigQuery Agent Analytics SDK (`bqaa context-graph`)**, the **6-Pillar Context Graph V3 Property Graph (`agent_context_graph`)**, synthetic data generators, and Looker LookML BI blocks, we encountered and systematically resolved several critical schema, binding validation, and AI extraction errors.

This document serves two purposes:
1. **Step-by-Step Technical Post-Mortem**: Details what command was executed, what error occurred, the technical root cause, and the exact SQL/Python fix implemented.
2. **Upstream SDK Documentation Gaps**: Highlights specific omissions in the official `BigQuery-Agent-Analytics-SDK` docs to prevent data engineers and SQL analysts from falling into the same implementation traps.

---

## 1. Post-Mortem: 3 Pre-Flight Binding Validation Errors (`bqaa context-graph`)

When running the SDK's periodic time-window CLI materializer (`bqaa context-graph`), the SDK executes a strict pre-flight validation step (`binding-validate`) before invoking Gemini (`AI.GENERATE`) or modifying BigQuery tables. We encountered 3 sequential validation failures and resolved each as follows.

---

### Error 1: Repeated-Record (`ARRAY<STRUCT>`) Property Type Error on `Caused` Edge Table

#### 1. What We Executed
We deployed the initial `CREATE OR REPLACE PROPERTY GRAPH agent_context_graph` statement in BigQuery and ran:
```bash
bqaa context-graph \
  --project-id="nikunjbhartia-test-clients" \
  --dataset-id="agent_analytics" \
  --graph="agent_context_graph" \
  --lookback-hours=4 \
  --format=json
```

#### 2. What Failed (Error Message)
```json
{
  "failures": [
    {
      "session_id": null,
      "error_code": "binding_validate_failed",
      "error_detail": "binding-validate failed before extraction: 1 failures. type_mismatch:binding.relationships[0].properties[...].column; Error: Table 'Caused' (`nikunjbhartia-test-clients.agent_analytics.agent_events`), column 'content_parts': Column type 'ARRAY<STRUCT<mime_type STRING, uri STRING, object_ref STRUCT<...>, text STRING, part_index INT64, ...>>' has no logical PropertyType analogue. Supported scalar types: BIGDECIMAL, BIGNUMERIC, BOOL, BOOLEAN, BYTES, DATE, DATETIME, DECIMAL, FLOAT, FLOAT64, INT64, INTEGER, JSON, NUMERIC, STRING, TIME, TIMESTAMP."
    }
  ],
  "ok": false
}
```

#### 3. Technical Root Cause
*   In our initial Property Graph DDL, the `Caused` edge table was defined as `your-project.agent_analytics.agent_events AS Caused` **without an explicit `PROPERTIES (...)` list**.
*   When `PROPERTIES (...)` is omitted on a node or edge table, BigQuery Property Graphs automatically attempt to expose **all physical columns** of the underlying table as graph properties.
*   The raw `agent_events` table contains `content_parts`, which is an `ARRAY<STRUCT<...>>` (repeated record). Neither BigQuery GQL nor the SDK's ontology v0 binding parser supports repeated record structures as scalar graph properties.

#### 4. Step-by-Step Fix Executed
We updated `CREATE OR REPLACE PROPERTY GRAPH agent_context_graph` to explicitly define a **scalar primitive property list** on the `Caused` edge table, excluding `content_parts`:
```sql
    `nikunjbhartia-test-clients.agent_analytics.agent_events` AS Caused
      KEY (span_id)
      SOURCE KEY (parent_span_id) REFERENCES TechNode (span_id)
      DESTINATION KEY (span_id) REFERENCES TechNode (span_id)
      LABEL Caused
      -- EXPLICIT SCALAR PROPERTIES (excludes content_parts ARRAY<STRUCT>)
      PROPERTIES (event_type, agent, timestamp, session_id, invocation_id, status, error_message),
```
Re-running the DDL deployment immediately resolved the repeated-record error.

---

### Error 2: Missing Checkpoint Ledger Metadata Columns (`extracted_at` & `session_id`)

#### 1. What We Executed
After fixing the `Caused` property list, we re-executed:
```bash
bqaa context-graph --project-id="$PROJECT_ID" --dataset-id="$DATASET_NAME" --graph="agent_context_graph" --lookback-hours=4
```

#### 2. What Failed (Error Message)
```json
{
  "failures": [
    {
      "session_id": null,
      "error_code": "binding_validate_failed",
      "error_detail": "binding-validate failed before extraction: 12 failures. missing_column:binding.entities[0].<metadata>.extracted_at; missing_column:binding.entities[1].<metadata>.extracted_at; missing_column:binding.entities[2].<metadata>.extracted_at; missing_column:binding.entities[3].<metadata>.extracted_at; missing_column:binding.relationships[0].<metadata>.extracted_at; missing_column:binding.relationships[1].<metadata>.extracted_at; missing_column:binding.relationships[2].<metadata>.session_id; missing_column:binding.relationships[2].<metadata>.extracted_at"
    }
  ],
  "ok": false
}
```

#### 3. Technical Root Cause
*   The `bqaa context-graph` CLI command operates as an incremental time-window materializer. It uses an internal audit ledger to record which sessions and spans have been materialized.
*   When `derive_ontology_binding_from_ddl` inspects the deployed `agent_context_graph`, it requires **every backing table** in the graph schema (`extracted_biz_nodes`, `decision_points`, `candidates`, `context_cross_links`, `made_decision_edges`, `candidate_edges`) to physically contain two mandatory audit columns:
    *   `session_id STRING`
    *   `extracted_at TIMESTAMP`
*   If any table was created manually or by an older schema script without those two columns, pre-flight validation aborts immediately.

#### 4. Step-by-Step Fix Executed
We executed the following DDL across all 7 canonical Context Graph V3 tables in BigQuery:
```sql
ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.agent_events` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.extracted_biz_nodes` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.decision_points` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.candidates` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.context_cross_links` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.made_decision_edges` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;

ALTER TABLE `nikunjbhartia-test-clients.agent_analytics.candidate_edges` 
  ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP;
```

---

### Error 3: JSON vs. STRING Type Mismatch on `TechNode` (`content` and `latency_ms`)

#### 1. What We Executed
With metadata columns added, we ran the CLI materializer again.

#### 2. What Failed (Error Message)
```text
FailureCode.TYPE_MISMATCH : path=binding.entities[0].properties[4].column bq_ref=nikunjbhartia-test-clients.agent_analytics.agent_events.content expected=STRING observed=JSON
   detail: binding maps property 'content' (sdk_type='string') to column 'content', but BQ reports type 'JSON'
FailureCode.TYPE_MISMATCH : path=binding.entities[0].properties[5].column bq_ref=nikunjbhartia-test-clients.agent_analytics.agent_events.latency_ms expected=STRING observed=JSON
   detail: binding maps property 'latency_ms' (sdk_type='string') to column 'latency_ms', but BQ reports type 'JSON'
```

#### 3. Technical Root Cause
*   In `CREATE PROPERTY GRAPH agent_context_graph`, we initially included `content` and `latency_ms` in `TechNode`'s property list:
    ```sql
    PROPERTIES (event_type, agent, timestamp, session_id, invocation_id, content, latency_ms, status, error_message)
    ```
*   In the underlying BigQuery `agent_events` table, `content` and `latency_ms` are stored as native BigQuery `JSON` data types.
*   When `derive_ontology_binding_from_ddl` parses a node table, default scalar string properties in the SDK ontology expect physical columns of type `STRING` or `INT64/FLOAT64`. Mapping a `JSON` column directly to a `STRING` ontology property raises a strict type mismatch in `validate_binding_against_bigquery`.

#### 4. Step-by-Step Fix Executed
We modified the `TechNode` property list in `agent_context_graph` to exclude the heavy `JSON`-typed columns from the graph index layer (while leaving them fully accessible on `agent_events` for analytical SQL queries):
```sql
    `nikunjbhartia-test-clients.agent_analytics.agent_events` AS TechNode
      KEY (span_id)
      LABEL TechNode
      -- Excludes JSON-typed columns (content, latency_ms) to satisfy Googlesql scalar primitives
      PROPERTIES (event_type, agent, timestamp, session_id, invocation_id, status, error_message),
```

#### 5. Verification Command & Result
We ran the SDK's verification method directly against BigQuery:
```python
from bigquery_agent_analytics.property_graph_spec import fetch_property_graph_ddl, derive_ontology_binding_from_ddl
from bigquery_agent_analytics.binding_validation import validate_binding_against_bigquery

ddl = fetch_property_graph_ddl(bq_client=client, project_id="nikunjbhartia-test-clients", dataset_id="agent_analytics", graph_name="agent_context_graph")
ontology, binding = derive_ontology_binding_from_ddl(ddl, project_id="nikunjbhartia-test-clients", dataset_id="agent_analytics", bq_client=client)

res = validate_binding_against_bigquery(ontology=ontology, binding=binding, bq_client=client)
print("Validation OK:", res.ok)
```
**Output:**
```text
Validation OK: True
```

---

## 2. Post-Mortem: Why `bqaa seed-events` Did Not Populate `decision_points` & How We Fixed It (`empty_extraction`)

### 1. What We Executed
We seeded 500 sessions of synthetic data and ran the graph materializer:
```bash
bqaa seed-events --scenario=decision-realistic --sessions=500 --project-id="$PROJECT_ID" --dataset-id="$DATASET_NAME"
bqaa context-graph --project-id="$PROJECT_ID" --dataset-id="$DATASET_NAME" --graph="agent_context_graph" --lookback-hours=24
```

### 2. What Failed (Error Message)
*   `extracted_biz_nodes` populated 11 rows, but **`decision_points` and `candidates` remained at 0 rows**.
*   The CLI output reported:
    ```json
    {
      "failures": [
        {
          "session_id": "sess-d507301f",
          "error_code": "empty_extraction",
          "error_detail": "session materialized zero rows across every entity table... the session's events did not contain any extractable ontology content."
        }
      ]
    }
    ```

### 3. Technical Root Cause
*   **Synthetic Snippet Limitations**: `bqaa seed-events --scenario=decision-realistic` generates lightweight synthetic JSON snippets (e.g., `{"result": {"confidence": 0.41, "option_id": "opt-663f1"}}`). It is designed for **smoke testing pipeline plumbing** (table permissions, schemas, scheduled queries), not for exercising LLM semantic reasoning.
*   **How `AI.GENERATE` Evaluates Decision Points**: In `_EXTRACT_DECISION_POINTS_AI_QUERY`, Gemini (`gemini-2.5-flash`) is prompted with:
    >*"A decision point is present only when the payload shows the agent evaluated multiple candidates/options and selected or rejected them... preserve candidate names and rejection rationale text."*
    Because synthetic snippets lack natural-language reasoning text explaining *why* candidates were weighed or rejected, Gemini returns zero decision points.
*   **Orphaned Session Abort**: `decision-realistic` intentionally seeds 10% of sessions as "orphaned" (no terminal event). When `bqaa context-graph` iterates chronologically and encounters an orphaned session, it logs `empty_extraction` and aborts the loop.

### 4. Step-by-Step Fix Executed
To generate **real ADK agent reasoning traces** with rich candidate evaluation:
1.  We configured `examples/decision_lineage_demo/.env` to target `nikunjbhartia-test-clients.agent_analytics`.
2.  We executed the ADCP Multi-Agent Media Buying campaign generator:
    ```bash
    PYTHONPATH=src:. python examples/decision_lineage_demo/run_agent.py
    ```
    This ran real ADK agents (`root_agent` + `media_planner`) against 6 campaign briefs (`Nike Summer Run 2026`, `ELF Cosmetics`, etc.). Each brief prompted the agent to make 5 domain decisions (audience, budget, creative, channel, schedule) and log full natural-language reasoning text into `agent_events`.
3.  We executed SDK server-side `AI.GENERATE` extraction across those 6 campaign sessions:
    ```python
    mgr.extract_biz_nodes(session_ids=sessions, use_ai_generate=True)
    dps, cands = mgr.extract_decision_points(session_ids=sessions, use_ai_generate=True)
    mgr.store_decision_points(dps, cands)
    mgr.create_decision_edges(session_ids=sessions)
    ```

### 5. Verification & Final Scale
With real natural-language option evaluations in `agent_events`, **100% of campaign decisions were extracted**. The live scale in `nikunjbhartia-test-clients.agent_analytics` is now:
*   **`extracted_biz_nodes`**: **515 rows**
*   **`decision_points`**: **30 rows** (exactly 5 decisions across 6 campaigns)
*   **`candidates`**: **90 rows** (3 candidate options per decision point with float confidence scores, `SELECTED`/`DROPPED` status, and rejection rationales)
*   **`made_decision_edges`**: **30 rows**
*   **`candidate_edges`**: **90 rows**

---

## 3. Gaps in Official Upstream SDK Documentation (`BigQuery-Agent-Analytics-SDK`)

During our implementation, we identified **4 critical documentation gaps** in the upstream repository that should be addressed by the SDK engineering team.

### Gap 1: Missing SQL DDL for Context Graph V3 Backing Tables (`context_graph_v3_design.md`)
*   **What is missing**: `docs/context_graph_v3_design.md` specifies the conceptual 6-Pillar Property Graph schema (`TechNode`, `BizNode`, `DecisionPoint`, `CandidateNode`, `Evaluated`, `MadeDecision`, `CandidateEdge`) but **never provides the required BigQuery SQL DDL (`CREATE TABLE IF NOT EXISTS`)** for the 6 backing tables.
*   **Why it is a trap**: Without canonical table schemas in the docs, users try to create tables manually or assume the CLI creates them from scratch.
*   **Recommendation**: Add an explicit `"Appendix: Canonical Backing Table DDL"` section to `context_graph_v3_design.md` containing full `CREATE TABLE IF NOT EXISTS` statements for all 6 tables, explicitly including `session_id STRING` and `extracted_at TIMESTAMP`.

### Gap 2: Undocumented Need for Scalar `PROPERTIES (...)` Lists on Graph Node/Edge Tables
*   **What is missing**: The documentation for deploying `CREATE PROPERTY GRAPH` does not warn users that:
    1.  Omitting `PROPERTIES (...)` on an edge table referencing `agent_events` (such as `Caused`) exposes `content_parts: ARRAY<STRUCT>`, which immediately crashes `bqaa context-graph`.
    2.  Including BigQuery `JSON`-typed columns (`content`, `latency_ms`) on node tables causes a `TYPE_MISMATCH` failure in SDK binding validation.
*   **Why it is a trap**: Users naturally write `agent_events AS Caused KEY (span_id) ... LABEL Caused` without a property list, causing confusing pre-flight crashes.
*   **Recommendation**: Add a prominent `> [!IMPORTANT]` alert in the Property Graph deployment guide explaining the requirement for explicit scalar primitive property lists.

### Gap 3: Misleading Comparison Between `bqaa seed-events` and Decision Lineage
*   **What is missing**: The SDK docs suggest that running `bqaa seed-events --scenario=decision-realistic` followed by `bqaa context-graph` will populate a full domain decision graph.
*   **Why it is a trap**: `seed-events` emits lightweight synthetic JSON that `AI.GENERATE` evaluates to zero decisions. Users who test `seed-events` believe their `AI.GENERATE` or IAM configuration is broken when `decision_points` remains empty.
*   **Recommendation**: Clearly document in READMEs that `bqaa seed-events` is for **pipeline smoke testing**, while `examples/decision_lineage_demo/run_agent.py` must be executed to generate **natural-language candidate evaluations** suitable for `AI.GENERATE` decision extraction.

### Gap 4: Undocumented Transition from Option A (Client-Side JSON) to SQL-Style `AI.GENERATE` Schemas
*   **What is missing**: While PR #99 updated `ContextGraphManager` to drop JSON-Schema strings (`output_schema => JSON_SCHEMA`) in favor of Googlesql-style column schemas (`output_schema => 'decisions ARRAY<STRUCT<...>>'`), several legacy examples and markdown guides still suggest using client-side extraction (`ContextGraphManager.build_context_graph(use_ai_generate=False)`).
*   **Why it is a trap**: Client-side extraction relies on brittle Markdown fence parsing and fails on modern Gemini responses.
*   **Recommendation**: Deprecate and remove Option A references across all documentation, elevating server-side `AI.GENERATE` as the sole supported enterprise extraction path.

---

## 4. Quick-Reference Verification Checklist for Teams

Before running `bqaa context-graph` in production, ensure your dataset meets this checklist:
1.  [x] **All 7 Backing Tables Exist**: `agent_events`, `extracted_biz_nodes`, `decision_points`, `candidates`, `context_cross_links`, `made_decision_edges`, `candidate_edges`.
2.  [x] **Mandatory Audit Columns Present**: Run `ALTER TABLE ... ADD COLUMN IF NOT EXISTS session_id STRING, ADD COLUMN IF NOT EXISTS extracted_at TIMESTAMP` on all 7 tables.
3.  [x] **Scalar Primitive Property Lists**: Ensure `TechNode` and `Caused` in your `CREATE OR REPLACE PROPERTY GRAPH` DDL explicitly exclude `content_parts: ARRAY<STRUCT>` and `JSON`-typed columns (`content`, `latency_ms`).
4.  [x] **Pre-Flight Validation Passes**: Verify via Python SDK:
    ```python
    validate_binding_against_bigquery(ontology=ontology, binding=binding, bq_client=client)
    # Must return: Validation OK: True
    ```
