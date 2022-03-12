extends Resource

class_name PlayerInteractionData

export(Array) var _avaible_interactions = []

signal data_changed

func add_interaction(node, type : InteractionType):
	var new_entry = PlayerInteractionDataEntry.new(node, type)
	_avaible_interactions.append(new_entry)
	print("registered player avaible interaction")
	_print_data()
	emit_signal("data_changed")

func remove_interaction(node):
	for entry in _avaible_interactions:
		if entry.node == node:
			var idx = _avaible_interactions.find(entry)
			_avaible_interactions.remove(idx)
			print("unregistered player avaible interaction")
			_print_data()
			emit_signal("data_changed")
			return idx
	return -1

func has_avaible_interactions():
	return !_avaible_interactions.empty()

func get_closest_interaction_index():
	if _avaible_interactions.size() > 0:
		return 0
	else:
		return -1

func get_avaible_interactions():
	return _avaible_interactions

func _print_data():
	print(_avaible_interactions)


class PlayerInteractionDataEntry:
	
	var node
	var type : InteractionType
	
	func _init(n, t : InteractionType):
		node = n
		type = t
