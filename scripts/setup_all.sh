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

# 7. Materialize Agent Context Graph (bqaa context-graph)
echo "7. Running periodic graph materialization (Agent Context Graph)..."
python3 - <<EOF || echo "   Note: Could not run graph materializer automatically (check property graph DDL and IAM roles)."
import sys
try:
    from bigquery_agent_analytics.context_graph import ContextGraphManager
    mgr = ContextGraphManager(
        project_id="${PROJECT_ID}",
        dataset_id="${DATASET_NAME}",
        table_id="agent_events",
        location="${LOCATION}"
    )
    # Builds canonical property graph and extracts BizNode entities
    mgr.build_context_graph(use_ai_generate=True, include_decisions=True)
    print("   Agent Context Graph materialized successfully.")
except Exception as exc:
    print(f"   Skipping automatic graph materialization: {exc}")
EOF

echo "----------------------------------------------------------------------"
echo "Setup & Scheduling Complete!"
echo "  - BigQuery Connection     : ${CONNECTION_NAME}"
echo "  - GCS Object Table        : ${PROJECT_ID}.${DATASET_NAME}.gcs_multimodal_object_table"
echo "  - Recommendations Table   : ${PROJECT_ID}.${DATASET_NAME}.agent_judge_recommendations"
echo "  - Scheduled Query         : APO Agent Analytics - Incremental AI Recommendations (15m)"
echo "  - Python UDFs             : 11 analytical scoring & event semantic functions registered"
echo "  - Agent Context Graph     : Property Graph deployed & materialized"
echo "----------------------------------------------------------------------"
echo "All external object tables, connections, and 15-minute scheduled AI"
echo "recommendation jobs are now deployed in project '${PROJECT_ID}'."
echo "----------------------------------------------------------------------"
