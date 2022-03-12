extends ObjectSlot

export(Resource) var _interaction_type

func _on_interact_with_object(callback_context : InteractionContext):
	_interaction_type = _interaction_type as InteractionType
	if callback_context.type.display_name == _interaction_type.display_name:
		var scene = callback_context.interaction_data["slotable_scene"]
		if scene:
			if scene is PackedScene:
				create_and_equip_from_scene(scene)
			else:
				print("cannot create object (must be a scene)")
		else:
			print("received empty pickup data")
