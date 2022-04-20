class_name InteractablePickup extends Interactable

export(String) var _item_id

func create_item(data = {}) -> ItemBase:
	var item = Game.spawn_item(_item_id)
	if owner.metadata:
		item.metadata = owner.metadata.duplicate()
	item.metadata.entity_id = owner.entity_id
	item.metadata.entity_metadata = owner.metadata.duplicate()
	print("ITEM METADATA: ", item.metadata)
	# TEST
	var entity_data = data.duplicate()
	entity_data.entity = owner.to_metadata()
	item.create(entity_data)
	return item

func _on_player_interaction_started(data):
	var _data = ._on_player_interaction_started(data)
	var item = create_item(data)
	if !item:
		return {
			"type": "undefined"
		}
	_data.type = "pickup"
	_data.item = item
	owner.destroy()
	return _data
