extends ItemSlot

class_name HeldItemSlot

export(NodePath) onready var _drop_position = get_node_or_null(_drop_position)

var _stored_object_data : ObjectData

var _stored_owner_node = null
var _stored_owner_node_parent = null

func _exit_tree():
	if _stored_owner_node:
		print("freed stored owner")
		_stored_owner_node.queue_free()

func equip(item : ItemBase):
	add_child(item)
	slot(item)

func unequip():
	if _item:
		var item = unslot()
		item.queue_free()
#		if _stored_object_data:
#			var object = Game.spawn_object(_drop_position.global_position, _stored_object_data) as ObjectBase
		_stored_owner_node_parent.add_child(_stored_owner_node)
		_stored_owner_node.global_position = _drop_position.global_position
		_stored_owner_node = null
		_stored_owner_node_parent = null

func _on_interacted(interactor, node):
	if !_item:
		var object = node.owner as ObjectBase
		var pickup = node as Pickup
		if pickup:
			var item = pickup.pickup()
			if item:
				equip(item)
#				if object:
#					_stored_object_data = object.object_data
#					object.destroy()
				_stored_owner_node = pickup.owner
				_stored_owner_node_parent = _stored_owner_node.get_parent()
				_stored_owner_node_parent.remove_child(_stored_owner_node)
	else:
		var container = node as PickupItemContainer
		if container:
			if !container.occupied():
				container.store_item(_item)
