extends Interactable

class_name Pickup

export(Resource) var _item_data

func get_hint() -> String:
	return "Pickup"

func create_item() -> ItemBase:
	if _item_data:
		var item = Game.spawn_item(_item_data)
		return item
	else:
		return null

func pickup() -> ItemBase:
	return create_item()
