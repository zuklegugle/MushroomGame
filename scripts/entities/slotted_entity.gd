extends Node2D

class_name SlottedEntity

var _slot

func on_slot(slot):
	_slot = slot

func on_unslot():
	_slot = null

func on_drop():
	print("entity dropped")
	_slot = null
	queue_free()
