extends KinematicBody2D

export(NodePath) onready var _animation_player = get_node_or_null(_animation_player) as AnimationPlayer
export(NodePath) onready var _animation_tree = get_node(_animation_tree)

export(NodePath) var _interaction_area


export(float) var speed = 40.0

var _input_vector = Vector2.ZERO
var _last_input_vector = Vector2.ZERO
var _movement_vector = Vector2.ZERO

var _sprite : Sprite
var _direction := false

func _ready():
	_interaction_area = get_node_or_null(_interaction_area)
	_sprite = $Sprite
	
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true

func _input(event):
	var _horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var _vertical_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	_input_vector = Vector2(_horizontal_input, _vertical_input).normalized()
	
	if _input_vector != Vector2.ZERO:
		_animation_tree["parameters/conditions/isRunning"] = true
		_animation_tree["parameters/conditions/isNotRunning"] = false
		#_animation_tree.get("parameters/playback").travel("Run")
		if _input_vector.x != 0.0:
			_last_input_vector.x = _input_vector.x
	else:
		_animation_tree["parameters/conditions/isNotRunning"] = true
		_animation_tree["parameters/conditions/isRunning"] = false
		#_animation_tree.get("parameters/playback").travel("Idle")
	
	if Input.is_action_just_pressed("ui_accept"):
		_animation_tree["parameters/conditions/isHoldingItem"] = !_animation_tree["parameters/conditions/isHoldingItem"]
		_animation_tree["parameters/conditions/isNotHoldingItem"] = !_animation_tree["parameters/conditions/isNotHoldingItem"]
		#if _interaction_area.has_avaible_interactions():
		#	_interaction_area.interact()
	
	if _sprite:
		if _last_input_vector.x > 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
	
func _process(delta):
	_movement_vector = _input_vector
	move_and_slide(_movement_vector * speed)