extends Node

var current_world : MapBase

func _ready():
	current_world = get_tree().current_scene

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

func spawn_item(item_id) -> ItemBase:
	var data = ItemRegistry.get_item_data(item_id) as ItemData
	if data:
		var item_instance = data.item_scene.instance()
		return item_instance
	else:
		return null 
