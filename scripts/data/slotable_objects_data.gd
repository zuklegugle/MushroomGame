extends Resource

class_name SlotableObjectsData

export(Array, PackedScene) var _slotable_objects : Array

func get_slotable_index(object : PackedScene):
	return _slotable_objects.find(object)

func get_object(index : int):
	if index >= 0 && index < _slotable_objects.size():
		return _slotable_objects[index]
	else:
		print("invalid index")
		return null

func get_avaible_objects():
	return _slotable_objects
