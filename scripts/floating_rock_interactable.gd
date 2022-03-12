tool
extends FakeHeightKinematicBody

func _on_InteractionInterface_interacted(interface, trigger):
	queue_free()
