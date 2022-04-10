class_name Basket extends ObjectBase

onready var slot = $YSort/ItemSlot as ItemSlot

func _init():
	metadata["test"] = "test"

func _ready():
	if slot.get_children().size() > 0:
		var item = slot.get_child(0)
		slot.slot(item)
		metadata["stored_item"] = {
			"item_data" : item.item_data,
			"metadata" : item.metadata
		}
		print("ITEM STORED: ", metadata["stored_item"])

func _apply_metadata(data : Dictionary):
	._apply_metadata(data)
	if metadata.has("stored_item"):
		if !slot.get_item():
			var item = Game.spawn_item(metadata.stored_item.item_data)
			if item:
				slot.slot(item)
				slot.add_child(item)

func _on_item_stored(node, item):
	metadata["stored_item"] = {
			"item_data" : item.item_data,
			"metadata" : item.metadata
		}
	print("ITEM STORED: ", metadata["stored_item"])

func _on_item_taken(node, item):
	metadata.erase("stored_item")
