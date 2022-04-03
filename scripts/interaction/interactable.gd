extends Node

class_name Interactable

signal interacted(node)

var _hint = "Interact"

func interact(_node) -> Node:
	print("interacted with interactable")
	emit_signal("interacted", _node)
	return _on_interact(self)

func get_hint() -> String:
	return _hint
	
func _on_interact(_node) -> Node:
	return _node
