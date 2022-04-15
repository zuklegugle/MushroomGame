extends InteractablePickup

class_name PickupItemContainer

export(NodePath) onready var _item_slot = get_node_or_null(_item_slot) as ItemSlot

signal item_stored(node, item)
signal item_taken(node, item)

func _on_player_interaction_started(player_data):
	var data = {"type": "undefined"}
	# player is not holding an item
	if !player_data.data.item:
		if _item_slot.get_item():
			return data
		data = ._on_player_interaction_started(player_data)
		return data
	else:
	# player is holding an item
		var item = player_data.data.item as ItemBase
		# not allow to store containers
		if item.is_in_group("Container"):
			return data
		# item stored successfully
		if store_item(item):
			return {
				"type": "item_stored",
				"stored_item" : _item_slot.get_item()
			}
		# failed to store item
		else:
			return data

func _on_player_interaction_canceled(player_data):
	var data = {"type": "undefined"}
	# player is not holding an item
	if !player_data.data.item:
		data = ._on_player_interaction_started(player_data)
		return data
	else:
		return data

func _on_player_interaction_finished(player_data):
	var data = {"type": "undefined"}
	# player is not holding an item
	if !player_data.data.item:
		var _item = take_item()
		if _item:
			return {
				"type": "item_taken",
				"item": _item
			}
	return data

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
