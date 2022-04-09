extends ItemSlot

class_name HeldItemSlot

export(NodePath) onready var _drop_position = get_node_or_null(_drop_position)

var _stored_object_data = {}

var _stored_owner_node = null
var _stored_owner_node_parent = null

func _exit_tree():
	if _stored_owner_node:
		print("freed stored owner")
		_stored_owner_node.queue_free()

func equip(item : ItemBase):
	add_child(item)
	slot(item)
	var object_item = item as ObjectItem
	if object_item:
		_stored_object_data["object"] = object_item.object_data
		_stored_object_data["metadata"] = item.metadata
		print(_stored_object_data)

func equip_object(object : ObjectBase):
	_stored_owner_node = object
	_stored_owner_node_parent = object.get_parent()
	_stored_owner_node_parent.remove_child(object)

func unequip():
	if _item:
		var item = unslot()
		item.queue_free()
#		if _stored_object_data:
#			var object = Game.spawn_object(_drop_position.global_position, _stored_object_data) as ObjectBase
#		var object = _stored_owner_node
#		_stored_owner_node_parent.add_child(_stored_owner_node)
#		_stored_owner_node.global_position = global_position
#		_stored_owner_node = null
#		_stored_owner_node_parent = null
		var data = _stored_object_data.duplicate(true)
		_stored_object_data.clear()
		return data

func _on_interacted(interactor, node, context):
	var interactable = node as Interactable
#	if !_item:
#		var object = node.owner as ObjectBase
#		var pickup = node as Pickup
#		var interactions
#		for interaction in interactable.avaible_interactions:
#			if interaction == "Pickup":
#				var item = context as ItemBase
#				if item:
#					equip(item)
#					equip_object(object)
#	else:
#		for interaction in interactable.avaible_interactions:
#			if interaction == "Store":
#				var container = node as PickupItemContainer
#				if container:
#					if !container.occupied():
#						container.store_item(_item)
