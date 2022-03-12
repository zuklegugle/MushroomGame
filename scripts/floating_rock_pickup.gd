tool
extends FakeHeightKinematicBody

export(PackedScene) var _slotable_scene

func _on_InteractionInterface_interacted(context):
	queue_free()

func get_slotable_scene():
	return _slotable_scene
