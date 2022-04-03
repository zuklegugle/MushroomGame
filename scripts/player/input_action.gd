extends Resource

class_name InputAction

enum Phase {
	started,
	performed,
	canceled
}

enum Type {
	button,
	value,
	passtrough
}

export(String) var action_name = "Action"
export(Type) var type
export(bool) var hold
export(float) var hold_time

export(bool) var just_pressed
export(bool) var just_released
export(bool) var both

class CallbackContext:
	
	var action
	var value
	var phase
	var duration
	
	var started : bool
	var performed : bool
	var canceled : bool
	
	func _init(_action, _value, _phase):
		action = _action
		value = _value
		phase = _phase
