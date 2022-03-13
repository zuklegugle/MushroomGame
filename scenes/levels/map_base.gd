extends Node2D

class_name MapBase

export(Resource) var spawnable_objects

onready var base_node = $YSort

func spawn_object(spawn_position : Vector2, object_scene : PackedScene):
	var new_object = object_scene.instance()
	new_object.global_position = spawn_position
	base_node.add_child(new_object)
	return new_object

func spawn_object_from_index(spawn_position : Vector2, object_scene_index : int):
	if spawnable_objects:
		if spawnable_objects is SpawnableObjects:
				var scene = spawnable_objects.get_object_from_index(object_scene_index)
				if scene:
					var new_object = scene.instance()
					new_object.global_position = spawn_position
					base_node.add_child(new_object)
					return new_object
				else:
					print("failed to spawn object from index")
