extends Node

class_name FakeHeight

export(NodePath) onready var target = get_node_or_null(target) as Node2D
export(float) var height
export(float) var max_height
export(float) var floor_point

func _adjust_target_position():
	target.position.y = -height

func _process(delta):
	if target:
		_adjust_target_position()
