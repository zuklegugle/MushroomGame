extends Node

const filepath = "res://data/registry/items/"

var _registry = {}


func _ready():
	_get_items()
	print("ITEM REGISTRY", _registry)

func _get_items():
	var items = []
	var dir = Directory.new()
	dir.open(filepath)
	dir.list_dir_begin(true)
	
	var file = dir.get_next()
	while file != '':
		var item = load(filepath + file)
		if item:
			if register_item(file.trim_suffix(".tres"), item.scene.resource_path):
				print("item registered: ", file)
		file = dir.get_next()
	

func get_item_scene(item_id : String) -> PackedScene:
	return _registry[item_id]

func register_item(item_id : String, scene_path : String):
	if !_registry.has(item_id):
		var scene = load(scene_path)
		if scene:
			_registry[item_id] = scene
			return true
		else:
			push_error(str("ITEM REGISTRY: failed to register item ", item_id, " scene couldnt be loaded"))
			return false
	else:
		push_error(str("ITEM REGISTRY: failed to register item ", item_id, " already exists in the registry"))
		return false
