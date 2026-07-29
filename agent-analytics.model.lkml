connection: "@{CONNECTION_NAME}"

datagroup: agent_events_datagroup {
  max_cache_age: "30 minutes"
  sql_trigger: SELECT MAX(timestamp) FROM `@{PROJECT_ID}.@{DATASET_NAME}.agent_events` ;;
}


include: "/views/refined/*.view.lkml"
include: "/explores/*.explore.lkml"
include: "/dashboards/agent_analytics_performance.dashboard.lookml"
include: "/dashboards/agent_analytics_usage.dashboard.lookml"
include: "/dashboards/pso_apo_executive_portal.dashboard.lookml"
