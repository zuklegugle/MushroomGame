extends FakeHeightKinematicBody

onready var timer = $Timer

var direction := 1

func _on_timer_timeout():
	direction = -direction
	apply_force(Vector3(300 * direction, -500, 0.0))
	timer.start(3.0)
