class_name EntityBase extends KinematicBody2D

export(String) var entity_id

signal created(entity)
signal destroyed(entity)

var _entity_data : EntityData
var metadata : Dictionary = {}

func _ready():
	_entity_data = EntityRegistry.get_entity_data(entity_id)
	
func create(_data):
	_on_create(_data)
	emit_signal("created", self)
	return _data

func destroy():
	_on_destroy()
	emit_signal("destroyed", self)
	queue_free()

func _on_create(_data):
	return _data

func _on_destroy():
	pass
