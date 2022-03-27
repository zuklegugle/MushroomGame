extends Position2D

class_name EntitySlot

signal entity_slotted(entity)
signal entity_unslotted(entity)

var _drop_position 

var slotted_entity : SlottedEntity

var _stored_entity

func _ready():
	_drop_position = get_child(0)

func _exit_tree():
	if _stored_entity:
		print("freeing stored entity")
		_stored_entity.free()

func _on_interacted(_interactor : Interactor, interactable : Interactable):
	var pickup = interactable as Pickup
	if pickup:
		var slotable = pickup.slotable as Slotable
		var scene = slotable.slotted_scene
		if scene:
			var new_entity = _spawn_and_slot(scene)
			_store_entity(interactable.target)
			print("entity slotted", new_entity)

func slot(entity : SlottedEntity):
	if entity:
		if !slotted_entity:
			slotted_entity = entity
			add_child(entity)
			emit_signal("entity_slotted", entity)
		else:
			push_error("slot failed: slot already occupied")
	else:
		push_warning("Slot failed: entity doesnt exists")

func unslot() -> SlottedEntity:
	if slotted_entity:
		var entity = slotted_entity
		remove_child(slotted_entity)
		slotted_entity = null
		emit_signal("entity_unslotted", entity)
		return entity
	else:
		push_warning("Unslot failed: slot is empty")
		return null

func drop():
	var entity = unslot()
	if entity:
		if _drop_position:
			Game.reactivate(_stored_entity)
			_stored_entity.global_position = _drop_position.global_position
			_stored_entity = null
			#Game.spawn_scene(_drop_position.global_position, entity.dropped_scene)
		else:
			Game.reactivate(_stored_entity)
			_stored_entity.global_position = global_position
			_stored_entity = null
			#Game.spawn_scene(global_position, entity.dropped_scene)
		entity.on_drop()

func _store_entity(node):
	_stored_entity = Game.deactivate(node)

func _spawn_and_slot(scene : PackedScene) -> SlottedEntity:
	if !slotted_entity:
		var new_entity = scene.instance() as SlottedEntityObject
		add_child(new_entity)
		slotted_entity = new_entity
		emit_signal("entity_slotted", new_entity)
		return new_entity
	else:
		push_warning("slot already occupied")
		return null
