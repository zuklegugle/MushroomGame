tool
extends FakeHeightKinematicBody

func _on_Interactable_interacted(node):
	queue_free()
