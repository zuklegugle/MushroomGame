extends Interactable

class_name Pickup

export(NodePath) onready var slotable = get_node_or_null(slotable) as Slotable

func _on_interact(_node):
	if slotable:
		return slotable
