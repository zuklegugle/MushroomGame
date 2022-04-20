extends ItemPickedUpEntity

onready var _slot = $YSort/ItemSlot

func _to_metadata():
	_slot = find_node("ItemSlot")
	var meta = ._to_metadata()
	var item = _slot.get_item()
	if item:
		meta.stored_item = item.to_metadata()
	return meta
