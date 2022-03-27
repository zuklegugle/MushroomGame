extends Node

class_name EntityObjectContainer

export(NodePath) onready var entity_slot = get_node_or_null(entity_slot) as EntitySlot

var stored_entity

func _ready():
	if entity_slot.get_child_count() > 0:
		stored_entity = entity_slot.get_child(0)
