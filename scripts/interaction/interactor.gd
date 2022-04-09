extends Node2D

class_name Interactor

export(Resource) var _interactor_data
export(bool) var _debug : bool

signal interacted(interactor, node)
signal interactable_registered(node)
signal interactable_unregistered(node)

var _interactables_in_range : Array

func interact():
	var interactable = _get_closest_interactable() as Interactable
	var context = null
	if interactable:
		context = interactable.interact(self)
		emit_signal("interacted", self, interactable)
	return context

func has_avaible_interaction() -> bool:
	return !_interactables_in_range.empty()

func _register_interactable(node) -> int:
	if node:
		if !_interactables_in_range.has(node):
			_interactables_in_range.append(node)
			emit_signal("interactable_registered", node)
			# InteractorData resource integration
			_register_interactor_data(node)
			# ------------------------------------
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
			emit_signal("interactable_registered", node)
			# InteractorData resource integration
			_unregister_interactor_data(node)
			# ------------------------------------
			return node
		else:
			push_warning("tried unregistering non existing interactable")
			return null
	else:
			push_warning("invald index")
			return null

func _register_interactor_data(node):
	# InteractorData resource integration
	if _interactor_data:
		if _interactor_data is InteractorData:
			_interactor_data.add_avaible_interactable(node)
	# ------------------------------------
func _unregister_interactor_data(node):
	# InteractorData resource integration
	if _interactor_data:
		if _interactor_data is InteractorData:
			_interactor_data.remove_avaible_interactable(node)
	# ------------------------------------


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
		return _interactables_in_range[0]
	else:
		return null

func _find_interactable(node : Node) -> Interactable:
	for child in node.get_children():
		if child is Interactable:
			return child
	return null

func _on_interactable_enter(body):
	if body.is_in_group("Interactable"):
		var interactable = _find_interactable(body)
		var index = _register_interactable(interactable)
		if index > -1:
			if _debug:
				print("registered interactable : {node}".format({"node" : interactable}))
		else:
			push_warning("non existing interactable")

func _on_interactable_exit(body):
	if body.is_in_group("Interactable"):
		var interactable = _find_interactable(body)
		if _interactables_in_range.has(interactable):
			var index = _get_interactable_index(interactable)
			_unregister_interactable(index)
			if _debug:
				print("unregistered interactable : {node}".format({"node" : interactable}))
		else:
			push_warning("non existing interactable")
