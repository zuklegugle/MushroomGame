extends Node

class_name Interactable

export(NodePath) onready var target = get_node_or_null(target) setget _set_target
export(String) var hint = "Interact"

signal interacted(node)
signal target_changed(node)
signal target_removed()

func interact(_node) -> Node:
	print("interacted with interactable")
	emit_signal("interacted", _node)
	return _on_interact(self)

func _set_target(value):
	target = value
	if value != null:
		emit_signal("target_changed", value)
	else:
		emit_signal("target_removed")

func _on_interact(_node) -> Node:
	return _node