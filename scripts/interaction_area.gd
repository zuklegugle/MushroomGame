extends Area2D

class_name PlayerInteractionRange

export(Resource) var _player_interaction_data
var _avaible_interactions = []

func interact():
	if !_avaible_interactions.empty():
		var interface = _avaible_interactions[0] as InteractionInterface
		print(_avaible_interactions)
		interface.interact(self)

func has_avaible_interactions():
	if !_avaible_interactions.empty():
		return true
	else:
		return false

func _on_InteractionRange_area_entered(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if !_avaible_interactions.has(interaction_interface):
			_register_interaction(interaction_interface)

func _on_InteractionRange_area_exited(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if _avaible_interactions.has(interaction_interface):
			_unregister_interaction(interaction_interface)

func _on_InteractionRange_body_entered(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if !_avaible_interactions.has(interaction_interface):
			_register_interaction(interaction_interface)

func _on_InteractionRange_body_exited(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if _avaible_interactions.has(interaction_interface):
			_unregister_interaction(interaction_interface)

func _get_interaction_interface(node):
	var children = node.get_children()
	for child in children:
		if child is InteractionInterface:
			return child
	return null

func _register_interaction(node):
	_avaible_interactions.append(node)
	if _player_interaction_data:
		_player_interaction_data.add_interaction(node)

func _unregister_interaction(node):
	var idx = _player_interaction_data.remove_interaction(node)
	_avaible_interactions.remove(idx)
