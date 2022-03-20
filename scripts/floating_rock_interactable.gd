tool
extends FakeHeightKinematicBody

func _on_Interactable_interacted():
	queue_free()
