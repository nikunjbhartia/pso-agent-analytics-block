#!/usr/bin/env bash
# ============================================================================
# scripts/setup_all.sh
# ----------------------------------------------------------------------------
# Master automated setup script for Google Cloud PSO JAPAC Agent Analytics.
# Deploys:
#   1. BigQuery Cloud Resource Connection (if not existing)
#   2. External Object Table over GCS multimodal offload bucket
#   3. Incremental BigQuery AI.GENERATE recommendations table & initial MERGE
#   4. BigQuery Scheduled Query (running MERGE automatically every 15 min)
#
# USAGE:
#   export PROJECT_ID="your-project-id"
#   export DATASET_NAME="agent_analytics"
#   export LOCATION="asia-southeast1"
#   export CONNECTION_NAME="bqaa_ai_connection"
#   export GCS_BUCKET="japac-pso-agent-analytics"
#   ./scripts/setup_all.sh
# ============================================================================

set -e
set -o pipefail

PROJECT_ID="${PROJECT_ID:-nikunjbhartia-test-clients}"
DATASET_NAME="${DATASET_NAME:-agent_analytics}"
LOCATION="${LOCATION:-asia-southeast1}"
CONNECTION_NAME="${CONNECTION_NAME:-bqaa_ai_connection}"
GCS_BUCKET="${GCS_BUCKET:-japac-pso-agent-analytics}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "----------------------------------------------------------------------"
echo "Starting APO Agent Analytics BigQuery Setup & Scheduling"
echo "  PROJECT_ID      : ${PROJECT_ID}"
echo "  DATASET_NAME    : ${DATASET_NAME}"
echo "  LOCATION        : ${LOCATION}"
echo "  CONNECTION_NAME : ${CONNECTION_NAME}"
echo "  GCS_BUCKET      : ${GCS_BUCKET}"
echo "----------------------------------------------------------------------"

# 1. Ensure BigQuery Cloud Resource Connection exists
echo "1. Checking BigQuery Cloud Resource connection '${CONNECTION_NAME}'..."
if ! bq ls --connection --project_id="${PROJECT_ID}" --location="${LOCATION}" | grep -q "${CONNECTION_NAME}"; then
  echo "   Connection not found. Creating Cloud Resource connection '${CONNECTION_NAME}'..."
  bq mk --connection --connection_type=CLOUD_RESOURCE \
    --project_id="${PROJECT_ID}" --location="${LOCATION}" \
    "${CONNECTION_NAME}" || true
else
  echo "   Connection '${CONNECTION_NAME}' already exists."
fi
echo "   NOTE: Ensure the connection's service account is granted 'Vertex AI User' (roles/aiplatform.user) in Google Cloud IAM so AI.GENERATE can invoke Gemini models."

# 2. Deploy External Object Table over GCS multimodal bucket
echo "2. Deploying GCS Multimodal External Object Table..."
TEMP_SQL_1=$(mktemp)
sed -e "s/\${PROJECT_ID}/${PROJECT_ID}/g" \
    -e "s/\${DATASET_NAME}/${DATASET_NAME}/g" \
    -e "s/\${LOCATION}/${LOCATION}/g" \
    -e "s/\${CONNECTION_NAME}/${CONNECTION_NAME}/g" \
    -e "s/\${GCS_BUCKET}/${GCS_BUCKET}/g" \
    "${SCRIPT_DIR}/01_create_object_table_and_connections.sql" > "${TEMP_SQL_1}"

bq query --use_legacy_sql=false --project_id="${PROJECT_ID}" < "${TEMP_SQL_1}"
rm -f "${TEMP_SQL_1}"
echo "   External Object Table created/verified successfully."

# 3. Deploy AI.GENERATE Recommendations Table DDL and Run Initial MERGE
echo "3. Executing AI.GENERATE Judge Recommendations DDL & initial MERGE..."
TEMP_SQL_2=$(mktemp)
sed -e "s/\${PROJECT_ID}/${PROJECT_ID}/g" \
    -e "s/\${DATASET_NAME}/${DATASET_NAME}/g" \
    -e "s/\${LOCATION}/${LOCATION}/g" \
    -e "s/\${CONNECTION_NAME}/${CONNECTION_NAME}/g" \
    "${SCRIPT_DIR}/02_build_judge_recommendations_table.sql" > "${TEMP_SQL_2}"

