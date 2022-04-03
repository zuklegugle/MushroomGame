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

func spawn_object(position : Vector2, object : ObjectData):
	var database = object_database.database as Dictionary
	if database.has(object):
		spawn_scene(position, database[object])

func spawn_item(item : ItemData) -> ItemBase:
	if item:
		var database = item_database.database as Dictionary
		if database.has(item):
			var item_instance = database[item].instance() as ItemBase
			return item_instance
		else:
			return null
	else:
		return null
		 
