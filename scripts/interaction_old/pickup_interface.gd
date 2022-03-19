extends InteractionInterface

class_name PickupInterface

export(PackedScene) var slotable_scene

func _on_interact(_node, context : InteractionContext):
	var _context = context
	_context.interaction_data = {"slotable_scene" : slotable_scene}
	return _context
