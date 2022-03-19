extends InteractionInterface

func _on_interact(node, callback_context : InteractionContext) -> InteractionContext:
	print("slotable object interface interacted")
	return callback_context
