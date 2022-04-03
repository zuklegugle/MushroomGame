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
var _direction := false
var _interactor : Interactor
var _slot : HeldItemSlot
var _drop_position

var holding_item := false

func _ready():
	_interaction_area = get_node_or_null(_interaction_area)
	_sprite = $Sprite
	_interactor = $Interactor
	_slot = $HeldItemSlot
	_drop_position = $DropPosition
	#_player_interaction = $InteractionRange as PlayerInteractionRange
	#_object_slot = $ObjectSlot
	
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
		#if _equipped_object:
		#	unequip()
#		if _slot.slotted_entity:
#			_slot.drop()
		if !_interactor.has_avaible_interaction():
			_slot.unequip()
		else:
			_interactor.interact()
		
		#_object_slot.create_and_equip_from_index()
	
	if _sprite:
		if _last_input_vector.x > 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
	
func _process(delta):
	_movement_vector = _input_vector
	move_and_slide(_movement_vector * speed)

	#print(callback_context.type.r)
	#match(callback_context.type.resource_name):
	#	"Pickup":
	#		_object_slot.create_and_equip_from_scene(callback_context.interaction_data["slotable_scene"])


#func equip_object(object):
#	if object.is_in_group("Interactable"):
#		var interactable : Interactable
#		var slotted_object : SlottedEntityObject
#		for child in object.get_children():
#			if child is Interactable:
#				interactable = child as Interactable
#				break
#		if interactable:
#			for behaviour in interactable.get_behaviours():
#				if behaviour is InteractableBehaviourPickup:
#					slotted_object = behaviour.create_slottable_object(interactable.target)
#					_equipped_object = Game.deactivate(interactable.target)
#					var slotted_entity = _slot.slot(slotted_object)
#					print("entity slotted", slotted_entity)
#				if behaviour is InteractableBehaviourContainer:
#					if slotted_object:
#						if slotted_object is SlottedEntityObjectContainer:
#							var scene = behaviour.container.stored_entity
#							if scene:
#								slotted_object.populate_slot( load(scene.filename) )
#
#func unequip():
#	if _equipped_object:
#		var slotted_entity = _slot.unslot()
#		if _drop_position:
#			Game.reactivate(_equipped_object)
#			_equipped_object.global_position = _drop_position.global_position
#			_equipped_object = null
#			#Game.spawn_scene(_drop_position.global_position, entity.dropped_scene)
#		else:
#			Game.reactivate(_equipped_object)
#			_equipped_object.global_position = global_position
#			_equipped_object = null
#			#Game.spawn_scene(global_position, entity.dropped_scene)
#		slotted_entity.on_drop()
#
#
func _on_interacted(interactor, node):
	pass
#	equip_object(node.target)


func _on_HeldItemSlot_item_slotted(item):
	_animation_tree["parameters/conditions/isHoldingItem"] = true
	_animation_tree["parameters/conditions/isNotHoldingItem"] = false
	holding_item = true


func _on_HeldItemSlot_item_unslotted(item):
	holding_item = false
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true
