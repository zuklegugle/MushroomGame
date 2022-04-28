class_name PlayerInputManager extends Node

var enable_input : bool = true setget _set_enable_input

var _action_map : Dictionary

func get_actions() -> Dictionary:
	return _action_map.duplicate()

func _ready():
	_action_map = _map_actions()

func _map_actions() -> Dictionary:
	var map = {}
	var children = get_children()
	for child in children:
		var action = child as PlayerInputAction
		if action:
			var action_name = action.action_name
			map[action_name] = action
	return map.duplicate()

func _set_enable_input(value : bool):
	for action in _action_map:
		action.enabled = value
	if value:
		print("Player Input Enabled")
	else:
		print("Player Input Disabled")
