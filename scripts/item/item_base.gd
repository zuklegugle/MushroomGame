class_name ItemBase extends Node2D

export(String) var item_id

signal created(item)
signal destroyed(item)
signal used(item)
signal alternate_used(item)

var _item_data

var metadata = {}

func _ready():
	_item_data = ItemRegistry.get_item_data(item_id)

# public methods
func create(_data):
	_on_create(_data)
	emit_signal("created", self)
	return self

func destroy():
	_on_destroy()
	emit_signal("destroyed", self)
	queue_free()

func use(user, action_state = "started"):
	match(action_state):
		"started":
			if _on_use_started(user):
				emit_signal("used", self)
		"canceled":
			if _on_use_canceled(user):
				emit_signal("used", self)
		"performed":
			if _on_use_performed(user):
				emit_signal("used", self)

func use_alternate(user, action_state = "started"):
	match(action_state):
		"started":
			if _on_alternate_use_started(user):
				emit_signal("alternate_used", self)
		"canceled":
			if _on_alternate_use_canceled(user):
				emit_signal("alternate_used", self)
		"performed":
			if _on_alternate_use_performed(user):
				emit_signal("alternate_used", self)

# private methods
func _apply_metadata(_data):
	pass

# overrides
func _on_create(_data):
	return _data

func _on_destroy():
	pass

func _on_use_started(user) -> bool:
	return true
func _on_use_canceled(user) -> bool:
	return false
func _on_use_performed(user) -> bool:
	return false

func _on_alternate_use_started(user) -> bool:
	return true
func _on_alternate_use_canceled(user) -> bool:
	return false
func _on_alternate_use_performed(user) -> bool:
	return false
