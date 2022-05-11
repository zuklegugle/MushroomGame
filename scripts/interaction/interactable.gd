class_name Interactable extends Node

export(NodePath) onready var target = get_node_or_null(target)

signal interacted(interactor, interactable, state)

# public methods
func interact(interactor, state):
	var target = interactor.target
	match(state):
		Interaction.STARTED:
			_on_interaction_started(interactor)
		Interaction.CANCELED:
			_on_interaction_canceled(interactor)
		Interaction.PERFORMED:
			_on_interaction_finished(interactor)
	
	emit_signal("interacted", interactor, self, state)

func get_context_hint() -> String:
	return "Interact"

# private methods and overrides
func _on_interaction_started(_interactor):
	pass

func _on_interaction_canceled(_interactor):
	pass

func _on_interaction_finished(_interactor):
	pass
	
