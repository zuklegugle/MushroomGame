class_name InteractablePickup extends Interactable

export(String) var _item_id

func create_item() -> ItemBase:
	var item = Game.spawn_item(_item_id)
	if owner.metadata:
		item.metadata = owner.metadata.duplicate()
	return item

func _on_player_interaction_started(data):
	var _data = ._on_player_interaction_started(data)
	var item = create_item()
	if !item:
		return {
			"type": "undefined"
		}
	_data.type = "pickup"
	_data.item = item
	print("OBJECT PICKUP: ", _data)
	owner.queue_free()
	return _data
