extends Resource

class_name SpawnableObjects

export(Array, PackedScene) var spawnable_objects

func get_object_from_index(index):
	return spawnable_objects[index]

func is_scene_spawnable(scene : PackedScene):
	var value : bool
	if spawnable_objects.find(scene):
		return true
	else:
		return false
