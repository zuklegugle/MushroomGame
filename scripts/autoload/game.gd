extends Node

class_name AutoloadGame

export(Resource) var item_database
export(Resource) var object_database

var current_world : MapBase

func _ready():
	current_world = get_tree().current_scene
	object_database.print_data()

func spawn_scene(position : Vector2, scene : PackedScene):
	if current_world:
		if scene:
			var new_scene = scene.instance()
			current_world.base_node.add_child(new_scene)
			new_scene.global_position = position
			return new_scene
		else:
			push_warning("invalid scene")
	else:
		push_warning("no current world")

func spawn_object(position : Vector2, object : ObjectData):
	var database = object_database.database as Dictionary
	if database.has(object):
		return spawn_scene(position, database[object])

func spawn_item(item_id) -> ItemBase:
	var scene = ItemRegistry.get_item_scene(item_id)
	if scene:
		var item_instance = scene.instance()
		return item_instance
	else:
		return null 
