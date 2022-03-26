extends Node

class_name Interactable

export(NodePath) var target setget _set_target
export(String) var hint = "Interact"

signal interacted(node)
signal target_changed(node)
signal target_removed()

func interact(node):
	print("interacted with interactable")
	emit_signal("interacted", node)

func _set_target(value : Node):
	target = value
	if value != null:
		emit_signal("target_changed", value)
	else:
		emit_signal("target_removed")
