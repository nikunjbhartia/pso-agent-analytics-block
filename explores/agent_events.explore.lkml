include: "/views/refined/*.view.lkml"

explore: agent_events {
  label: "Agent Analytics"
  description: "Analyze agent interactions, trace execution paths, evaluate LLM token usage, and monitor tool performance and errors."

  join: session_facts {
    type: left_outer
    sql_on: ${agent_events.session_id} = ${session_facts.session_id} ;;
    relationship: many_to_one
  }

  join: v_llm_response {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_llm_response.trace_id} AND ${agent_events.span_id} = ${v_llm_response.span_id} AND ${agent_events.event_type} = ${v_llm_response.event_type} ;;
    relationship: one_to_one
  }

  join: v_tool_completed {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_tool_completed.trace_id} AND ${agent_events.span_id} = ${v_tool_completed.span_id} AND ${agent_events.event_type} = ${v_tool_completed.event_type} ;;
    relationship: one_to_one
  }

  join: v_tool_error {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_tool_error.trace_id} AND ${agent_events.span_id} = ${v_tool_error.span_id} AND ${agent_events.event_type} = ${v_tool_error.event_type} ;;
    relationship: one_to_one
  }

  join: v_agent_transfer {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_agent_transfer.trace_id} AND ${agent_events.span_id} = ${v_agent_transfer.span_id} AND ${agent_events.event_type} = ${v_agent_transfer.event_type} ;;
    relationship: one_to_one
  }

  join: v_a2a_interaction {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_a2a_interaction.trace_id} AND ${agent_events.span_id} = ${v_a2a_interaction.span_id} AND ${agent_events.event_type} = ${v_a2a_interaction.event_type} ;;
    relationship: one_to_one
  }

  join: v_hitl_confirmation_request {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_hitl_confirmation_request.trace_id} AND ${agent_events.span_id} = ${v_hitl_confirmation_request.span_id} AND ${agent_events.event_type} = ${v_hitl_confirmation_request.event_type} ;;
    relationship: one_to_one
  }

  join: v_agent_error {
    type: left_outer
    sql_on: ${agent_events.trace_id} = ${v_agent_error.trace_id} AND ${agent_events.span_id} = ${v_agent_error.span_id} AND ${agent_events.event_type} = ${v_agent_error.event_type} ;;
    relationship: one_to_one
  }
}