extends Resource

class_name InteractorData

export(String) var display_name := ""
export(bool) var _debug := false

signal data_changed()
signal interactable_added(node)
signal interactable_removed(node)

var _avaible_interactables : Array

func add_avaible_interactable(node):
	if !_avaible_interactables.has(node):
		_avaible_interactables.append(node)
		emit_signal("interactable_added", node)
		emit_signal("data_changed")
		if _debug:
			print(_avaible_interactables)
	else:
		push_warning("Tried adding existing interactable to InteractorData")

func remove_avaible_interactable(node):
	if _avaible_interactables.has(node):
		var index = _avaible_interactables.find(node)
		if index != -1:
			var interactable = _avaible_interactables[index]
			_avaible_interactables.remove(index)
			emit_signal("interactable_removed", interactable)
			emit_signal("data_changed")
			if _debug:
				print(_avaible_interactables)
		else:
			push_warning("Tried removing non existing interactable from InteractorData")

func get_closest_interactable():
	if !_avaible_interactables.empty():
		return _avaible_interactables[0]
