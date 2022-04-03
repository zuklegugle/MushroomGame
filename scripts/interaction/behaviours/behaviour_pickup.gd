extends InteractableBehaviour

class_name InteractableBehaviourPickup

export(NodePath) onready var slotable = get_node_or_null(slotable) as Slotable

func interact(interactable, node):
	return node

func pickup():
	print("picked up")

func drop():
	print("dropped")

func create_slottable_object(object):
	var new_slottable_object = slotable.slotted_scene.instance() as SlottedEntityObject
	new_slottable_object.on_create_from_entity(object)
	return new_slottable_object
