extends Node2D

class_name SlottedEntity

func on_drop():
	print("entity dropped")
	queue_free()
