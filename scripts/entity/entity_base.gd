class_name EntityBase extends KinematicBody2D

export(String) var entity_id

var metadata := {}

func create():
	pass

func destroy():
	queue_free()

func _apply_metadata(data : Dictionary):
		metadata = data.duplicate()
