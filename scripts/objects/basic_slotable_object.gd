extends SlotableObject

class_name BasicSlotableObject

export(int) var dropped_scene_index = -1

func _on_interact(callback_context : InteractionContext):
	match(callback_context.type.display_name):
		"Use":
			_drop()

func _drop():
	if dropped_scene_index != -1:
		var map = get_tree().root.get_child(0) as MapBase
		if map:
			if map is MapBase:
				map.spawn_object_from_index(get_parent().global_position, dropped_scene_index)
				self.slot = null
				queue_free()
