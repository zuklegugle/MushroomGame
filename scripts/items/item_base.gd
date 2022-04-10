extends Node2D

class_name ItemBase

export(Resource) var item_data

var metadata = {}

func _ready():
	_create()

func _apply_metadata(data):
	pass

func _create():
	pass

func _destroy():
	pass
