class_name Entity extends KinematicBody2D

export(String) var entity_id

func _ready():
	add_to_group("Entity", true)
