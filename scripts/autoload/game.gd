extends Node

class_name AutoloadGame

var current_world : MapBase

func _ready():
	current_world = get_tree().current_scene

func spawn_scene(position : Vector2, scene : PackedScene):
	if current_world:
		if scene:
			var new_scene = scene.instance()
			current_world.base_node.add_child(new_scene)
			new_scene.global_position = position
		else:
			push_warning("invalid scene")
	else:
		push_warning("no current world")

func deactivate(node):
	node.get_parent().remove_child(node)
	return node

func reactivate(node):
	current_world.base_node.add_child(node)

func spawn_entity_object():
	print("Root node: ", get_tree().current_scene)
