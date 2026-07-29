-- ============================================================================
-- 01_create_object_table_and_connections.sql
-- ----------------------------------------------------------------------------
-- Creates the BigQuery External Object Table over your configured GCS bucket
-- where large payloads (>1MB) and multimodal assets are offloaded.
--
-- PARAMETERS (replaced automatically by scripts/setup_all.sh):
--   ${PROJECT_ID}      : Target Google Cloud project
--   ${DATASET_NAME}    : BigQuery dataset (e.g. agent_analytics)
--   ${LOCATION}        : BigQuery region (e.g. asia-southeast1)
--   ${CONNECTION_NAME} : BigQuery Cloud Resource Connection name
--   ${GCS_BUCKET}      : Google Cloud Storage offload bucket name
-- ============================================================================

-- Create External Object Table pointing to GCS multimodal offload bucket
CREATE EXTERNAL TABLE IF NOT EXISTS `${PROJECT_ID}.${DATASET_NAME}.gcs_multimodal_object_table`
WITH CONNECTION `${LOCATION}.${CONNECTION_NAME}`
OPTIONS (
  object_metadata = 'SIMPLE',
  uris = ['gs://${GCS_BUCKET}/*']
);
