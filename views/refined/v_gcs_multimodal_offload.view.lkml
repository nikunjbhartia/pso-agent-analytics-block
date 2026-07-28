view: v_gcs_multimodal_offload {
  derived_table: {
    sql:
      SELECT
        timestamp,
        event_type,
        agent,
        session_id,
        invocation_id,
        user_id,
        trace_id,
        span_id,
        CASE
          WHEN TO_JSON_STRING(content) LIKE "%gs://%" THEN REGEXP_EXTRACT(TO_JSON_STRING(content), r'gs://[^"\\s]+')
          ELSE REGEXP_EXTRACT(TO_JSON_STRING(attributes), r'gs://[^"\\s]+')
        END AS gcs_uri,
        CASE
          WHEN TO_JSON_STRING(content) LIKE "%.png%" OR TO_JSON_STRING(content) LIKE "%.jpg%" OR TO_JSON_STRING(content) LIKE "%.webp%" THEN "IMAGE"
          WHEN TO_JSON_STRING(content) LIKE "%.pdf%" OR TO_JSON_STRING(content) LIKE "%.doc%" THEN "DOCUMENT"
          WHEN TO_JSON_STRING(content) LIKE "%.mp3%" OR TO_JSON_STRING(content) LIKE "%.wav%" THEN "AUDIO"
          WHEN TO_JSON_STRING(content) LIKE "%.mp4%" OR TO_JSON_STRING(content) LIKE "%.webm%" THEN "VIDEO"
          ELSE "LARGE_PAYLOAD_JSON"
        END AS asset_type
      FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events`
      WHERE TO_JSON_STRING(content) LIKE "%gs://%" OR TO_JSON_STRING(attributes) LIKE "%gs://%"
    ;;
  }

  dimension: trace_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.trace_id ;;
  }

  dimension: session_id {
    label: "Session ID"
    group_label: "Multimodal GCS Offloading"
    description: "Conversation session identifier associated with the GCS offloaded object."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: gcs_uri {
    label: "GCS Object URI (gs://...)"
    group_label: "Multimodal GCS Offloading"
    description: "What: Google Cloud Storage object URI where multimodal content or large payload (>1MB) was offloaded. How: Extracted from agent_events content/attributes JSON. Why: Enables tracking and auditing of external GCS storage objects."
    type: string
    sql: ${TABLE}.gcs_uri ;;
  }

  dimension: asset_type {
    label: "Multimodal Asset Type"
    group_label: "Multimodal GCS Offloading"
    description: "What: Categorization of the GCS offloaded object (IMAGE, DOCUMENT, AUDIO, VIDEO, or LARGE_PAYLOAD_JSON). How: Evaluates file extension and JSON schema in offloaded content. Why: Monitors storage footprint by modality."
    type: string
    sql: ${TABLE}.asset_type ;;
  }

  measure: total_gcs_offloaded_assets {
    label: "Total GCS Offloaded Assets"
    group_label: "Multimodal GCS Offloading"
    description: "What: Total count of large payloads and multimodal assets offloaded to GCS bucket japac-pso-agent-analytics. How: COUNT of offloaded rows. Why: Tracks GCS bucket object table volume and storage utilization."
    type: count
  }
}
