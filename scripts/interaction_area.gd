extends Area2D

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

func _on_InteractionArea_area_entered(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if !_avaible_interactions.has(interaction_interface):
			_avaible_interactions.append(interaction_interface)

func _on_InteractionArea_area_exited(body):
	var interaction_interface = _get_interaction_interface(body)
	if interaction_interface:
		if _avaible_interactions.has(interaction_interface):
			var idx = _avaible_interactions.find(interaction_interface)
			_avaible_interactions.remove(idx)

func _get_interaction_interface(node):
	var children = node.get_children()
	for child in children:
		if child is InteractionInterface:
			return child
	return null
