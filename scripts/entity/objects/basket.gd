tool
class_name Basket extends EntityObject

onready var slot = $YSort/ItemSlot as ItemSlot

func _on_create(data):
	var stored_item = data.get("stored_item")
	var item_id = stored_item.get("item_id")
	var stored_metadata = stored_item.get("metadata")
	if !slot.get_item():
		var item = Game.spawn_item(item_id, stored_metadata)
		if item:
			slot.slot(item)
			slot.add_child(item)

func _ready():
	if slot.get_children().size() > 0:
		var item = slot.get_child(0)
		slot.slot(item)
		metadata.stored_item = {
			"item_id" : item.item_id,
			"metadata" : item.metadata
		}
		print("ITEM STORED: ", metadata["stored_item"])

func _on_item_stored(node, item):
	metadata.stored_item = {
			"item_id" : item.item_id,
			"metadata" : item.metadata
		}
	print("ITEM STORED: ", metadata["stored_item"])

func _on_item_taken(node, item):
	metadata.erase("stored_item")
