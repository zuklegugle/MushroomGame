extends KinematicBody2D

class_name Player

export(NodePath) onready var _animation_player = get_node_or_null(_animation_player) as AnimationPlayer
export(NodePath) onready var _animation_tree = get_node(_animation_tree)

export(NodePath) var _interaction_area


export(float) var speed = 40.0

var _input_vector = Vector2.ZERO
var _last_input_vector = Vector2.ZERO
var _movement_vector = Vector2.ZERO

var _sprite : Sprite
var _direction = 1
var _interactor : Interactor
var _slot : HeldItemSlot
var _drop_position
var _cooldown_timer : Timer

var can_perform_actions = true

var holding_item := false

func _ready():
	_interaction_area = get_node_or_null(_interaction_area)
	_sprite = $Sprite
	_interactor = $Interactor
	_slot = $HeldItemSlot
	_drop_position = $DropPosition
	_cooldown_timer = $ActionCooldown
	#_player_interaction = $InteractionRange as PlayerInteractionRange
	#_object_slot = $ObjectSlot
	
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true
	
	PlayerEvents.connect("interacted", self, "_on_interacted")

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
		#if _equipped_object:
		#	unequip()
#		if _slot.slotted_entity:
#			_slot.drop()
		if !_interactor.has_avaible_interaction():
			pass
			#slot.unequip()
		else:
			pass
			#_interactor.interact()
		
		#_object_slot.create_and_equip_from_index()
	
	if _sprite:
		if _last_input_vector.x > 0:
			_sprite.flip_h = true
			_direction = 1
		else:
			_sprite.flip_h = false
			_direction = -1
	
func _process(delta):
	_movement_vector = _input_vector
	move_and_slide(_movement_vector * speed)


func drop_object():
	if _slot.get_item():
		var object_data = _slot.unequip()
		if object_data:
			var object = Game.spawn_object(_drop_position.global_position, object_data.object)
			object._apply_metadata(object_data.metadata)
			_action_cooldown_start()

func throw():
	if _slot.get_item():
		var object_data = _slot.unequip()
		if object_data:
			var object = Game.spawn_object(Vector2(global_position.x + 40 * _direction, global_position.y), object_data.object)
			print("APPLY METADATA: ", object_data.metadata)
			object._apply_metadata(object_data.metadata)
			object._physics_position = Vector3(global_position.x, -60 , global_position.y)
			object.apply_force(Vector3(500 * _direction,-400,0))
			_action_cooldown_start()
			return true
	return false

func equip_item(item):
	if !holding_item:
		if item:
			_slot.equip(item)
			PlayerEvents.emit_signal("item_equipped", self, _slot, item)

func _on_interacted(player_data : Dictionary, context : Dictionary):
	match(context.data.interaction.type):
		"pickup":
			equip_item(context.data.interaction.item)
			_action_cooldown_start()
		"item_stored":
			_action_cooldown_start()
		"item_taken":
			equip_item(context.data.interaction.item)
			_action_cooldown_start()

func _on_HeldItemSlot_item_slotted(item):
	holding_item = true
	_animation_tree["parameters/conditions/isHoldingItem"] = true
	_animation_tree["parameters/conditions/isNotHoldingItem"] = false


func _on_HeldItemSlot_item_unslotted(item):
	holding_item = false
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true


func _action_cooldown_start():
	can_perform_actions = false
	_cooldown_timer.start()

func _on_ActionCooldown_timeout():
	_cooldown_timer.stop()
	can_perform_actions = true
	print("cooldown off")

func interact(type = "undefined", data = {}):
	var player_data = {
		"player": self,
		"type": type,
		"data": data
	}
	var context = _interactor.interact(player_data)
	PlayerEvents.emit_signal("interacted", player_data, context)

func _on_action_performed(action : PlayerInputAction):
	if can_perform_actions:
		match(action.action_name):
			"use":
				if _interactor.has_avaible_interaction():
					interact("player_interaction_finished", {
						"item": _slot.get_item()
					})

func _on_action_canceled(action : PlayerInputAction):
	if can_perform_actions:
		if action.action_name == "use":
			if _interactor.has_avaible_interaction():
				interact("player_interaction_canceled", {
					"item": _slot.get_item()
				})

func _on_action_held_down(action : PlayerInputAction):
	pass

func _on_action_started(action : PlayerInputAction):
	if can_perform_actions:
		if action.action_name == "use":
			if _interactor.has_avaible_interaction():
				interact("player_interaction_started", {
					"item": _slot.get_item()
				})
