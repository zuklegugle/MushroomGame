extends Node

var current_world : MapBase
var _current_player : EntityPlayer

func _ready():
	current_world = get_tree().current_scene
	var players = get_tree().get_nodes_in_group("EntityPlayer")
	if !players.empty():
		_current_player = players[0]

func get_current_player():
	return _current_player

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

func spawn_entity(entity_id : String, position : Vector2, metadata : Dictionary = {}) -> EntityBase:
	var data = EntityRegistry.get_entity_data(entity_id) as EntityData
	if data:
		var entity_instance = spawn_scene(position, data.entity_scene)
		if !metadata.empty():
			entity_instance.metadata = metadata.duplicate()
			entity_instance.create(metadata)
		return entity_instance
	else:
		return null

func spawn_item(item_id : String, metadata : Dictionary = {}) -> ItemBase:
	var data = ItemRegistry.get_item_data(item_id) as ItemData
	if data:
		var item_instance = data.item_scene.instance()
		if !metadata.empty():
			item_instance.metadata = metadata.duplicate()
		return item_instance
	else:
		return null 
