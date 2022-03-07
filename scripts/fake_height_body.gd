extends Area2D

class_name FakeHeightBody

export(NodePath) onready var _fake_height = get_node_or_null(_fake_height)
export(NodePath) onready var _sprite = get_node_or_null(_sprite)

export(float) var _mass := 1.0
export(Vector3) var _gravity_strength := Vector3(0.0, 1000.0, 0.0)
export(float) var horizontal_bounce := .8
export(float) var vertical_bounce := .5

var _physics_position = Vector3.ZERO
var _velocity = Vector3.ZERO;

var _grounded := false

func _ready():
	_fake_height._height = 0
	_fake_height._floor_point = position.y
	_physics_position = Vector3(position.x, 0.0 , position.y)
	self.connect("body_entered",self,"_on_body_entered")
func _process(delta):
	var gravity_force = ( _gravity_strength / _mass )
	
	
	_velocity += gravity_force * delta;
	_physics_position += _velocity * delta;
	
	if _physics_position.y >= _fake_height._floor_point:
		var last_velocity = _velocity
		#_physics_position.z = _fake_height._floor_point
		_grounded = true
		_velocity = Vector3(0.0, 0.0, 0.0)
		_physics_position.y = _fake_height._floor_point
		
		if last_velocity.y > 200:
			_velocity += (Vector3(last_velocity.x * horizontal_bounce,-(last_velocity.y * vertical_bounce), last_velocity.z * horizontal_bounce) / _mass)
			pass
	else:
		_grounded = false
	
	
	position = Vector2(_physics_position.x, _physics_position.z)
	_fake_height._height= _physics_position.y
	print(_physics_position)
	
	update_sprite(_sprite)
func _exit_tree():
	self.disconnect("body_entered",self,"_on_body_entered")

func _input(event):
	if Input.is_action_just_pressed("ui_left"):
		apply_force(Vector3(-300, -500, -60))
	if Input.is_action_just_pressed("ui_right"):
		apply_force(Vector3(300, -500, 60))
	if Input.is_action_just_pressed("ui_up"):
		apply_force(Vector3(-30, -500, -300))
	if Input.is_action_just_pressed("ui_down"):
		apply_force(Vector3(30, -500, 300))


# public methods
func apply_force(vector : Vector3):
	_velocity += (vector / _mass)
func is_grounded():
	return _grounded

#private methods
func _on_body_entered(body):
	if body is StaticBody2D:
		_velocity = Vector2(0.0, _velocity.y)


func update_sprite(sprite: Sprite):
	sprite.offset.y = _physics_position.y - _fake_height._floor_point
