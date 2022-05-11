class_name Prop extends Entity

onready var entity_renderer = $EntityRenderer as EntityRenderer

func _on_interacted(interactor, interactable, state):
	if state == Interaction.STARTED:
		var entity = interactor.target
		if entity.has_method("pickup_entity"):
			entity.pickup_entity(self)

func pickup():
	entity_renderer.render_shadow = false

func drop():
	entity_renderer.render_shadow = true
