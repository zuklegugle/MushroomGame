extends InteractionRange

class_name PlayerInteractionRange

export(NodePath) var _object_slot

func _ready():
	_object_slot = get_node(_object_slot) as ObjectSlot

# public methods
func interact() -> InteractionContext:
	if !_object_slot._sloted_object:
		if !_avaible_interactions.empty():
				var interface = _avaible_interactions[0] as InteractionInterface
				print(_avaible_interactions)
				var context = interface.interact(get_parent())
				emit_signal("interacted", context)
				return context
		else:
			return null
	else:
		print("test")
		var obj = _object_slot._sloted_object
		var interface = obj._interaction_interface
		var context = interface.interact(get_parent())
		emit_signal("interacted", context)
		return context
