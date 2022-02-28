extends Node2D

export(NodePath) onready var kinematic_body = get_node(kinematic_body)
export(NodePath) onready var animation_tree = get_node(animation_tree)

export(float) var speed = 40.0

var _input_vector = Vector2.ZERO
var _movement_vector = Vector2.ZERO

func _ready():
	pass

func _input(event):
	var _horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var _vertical_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	_input_vector = Vector2(_horizontal_input, _vertical_input).normalized()
	
	animation_tree.set("parameters/Run/blend_position", _input_vector)
	
	if _input_vector != Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Run")
	else:
		animation_tree.get("parameters/playback").travel("Idle")
	
func _physics_process(delta):
	_movement_vector = _input_vector
	kinematic_body.move_and_slide(_movement_vector * speed)
