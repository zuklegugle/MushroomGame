extends KinematicBody2D

export(NodePath) onready var animation_tree = get_node(animation_tree)
export(NodePath) onready var interaction_area = get_node_or_null(interaction_area)

export(float) var speed = 40.0

var _input_vector = Vector2.ZERO
var _movement_vector = Vector2.ZERO

var _sprite : Sprite

func _ready():
	_sprite = $Sprite

func _input(event):
	var _horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var _vertical_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	_input_vector = Vector2(_horizontal_input, _vertical_input).normalized()
	
	animation_tree.set("parameters/Run/blend_position", _input_vector)
	
	if _input_vector != Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Run")
	else:
		animation_tree.get("parameters/playback").travel("Idle")

	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if interaction_area.has_avaible_interactions():
			interaction_area.interact()
	
	_movement_vector = _input_vector
	move_and_slide(_movement_vector * speed)
