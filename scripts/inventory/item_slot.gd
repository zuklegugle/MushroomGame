extends Position2D

class_name ItemSlot

export(NodePath) onready var _item_path

signal item_slotted(item)
signal item_unslotted(item)

var _item : ItemBase

func _ready():
	var item = get_node_or_null(_item_path) as ItemBase
	if item:
		slot(item)

func slot(item : ItemBase):
	if item:
		if item is ItemBase:
			_item = item
			emit_signal("item_slotted", item)
			print("item slotted")
			_item.connect("destroyed", self, "_on_item_destroyed")
		else:
			push_error("Object is not an item")

func unslot() -> ItemBase:
	if _item:
		var _current_item = _item
		_item = null
		emit_signal("item_unslotted", _current_item)
		print("item unslotted")
		_current_item.disconnect("destroyed", self, "_on_item_destroyed")
		return _current_item
	else:
		push_warning("Slot is empty")
		return null

func get_item() -> ItemBase:
	return _item

func get_item_data() -> ItemData:
	return _item.item_data

# SIGNAL CALLBACKS
func _on_item_destroyed(item):
	unslot()
	print("ITEM IN SLOT WAS DESTROYED")
