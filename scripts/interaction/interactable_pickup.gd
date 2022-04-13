class_name InteractablePickup extends Interactable

export(Resource) var _item_data

func create_item() -> ItemBase:
	if _item_data:
		var item = Game.spawn_item(_item_data)
		if owner.metadata:
			item.metadata = owner.metadata
		return item
	else:
		return null

func _on_player_interaction_started(data):
	var _data = ._on_player_interaction_started(data)
	_data.type = "pickup"
	_data.item = create_item()
	_data.metadata = owner.metadata
	print("OBJECT PICKUP: ", _data)
	owner.queue_free()
	return _data

func _on_pickup(_node, _interaction_data):
	var data = {
		"item" : create_item(),
		"metadata" : owner.metadata
	}
	print("OBJECT PICKUP: ", data)
	return data

func pickup() -> ItemBase:
	return create_item()
