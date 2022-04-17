extends ItemSlot

class_name HeldItemSlot

export(NodePath) onready var _drop_position = get_node_or_null(_drop_position)

func equip(item : ItemBase):
	add_child(item)
	slot(item)

func unequip():
	return unslot()
