extends Resource

class_name PlayerInteractionData

export(Array) var _avaible_interactions = []

signal data_changed

func add_interaction(node):
	_avaible_interactions.append(node)
	print("registered player avaible interaction")
	_print_data()
	emit_signal("data_changed")

func remove_interaction(node):
	var idx = _avaible_interactions.find(node)
	if idx != -1:
		_avaible_interactions.remove(idx)
		print("unregistered player avaible interaction")
		_print_data()
		emit_signal("data_changed")
		return idx
	return -1

func has_avaible_interactions():
	return !_avaible_interactions.empty()

func get_avaible_interactions():
	return _avaible_interactions

func _print_data():
	print(_avaible_interactions)