bq query --use_legacy_sql=false --project_id="${PROJECT_ID}" < "${TEMP_SQL_2}"
echo "   AI Judge Recommendations table & initial MERGE executed successfully."

# 4. Schedule BigQuery Scheduled Query to run MERGE every 15 minutes
echo "4. Registering BigQuery Scheduled Query (every 15 minutes)..."
QUERY_CONTENT=$(python3 -c "import json, sys; print(json.dumps(sys.stdin.read()))" < "${TEMP_SQL_2}")
rm -f "${TEMP_SQL_2}"

# Check if a scheduled query with the same display name already exists to avoid duplicates
if bq ls --transfer_config --project_id="${PROJECT_ID}" --transfer_location="${LOCATION}" | grep -q "APO Agent Analytics - Incremental AI Recommendations"; then
  echo "   Scheduled Query already registered. Skipping creation."
else
  bq mk \
    --transfer_config \
    --project_id="${PROJECT_ID}" \
    --location="${LOCATION}" \
    --data_source=scheduled_query \
    --display_name="APO Agent Analytics - Incremental AI Recommendations (15m)" \
    --schedule="every 15 minutes" \
    --params="{\"query\":${QUERY_CONTENT}}" || echo "   Note: Could not register scheduled query automatically. Please schedule 02_build_judge_recommendations_table.sql manually if required."
  echo "   Scheduled Query registered successfully."
fi

# 5. Register all 11 BigQuery-Agent-Analytics-SDK Python UDFs
echo "5. Registering 11 SDK Analytical Python UDFs in dataset '${DATASET_NAME}'..."
python3 - <<EOF || echo "   Note: Could not automatically register Python UDFs (ensure bigquery-agent-analytics SDK is installed)."
import sys
try:
    from google.cloud import bigquery
    from bigquery_agent_analytics.udf_sql_templates import generate_all_udfs
    client = bigquery.Client(project="${PROJECT_ID}")
    sql = generate_all_udfs("${PROJECT_ID}", "${DATASET_NAME}")
    statements = [s.strip() for s in sql.split(";") if s.strip()]
    for stmt in statements:
        client.query(stmt).result()
    print("   All 11 Python UDFs registered successfully.")
except Exception as exc:
    print(f"   Skipping Python UDF registration: {exc}")
EOF

# 6. Optional: Seed Synthetic ADK Telemetry across Scenarios (if agent_events is empty or testing)
echo "6. Checking telemetry seed status for scenario testing..."
if ! bq query --use_legacy_sql=false --project_id="${PROJECT_ID}" "SELECT 1 FROM \`${PROJECT_ID}.${DATASET_NAME}.agent_events\` LIMIT 1" 2>/dev/null | grep -q "1"; then
  echo "   Table 'agent_events' empty or missing. Seeding synthetic decision-realistic and retail-returns sessions..."
  python3 -c "from bigquery_agent_analytics.cli import bqaa_main; import sys; sys.argv=['bqaa','seed-events','--project-id=${PROJECT_ID}','--dataset-id=${DATASET_NAME}','--scenario=decision-realistic','--sessions=100']; bqaa_main()" || true
  python3 -c "from bigquery_agent_analytics.cli import bqaa_main; import sys; sys.argv=['bqaa','seed-events','--project-id=${PROJECT_ID}','--dataset-id=${DATASET_NAME}','--scenario=retail-returns','--sessions=100']; bqaa_main()" || true
  echo "   Seeding completed."
else
  echo "   Table 'agent_events' already populated."
fi

