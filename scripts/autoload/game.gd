extends Node

var _current_level : Level
var _current_players : Array

func _ready():
	_current_level = get_tree().current_scene
	_current_players = get_current_players()

func get_current_level() -> Level:
	return _current_level

func get_current_players() -> Array:
	return get_tree().get_nodes_in_group("Player")

func spawn_scene(position : Vector2, scene : PackedScene):
	if _current_level:
		if scene:
			var new_scene = scene.instance()
			_current_level.spawn_root.add_child(new_scene)
			new_scene.global_position = position
			return new_scene
		else:
			push_warning("invalid scene")
	else:
		push_warning("no current level")

func spawn_entity(entity_id : String, position : Vector2) -> Entity:
	var data = EntityRegistry.get_entity_data(entity_id) as EntityData
	if data:
		var entity_instance = spawn_scene(position, data.entity_scene) as Entity
		return entity_instance
	else:
		return null
