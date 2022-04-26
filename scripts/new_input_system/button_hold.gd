extends PlayerInputAction

export(NodePath) onready var timer = get_node(timer) as Timer
export(float) var hold_time = .3
export(bool) var enabled = true

signal held_down(action)

var hold_duration = 0.0

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
func _input(event : InputEvent):
	if event.is_action(action_name):
		if event.is_action_pressed(action_name):
			if !started:
				_start()
		elif event.is_action_released(action_name):
			if !performed:
				_cancel()
			else:
				timer.stop()
				started = false
				performed = false

func _process(delta):
	if started:
		emit_signal("held_down", self)
		hold_duration += .1

func _start():
	started = true
	performed = false
	emit_signal("started", self)
	timer.start(hold_time)
	hold_duration = 0.0
	PlayerEvents.emit_signal("action_started", Game.get_current_player(), action_name)

func _cancel():
	timer.stop()
	started = false
	performed = false
	emit_signal("canceled", self)
	PlayerEvents.emit_signal("action_canceled", Game.get_current_player(), action_name)

func _on_timer_timeout():
	timer.stop()
	emit_signal("performed", self)
	performed = true
	PlayerEvents.emit_signal("action_performed", Game.get_current_player(), action_name)
