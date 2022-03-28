extends Node2D

class_name SlottedEntity

var _entity
var _slot

func on_create_from_entity(entity):
	_entity = entity
	
func on_slot(slot):
	_slot = slot

func on_unslot():
	_slot = null
	_entity = null

func on_drop():
	print("entity dropped")
	_slot = null
	_entity = null
	queue_free()

func get_entity():
	return _entity
