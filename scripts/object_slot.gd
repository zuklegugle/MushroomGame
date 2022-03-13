extends Position2D

class_name ObjectSlot

export(Resource) var _slotable_objects

signal object_sloted
signal object_unsloted

var _sloted_object : SlotableObject

func _ready():
	print(_slotable_objects.get_avaible_objects())

func create_and_equip_from_index(index := 0):
	var objects = _slotable_objects.get_avaible_objects() as Array
	if objects.size() > 0:
		var new_object = objects[index].instance()
		add_child(new_object)
		_sloted_object = new_object

func create_and_equip_from_scene(scene):
	var objects = _slotable_objects.get_avaible_objects() as Array
	if objects.find(scene) != -1:
		var new_object = scene.instance()
		add_child(new_object)
		_sloted_object = new_object
		_sloted_object.slot = self

func unequip():
	_sloted_object = null
	emit_signal("object_unsloted")
	print("item removed from slot")

func add_child(node, legible_unique_name=false):
	.add_child(node)
	emit_signal("object_sloted")
	print("item added to slot")
	
func remove_child(node):
	.remove_child(node)
	emit_signal("object_unsloted")
	print("item removed from slot")
