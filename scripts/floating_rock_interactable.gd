tool
extends FakeHeightKinematicBody

export(PackedScene) var _slotable_scene

func _on_InteractionInterface_interacted(context):
	queue_free()