extends ObjectSlot

class_name PlayerObjectSlot

export(Resource) var _interaction_type

func _on_interact_with_object(callback_context : InteractionContext):
	_interaction_type = _interaction_type as InteractionType
	if callback_context.type.display_name == _interaction_type.display_name:
		var object_scene = _get_object_from_interaction_data(callback_context.interaction_data)
		if object_scene:
			var object = create_and_equip_from_scene(object_scene)
			
func _get_object_from_interaction_data(data : Dictionary) -> PackedScene:
	for entry in data:
		if data[entry] is PackedScene:
			return data[entry]
	return null

func _on_unsloted():
	_sloted_object = null
