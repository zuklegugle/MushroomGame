extends Node

class_name PlayerInput

export(Dictionary) var input_map

signal action_use(context)

onready var timer = Timer.new()

func _ready():
	add_child(timer)
	#timer.connect("timeout",self,"_on_timer_timeout")

func _input(event):
	for input in input_map:
		var action = input_map[input] as InputAction
		if event.is_action_pressed(input):
			if action.hold:
				print("started holding ",input)
				if !timer.is_connected("timeout",self,"_on_timer_timeout"):
					timer.connect("timeout",self,"_on_timer_timeout", [action])
				timer.start(.5)
				var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.started) as InputAction.CallbackContext
				context.started = true
				emit_signal("action_use", context)
			else:
				if action.just_pressed or action.both:
					print("pressed ",input)
					var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.performed) as InputAction.CallbackContext
					context.performed = true
					emit_signal("action_use", context)
		if event.is_action_released(input):
			if action.hold:
				if !timer.is_stopped():
					print("canceled ", input)
					var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.canceled) as InputAction.CallbackContext
					context.canceled = true
					emit_signal("action_use", context)
			else:
				print("released ", input)
			timer.stop()

func _on_timer_timeout(action):
	print("performed ",action.action_name)
	var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.performed) as InputAction.CallbackContext
	context.performed = true
	emit_signal("action_use", context)
	timer.stop()
	timer.disconnect("timeout",self,"_on_timer_timeout")


#func _process(delta):
#	for input in input_map:
#		var action = input_map[input] as InputAction
#		if Input.is_action_just_pressed(input):
#			if action.hold:
#				var duration = 0.0
#				if Input.is_action_pressed(input):
#					print("holding ", input)
#					var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.started) as InputAction.CallbackContext
#					context.started = true
#					emit_signal("action_use", context)
#					yield(get_tree().create_timer(action.hold_time), "timeout")
#					if !Input.is_action_pressed(input):
#						return
#					context = InputAction.CallbackContext.new(action, null, InputAction.Phase.performed) as InputAction.CallbackContext
#					context.performed = true
#					context.duration = duration
#					emit_signal("action_use", context)
#					print("hold performed")
#			else:
#				if action.just_pressed or action.both:
#					var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.performed) as InputAction.CallbackContext
#					context.performed = true
#					emit_signal("action_use", context)
#					print("press performed")
#		if Input.is_action_just_released(input):
#			if action.hold:
#				var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.canceled) as InputAction.CallbackContext
#				context.canceled = true
#				emit_signal("action_use", context)
#				print("hold canceled")
#			else:
#				if action.just_released or action.both:
#					var context = InputAction.CallbackContext.new(action, null, InputAction.Phase.performed) as InputAction.CallbackContext
#					context.performed = true
#					emit_signal("action_use", context)
#					print("release performed")

func hold_action(action, time):
	var canceled = false
	if !Input.is_action_just_pressed(action):
		return
	if Input.is_action_just_released(action):
		canceled = true
	yield(get_tree().create_timer(time), "timeout")
	if !Input.is_action_pressed(action) or canceled:
		return
	var input_action = input_map[action]
	var context = InputAction.CallbackContext.new(input_action, null, InputAction.Phase.performed) as InputAction.CallbackContext
	context.performed = true
	emit_signal("action_use", context)
	print("hold performed")
