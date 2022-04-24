extends Node

const filepath = "res://data/item/"

var _registry = {}

func _init():
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
			if register_item(file.trim_suffix(".tres"), item):
				print("item registered: ", file)
		file = dir.get_next()
	

func get_item_data(item_id : String) -> ItemData:
	return _registry[item_id]

func register_item(item_id : String, item_data : ItemData) -> bool:
	if !_registry.has(item_id):
		if item_data:
			_registry[item_id] = item_data
			return true
		else:
			push_error(str("ITEM REGISTRY: failed to register item ", item_id, " data couldnt be loaded"))
			return false
	else:
		push_error(str("ITEM REGISTRY: failed to register item ", item_id, " already exists in the registry"))
		return false
