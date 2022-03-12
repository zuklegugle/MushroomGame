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
var _player_interaction : PlayerInteractionRange
var _object_slot : ObjectSlot

func _ready():
	_interaction_area = get_node_or_null(_interaction_area)
	_sprite = $Sprite
	_player_interaction = $InteractionRange as PlayerInteractionRange
	_object_slot = $ObjectSlot
	
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
		if _player_interaction.has_avaible_interactions():
			_player_interaction.interact()
		
		#_object_slot.create_and_equip_from_index()
	
	if _sprite:
		if _last_input_vector.x > 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
	
func _process(delta):
	_movement_vector = _input_vector
	move_and_slide(_movement_vector * speed)


func _on_InteractionRange_interacted(callback_context : InteractionContext):
	pass
	#print(callback_context.type.r)
	#match(callback_context.type.resource_name):
	#	"Pickup":
	#		_object_slot.create_and_equip_from_scene(callback_context.interaction_data["slotable_scene"])
