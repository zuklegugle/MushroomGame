class_name EntityBase extends KinematicBody2D

export(String) var entity_id

signal created(entity)
signal destroyed(entity)

var _entity_data : EntityData
var metadata : Dictionary = {}

# callbacks
func _ready():
	if !Engine.editor_hint:
		_entity_data = EntityRegistry.get_entity_data(entity_id)

# public methods
func create(_data):
	_on_create(_data)
	emit_signal("created", self)
	return _data

func destroy():
	_on_destroy()
	emit_signal("destroyed", self)
	queue_free()

func to_metadata() -> Dictionary:
	return _to_metadata()

# overrides
func _on_create(_data):
	return _data

func _on_destroy():
	pass

func _to_metadata() -> Dictionary:
	var meta = {}
	meta.entity_id = entity_id
	return meta
