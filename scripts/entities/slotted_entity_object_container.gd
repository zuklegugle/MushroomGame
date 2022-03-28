extends SlottedEntityObject

class_name SlottedEntityObjectContainer

export(NodePath) onready var entity_slot = get_node_or_null(entity_slot) as SlottedEntitySlot

var slotted_entity

func on_slot(slot : SlottedEntitySlot):
	pass
#	var stored_entity_in_slot = slot._stored_entity
#	var container = stored_entity_in_slot.container as EntityObjectContainer
#	if container.stored_entity:
#		populate_slot(load(container.stored_entity.filename))

func populate_slot(scene : PackedScene):
	if entity_slot:
		if scene:
			entity_slot._spawn_and_slot(scene)
