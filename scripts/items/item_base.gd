class_name ItemBase extends Node2D

export(String) var item_id
export(Resource) var item_data

var metadata = {}

# callbacks
func _process(_delta):
	_on_process()

# public methods
func create(_data):
	return self

func destroy(_data):
	queue_free()

# private methods
func _apply_metadata(_data):
	pass

# event hooks
func _on_process():
	pass
