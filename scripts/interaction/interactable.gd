class_name Interactable extends Node

signal interacted(interactable, data)

# public methods

func interact(interactor, data):
	var interaction_data = {}
	
	match(data.type):
		"player_interaction_started":
			interaction_data = _on_player_interaction_started(data)
		"player_interaction_canceled":
			interaction_data = _on_player_interaction_canceled(data)
		"player_interaction_finished":
			interaction_data = _on_player_interaction_finished(data)
	
	data.interaction = interaction_data
	
	emit_signal("interacted", self, data)
	return InteractionContext.new(interactor, self, data)

func get_context_hint() -> String:
	return "Interact"

# private methods and overrides

func _on_player_interaction_started(_data) -> Dictionary:
	#print(str(self," registered player interaction started"))
	return {"type": "interact"}

func _on_player_interaction_canceled(_data) -> Dictionary:
	#print(str(self," registered player interaction canceled"))
	return {"type": "interact"}

func _on_player_interaction_finished(_data) -> Dictionary:
	#print(str(self," registered player interaction finished"))
	return {"type": "interact"}
	