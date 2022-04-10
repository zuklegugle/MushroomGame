extends InteractablePickup

class_name PickupItemContainer

export(NodePath) onready var _item_slot = get_node_or_null(_item_slot) as ItemSlot

signal item_stored(node, item)
signal item_taken(node, item)

func _init():
	_add_interaction("Store", funcref(self, "_on_item_store"))
	_add_interaction("Take", funcref(self, "_on_item_take"))

func store_item(item : ItemBase):
	if !_item_slot.get_item():
		var slot = item.get_parent() as ItemSlot
		slot.unslot()
		item.get_parent().remove_child(item)
		_item_slot.add_child(item)
		_item_slot.slot(item)
		emit_signal("item_stored", self, item)
		return true
	else:
		return false

func take_item():
	if _item_slot.get_item():
		var item = _item_slot.unslot()
		item.get_parent().remove_child(item)
		emit_signal("item_taken", self, item)
		return item

func create_item() -> ItemBase:
	var item = .create_item() as ItemBase
	var item_in_slot = _item_slot.get_item() as ItemBase
	if item:
		if item_in_slot:
			var _slot = item.find_node("ItemSlot")
			print(_slot)
			if _slot:
				var data = item_in_slot.item_data
				var item_inside = Game.spawn_item(data)
				_slot.slot(item_inside)
				_slot.add_child(item_inside)
				print("created: ", item_inside)
		return item
	else:
		print("failed to create item")
		return null

func occupied():
	if _item_slot.get_item():
		return true
	else:
		return false

func find_item_slot(node):
	for child in node.get_children():
		print(child)
		if child is ItemSlot:
			return child
	return {}

func _on_item_store(_node, _interaction_data):
	var item = _interaction_data.item as ItemBase
	if item.is_in_group("Container"):
		return null
	if store_item(item):
		return {
			"stored_item" : _item_slot.get_item()
		}
	else:
		return {}

func _on_item_take(_node, _interaction_data):
	var data = {
		"item" : take_item()
	}
	return data
