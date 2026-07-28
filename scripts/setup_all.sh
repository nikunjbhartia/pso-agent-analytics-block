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

echo "----------------------------------------------------------------------"
echo "Setup & Scheduling Complete!"
echo "All external object tables, connections, and 15-minute scheduled AI"
echo "recommendation jobs are now deployed in project '${PROJECT_ID}'."
echo "----------------------------------------------------------------------"
