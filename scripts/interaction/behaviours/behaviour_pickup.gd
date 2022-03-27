extends InteractableBehaviour

class_name InteractableBehaviourPickup

export(NodePath) onready var slotable = get_node_or_null(slotable) as Slotable

func on_interact(_node):
	if slotable:
		return slotable
	else:
		return _node
