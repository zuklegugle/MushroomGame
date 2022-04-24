extends Node

const filepath = "res://data/entity/"

var _registry = {}

func _init():
	_get_entities()
	print("ENTITY REGISTRY", _registry)

func _get_entities():
	var dir = Directory.new()
	dir.open(filepath)
	dir.list_dir_begin(true)
	
	var file = dir.get_next()
	while file != '':
		var entity = load(filepath + file)
		if entity:
			if register_entity(file.trim_suffix(".tres"), entity):
				print("entity registered: ", file)
		file = dir.get_next()
	

func get_entity_data(entity_id : String) -> EntityData:
	return _registry.get(entity_id)

func register_entity(entity_id : String, entity_data : EntityData) -> bool:
	if !_registry.has(entity_id):
		if entity_data:
			_registry[entity_id] = entity_data
			return true
		else:
			push_error(str("ENTITY REGISTRY: failed to register entity ", entity_id, " data couldnt be loaded"))
			return false
	else:
		push_error(str("ENTITY REGISTRY: failed to register entity ", entity_id, " already exists in the registry"))
		return false
