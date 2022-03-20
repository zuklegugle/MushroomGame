extends Node2D

class_name Interactor

export(bool) var _debug : bool

signal interacted(node)
signal interactable_detected(node)

var _interactables_in_range : Array

func interact():
	var interactable = _get_closest_interactable() as Interactable
	if interactable:
		interactable.interact()
		emit_signal("interacted", interactable)

func _register_interactable(node) -> int:
	if node:
		if !_interactables_in_range.has(node):
			_interactables_in_range.append(node)
			return _interactables_in_range.size() - 1
		else:
			push_warning("tried registering already registered interactable")
			return -1
	else:
		push_warning("tried registering non existing interactable")
		return -1

func _unregister_interactable(index : int):
	if index >= 0:
		var node = _interactables_in_range[index]
		if node:
			_interactables_in_range.remove(index)
			return node
		else:
			push_warning("tried unregistering non existing interactable")
			return null
	else:
			push_warning("invald index")
			return null

func _get_interactable_from_node(node) -> Interactable:
	var interactable = node.find_node("Interactable")
	if interactable is Interactable:
		return interactable
	else:
		push_warning("Cannot get interactable from node")
		return null

func _get_interactable_index(node) -> int:
	return _interactables_in_range.find(node)

func _get_closest_interactable() -> Interactable:
	if !_interactables_in_range.empty():
		return _find_interactable(_interactables_in_range[0])
	else:
		return null

func _find_interactable(node : Node) -> Interactable:
	for child in node.get_children():
		if child is Interactable:
			return child
	return null

func _on_interactable_enter(body):
	if body.is_in_group("Interactable"):
		var index = _register_interactable(body)
		if index > -1:
			emit_signal("interactable_detected", body)
			if _debug:
				print("registered interactable : {node}".format({"node" : body}))
		else:
			push_warning("non existing interactable")

func _on_interactable_exit(body):
	if body.is_in_group("Interactable"):
		if _interactables_in_range.has(body):
			var index = _get_interactable_index(body)
			_unregister_interactable(index)
			if _debug:
				print("unregistered interactable : {node}".format({"node" : body}))
		else:
			push_warning("non existing interactable")
