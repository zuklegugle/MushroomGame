extends Node

class_name EntityObjectContainer

export(NodePath) onready var entity_slot = get_node_or_null(entity_slot) as SlottedEntitySlot

var stored_entity

func _ready():
	if entity_slot.get_child_count() > 0:
		store_object(entity_slot.get_child(0))
		print("stored object into container ", stored_entity)

func store_object(object):
	stored_entity = object

func remove_object(object = null):
	if !object:
		stored_entity =  null
		return stored_entity
	else:
		return null
