view: gcs_multimodal_object_table {
  sql_table_name: `@{PROJECT_ID}.@{DATASET_NAME}.gcs_multimodal_object_table` ;;

  dimension: uri {
    primary_key: yes
    label: "GCS Object URI"
    group_label: "BigQuery GCS Object Table"
    description: "What: Google Cloud Storage object URI in bucket japac-pso-agent-analytics. How: Direct reference from BigQuery Object Table gcs_multimodal_object_table. Why: Identifies the exact GCS storage asset."
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: content_type {
    label: "MIME Content Type"
    group_label: "BigQuery GCS Object Table"
    description: "What: MIME type of the offloaded GCS object (image/png, application/pdf, application/json, etc.). How: Extracted from GCS SIMPLE object metadata. Why: Categorizes multimodal offload storage by file type."
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: asset_type {
    label: "Multimodal Asset Type"
    group_label: "BigQuery GCS Object Table"
    description: "What: High-level asset category (IMAGE, DOCUMENT, AUDIO, VIDEO, LARGE_PAYLOAD_JSON). How: Derived from content_type MIME string in object table. Why: Monitors storage footprint by modality."
    type: string
    sql: CASE
      WHEN ${TABLE}.content_type LIKE 'image/%' THEN 'IMAGE'
      WHEN ${TABLE}.content_type LIKE 'application/pdf' OR ${TABLE}.content_type LIKE '%word%' THEN 'DOCUMENT'
      WHEN ${TABLE}.content_type LIKE 'audio/%' THEN 'AUDIO'
      WHEN ${TABLE}.content_type LIKE 'video/%' THEN 'VIDEO'
      ELSE 'LARGE_PAYLOAD_JSON'
    END ;;
  }

  measure: total_object_count {
    label: "Total GCS Object Table Files"
    group_label: "BigQuery GCS Object Table"
    description: "What: Count of files stored in GCS bucket japac-pso-agent-analytics. How: COUNT of object table rows. Why: Tracks physical GCS bucket object inventory."
    type: count
  }

  measure: total_size_bytes {
    label: "Total GCS Storage Bytes"
    group_label: "BigQuery GCS Object Table"
    description: "What: Total storage footprint in bytes across GCS offloaded objects. How: SUM(size) in bytes from object table metadata. Why: Monitors cloud storage costs and payload volume."
    type: sum
    sql: ${TABLE}.size ;;
  }
}
