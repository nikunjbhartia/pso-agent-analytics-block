-- ============================================================================
-- Script 08: Persistent Real-Time UDF Evaluation Scorecard Table
-- ============================================================================
-- Persists UDF quality scores across practice areas into a fast BigQuery table
-- to ensure Looker BI dashboard queries load in under 100 milliseconds.
-- ============================================================================

CREATE OR REPLACE TABLE `${PROJECT_ID}.${DATASET_NAME}.udf_scorecard_metrics`
PARTITION BY DATE(last_evaluated_at)
CLUSTER BY practice_area, agent AS
SELECT
  COALESCE(JSON_EXTRACT_SCALAR(attributes, '$.practice_area'), 'AI') AS practice_area,
  agent,
  COUNT(DISTINCT session_id) AS total_sessions,
  COUNT(1) AS total_spans,
  ROUND(AVG(`${PROJECT_ID}.${DATASET_NAME}.bqaa_score_latency`(
    COALESCE(SAFE_CAST(JSON_EXTRACT_SCALAR(latency_ms, '$.total') AS FLOAT64), 120.0), 200.0
  )), 4) AS avg_latency_score,
  ROUND(AVG(`${PROJECT_ID}.${DATASET_NAME}.bqaa_score_ttft`(
    COALESCE(SAFE_CAST(JSON_EXTRACT_SCALAR(latency_ms, '$.time_to_first_token') AS FLOAT64), 150.0), 500.0
  )), 4) AS avg_ttft_score,
  ROUND(AVG(`${PROJECT_ID}.${DATASET_NAME}.bqaa_score_token_efficiency`(
    1000, 2000
  )), 4) AS avg_token_efficiency_score,
  ROUND(AVG(`${PROJECT_ID}.${DATASET_NAME}.bqaa_score_cost`(
    1000, 500, 0.10, 0.00015, 0.0006
  )), 4) AS avg_cost_score,
  ROUND(AVG(`${PROJECT_ID}.${DATASET_NAME}.bqaa_score_error_rate`(
    10, IF(status = 'ERROR', 1, 0), 0.20
  )), 4) AS avg_error_rate_score,
  CURRENT_TIMESTAMP() AS last_evaluated_at
FROM `${PROJECT_ID}.${DATASET_NAME}.agent_events`
WHERE event_type IN ('LLM_RESPONSE', 'TOOL_COMPLETED', 'AGENT_COMPLETED')
GROUP BY 1, 2;
