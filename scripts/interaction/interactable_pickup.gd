class_name InteractablePickup extends Interactable

export(Resource) var _item_data

func _init():
	_add_interaction("Pickup", funcref(self, "_on_pickup"))

func create_item() -> ItemBase:
	if _item_data:
		var item = Game.spawn_item(_item_data)
		return item
	else:
		return null

func _on_pickup(_node):
	var data = {
		"item" : create_item()
	}
	return data

func pickup() -> ItemBase:
	return create_item()
