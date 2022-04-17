class_name ItemBase extends Node2D

export(String) var item_id

signal created(item)
signal destroyed(item)

var _item_data

var metadata = {}

func _ready():
	_item_data = ItemRegistry.get_item_data(item_id)

# callbacks
func _process(_delta):
	_on_process()

# public methods
func create(_data):
	_on_create(_data)
	emit_signal("created", self)
	return self

func destroy():
	_on_destroy()
	emit_signal("destroyed", self)
	queue_free()

# private methods
func _apply_metadata(_data):
	pass

# event hooks
func _on_process():
	pass

func _on_create(_data):
	return _data

func _on_destroy():
	pass
