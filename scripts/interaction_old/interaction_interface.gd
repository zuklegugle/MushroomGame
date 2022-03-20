extends Node

class_name InteractionInterface

export(Resource) var interaction_type

signal interacted(context)

func interact(node) -> InteractionContext:
	var context = _create_context(node, {})
	context = _on_interact(node, context)
	emit_signal("interacted", context)
	return context

func _create_context(node, data) -> InteractionContext:
	var context = InteractionContext.new()
	context.type = interaction_type
	context.interacted_by = node
	context.interacted_with = get_parent()
	context.interaction_data = data
	return context

func _on_interact(_node, context) -> InteractionContext:
	return context
