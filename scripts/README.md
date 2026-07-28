# APO Agent Analytics — Automated BigQuery Setup & AI Recommendation Scripts

This directory contains automated, parameterized scripts to deploy and maintain the BigQuery resources required by the Looker Block:

1.  **`01_create_object_table_and_connections.sql`**: Creates the BigQuery External Object Table (`gcs_multimodal_object_table`) over your GCS offload bucket (`gs://${GCS_BUCKET}/*`).
2.  **`02_build_judge_recommendations_table.sql`**: Deploys the persistent `agent_judge_recommendations` table and executes the incremental `MERGE` query using BigQuery AI (`AI.GENERATE`) over new agent telemetry.
3.  **`setup_all.sh`**: Automated master deployment script that validates connections, replaces environment variables, and executes the SQL scripts.

---

## Usage Instructions

### 1. Execute Setup via `setup_all.sh`
You can override default project and location parameters by exporting environment variables before calling `setup_all.sh`:

```bash
export PROJECT_ID="your-project-id"
export DATASET_NAME="agent_analytics"
export LOCATION="asia-southeast1"
export CONNECTION_NAME="bqaa_ai_connection"
export GCS_BUCKET="japac-pso-agent-analytics"

./scripts/setup_all.sh
```

### 2. Schedule Incremental AI Recommendations (Every 15 Minutes)
To keep AI recommendations updated in real time as new `agent_events` arrive, set up a **BigQuery Scheduled Query**:
1.  Open the BigQuery Console in your project (`asia-southeast1`).
2.  Paste the contents of `02_build_judge_recommendations_table.sql` after replacing `${PROJECT_ID}`, `${DATASET_NAME}`, and `${LOCATION}.${CONNECTION_NAME}`.
3.  Schedule to run every **15 minutes**.