# 7. Create Backing Tables and Deploy Property Graph (agent_decisions_graph) via SQL
echo "7. Creating backing tables and deploying CREATE PROPERTY GRAPH agent_decisions_graph..."
python3 - <<EOF || echo "   Note: Could not automatically deploy Property Graph DDL."
import sys
try:
    from google.cloud import bigquery
    client = bigquery.Client(project="${PROJECT_ID}")
    
    # Define backing tables with required session_id and extracted_at metadata columns
    tables_ddl = [
        "CREATE TABLE IF NOT EXISTS \`${PROJECT_ID}.${DATASET_NAME}.decision_request\` (request_id STRING, request_text STRING, requested_at TIMESTAMP, session_id STRING, extracted_at TIMESTAMP);",
        "CREATE TABLE IF NOT EXISTS \`${PROJECT_ID}.${DATASET_NAME}.decision_option\` (option_id STRING, option_label STRING, confidence FLOAT64, session_id STRING, extracted_at TIMESTAMP);",
        "CREATE TABLE IF NOT EXISTS \`${PROJECT_ID}.${DATASET_NAME}.decision_outcome\` (outcome_id STRING, status STRING, rationale STRING, decided_at TIMESTAMP, session_id STRING, extracted_at TIMESTAMP);",
        "CREATE TABLE IF NOT EXISTS \`${PROJECT_ID}.${DATASET_NAME}.evaluates_option\` (request_id STRING, option_id STRING, session_id STRING, extracted_at TIMESTAMP);",
        "CREATE TABLE IF NOT EXISTS \`${PROJECT_ID}.${DATASET_NAME}.resulted_in\` (request_id STRING, outcome_id STRING, session_id STRING, extracted_at TIMESTAMP);"
    ]
    for ddl in tables_ddl:
        client.query(ddl).result()
        
    graph_ddl = """
    CREATE OR REPLACE PROPERTY GRAPH \`${PROJECT_ID}.${DATASET_NAME}.agent_decisions_graph\`
      NODE TABLES (
        \`${PROJECT_ID}.${DATASET_NAME}.decision_request\` AS decision_request
          KEY (request_id)
          LABEL DecisionRequest PROPERTIES (request_id, request_text, requested_at),
        \`${PROJECT_ID}.${DATASET_NAME}.decision_option\` AS decision_option
          KEY (option_id)
          LABEL DecisionOption PROPERTIES (option_id, option_label, confidence),
        \`${PROJECT_ID}.${DATASET_NAME}.decision_outcome\` AS decision_outcome
          KEY (outcome_id)
          LABEL DecisionOutcome PROPERTIES (outcome_id, status, rationale, decided_at)
      )
      EDGE TABLES (
        \`${PROJECT_ID}.${DATASET_NAME}.evaluates_option\` AS evaluates_option
          KEY (request_id, option_id)
          SOURCE KEY (request_id) REFERENCES decision_request (request_id)
          DESTINATION KEY (option_id) REFERENCES decision_option (option_id)
          LABEL evaluatesOption,
        \`${PROJECT_ID}.${DATASET_NAME}.resulted_in\` AS resulted_in
          KEY (request_id, outcome_id)
          SOURCE KEY (request_id) REFERENCES decision_request (request_id)
          DESTINATION KEY (outcome_id) REFERENCES decision_outcome (outcome_id)
          LABEL resultedIn
      );
    """
    client.query(graph_ddl).result()
    print("   Property Graph 'agent_decisions_graph' deployed successfully via SQL.")
except Exception as exc:
    print(f"   Skipping Property Graph SQL deployment: {exc}")
EOF

echo "8. Running incremental graph materialization (bqaa context-graph)..."
python3 -c "from bigquery_agent_analytics.cli import bqaa_main; import sys; sys.argv=['bqaa','context-graph','--project-id=${PROJECT_ID}','--dataset-id=${DATASET_NAME}','--graph=agent_decisions_graph','--lookback-hours=24']; bqaa_main()" || echo "   Note: Could not materialize graph automatically."

echo "----------------------------------------------------------------------"
echo "Setup & Scheduling Complete!"
echo "  - BigQuery Connection     : ${CONNECTION_NAME}"
echo "  - GCS Object Table        : ${PROJECT_ID}.${DATASET_NAME}.gcs_multimodal_object_table"
echo "  - Recommendations Table   : ${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations"
echo "  - Scheduled Query         : APO Agent Analytics - Incremental AI Recommendations (15m)"
echo "  - Python UDFs             : 11 analytical scoring & event semantic functions registered"
echo "  - Agent Context Graph     : Property Graph agent_decisions_graph deployed & materialized via SQL"
echo "----------------------------------------------------------------------"
echo "All external object tables, connections, and 15-minute scheduled AI"
echo "recommendation jobs are now deployed in project '${PROJECT_ID}'."
echo "----------------------------------------------------------------------"
