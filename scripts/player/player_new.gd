class_name PlayerEntity extends Entity

export(float) var speed = 200.0

onready var _animation_player = $AnimationPlayer as AnimationPlayer
onready var _animation_tree = $AnimationTree as AnimationTree
onready var _rendering = $Smoothing2D/Rendering
onready var _interactor = $Interactor
onready var _drop_position = $DropPosition
onready var _entity_slot = $Smoothing2D/EntitySlot as EntitySlot

enum Direction {
	NORTH = -1,
	SOUTH = 1,
	WEST = 1,
	EAST = -1
}

var _input_vector = Vector2.ZERO
var _last_input_vector = Vector2.ZERO
var _movement_vector = Vector2.ZERO

var _facing = Direction.EAST
var _direction = 1
var _slot
var _cooldown_timer : Timer

var can_perform_actions = true

var holding_item := false

func _ready():
	_slot = $Smoothing2D/EntitySlot
	_cooldown_timer = $ActionCooldown
	
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true
	
	var input_manager = Player.input_manager
	var actions = input_manager.get_actions()
	print(actions)
	for action in actions:
		print("action detected", action)
		actions[action].connect("started", self, "_on_action_started")
		actions[action].connect("canceled", self, "_on_action_canceled")
		actions[action].connect("performed", self, "_on_action_performed")
		actions[action].connect("held_down", self, "_on_action_held_down")

func _input(event):
	var _horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var _vertical_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	_input_vector = Vector2(_horizontal_input, _vertical_input).normalized()
	
	if _input_vector != Vector2.ZERO:
		_animation_tree["parameters/conditions/isRunning"] = true
		_animation_tree["parameters/conditions/isNotRunning"] = false
		if _input_vector.x != 0.0:
			_last_input_vector.x = _input_vector.x
	else:
		_animation_tree["parameters/conditions/isNotRunning"] = true
		_animation_tree["parameters/conditions/isRunning"] = false
	
	if _last_input_vector.x > 0:
		_rendering.flipped = true
		_direction = Direction.EAST
	else:
		_rendering.flipped = false
		_direction = Direction.WEST
	
func _process(delta):
	_movement_vector = _input_vector

func _physics_process(delta):
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


func _action_cooldown_start():
	can_perform_actions = false
	_cooldown_timer.start()

func _on_ActionCooldown_timeout():
	_cooldown_timer.stop()
	can_perform_actions = true
	print("cooldown off")

func interact(state):
	var interactable = _interactor.interact(state) as Interactable
	if interactable:
		var interaction = Interaction.new(self, interactable.target, state)
		PlayerEvents.emit_signal("interacted", interaction)

func item_use(action_state : String = "started"):
	var item = _slot.get_item() as ItemBase
	if item:
		item.use(self, action_state)

func item_alternate_use(action_state : String = "started"):
	var item = _slot.get_item() as ItemBase
	if item:
		item.use_alternate(self, action_state)

func drop_entity():
	var entity_in_slot = _entity_slot.get_entity() as Entity
	if entity_in_slot:
		var pickup = Pickup.find(entity_in_slot)

func pickup_entity(entity : Entity):
	if entity:
		_entity_slot.add_entity(entity)

func _on_action_performed(action : PlayerInputAction):
	if can_perform_actions:
		match(action.action_name):
			"interact":
				interact(Interaction.PERFORMED)
			"use":
				item_use("performed")
			"use_alternate":
				item_alternate_use("performed")
			"drop":
				drop_entity()

func _on_action_canceled(action : PlayerInputAction):
	if can_perform_actions:
		match(action.action_name):
			"interact":
				interact(Interaction.CANCELED)
			"use":
				item_use("canceled")
			"use_alternate":
				item_alternate_use("performed")

func _on_action_held_down(action : PlayerInputAction):
	match(action.action_name):
			"use":
				print("holding use")
			"use_alternate":
				print("holding alternate use")

func _on_action_started(action : PlayerInputAction):
	if can_perform_actions:
		match(action.action_name):
			"interact":
				interact(Interaction.STARTED)
			"use":
				item_use("started")
			"use_alternate":
				item_alternate_use("performed")


func _on_slot_entity_added(slot, entity):
	holding_item = true
	_animation_tree["parameters/conditions/isHoldingItem"] = true
	_animation_tree["parameters/conditions/isNotHoldingItem"] = false


func _on_slot_entity_removed(slot, entity):
	holding_item = false
	_animation_tree["parameters/conditions/isHoldingItem"] = false
	_animation_tree["parameters/conditions/isNotHoldingItem"] = true
