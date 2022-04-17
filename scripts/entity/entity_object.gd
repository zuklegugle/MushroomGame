class_name EntityObject extends EntityBase

# exports
export(NodePath) onready var _fake_height = get_node_or_null(_fake_height) as FakeHeight

export(float) var _mass := 1.0
export(Vector3) var _gravity_strength := Vector3(0.0, 1000.0, 0.0)
export(float) var _horizontal_bounce := .8
export(float) var _vertical_bounce := .5
export(float) var _bounce_threshold := 400

#signals
signal hit_ground
signal left_ground
signal grounded

# public properties

#private properties
var _target_node : Node2D
var _physics_position = Vector3.ZERO
var _velocity = Vector3.ZERO;
var _is_grounded := false

#callbacks
func _ready():
	_fake_height.floor_point = position.y
	_physics_position = Vector3(position.x, 0.0 , position.y)
	_velocity = Vector3.ZERO

func _process(delta):
	var gravity_force = ( _gravity_strength / _mass )
	
	_velocity += gravity_force * delta;
	_physics_position += _velocity * delta;
	
	if _physics_position.y > 0:
		var _last_velocity = _velocity
		
		if !_is_grounded:
			_is_grounded = true
			emit_signal("hit_ground")
			if _last_velocity.y < _bounce_threshold:
				emit_signal("grounded")
		_velocity = Vector3(0.0, 0.0, 0.0)
		_physics_position.y = 0
		_fake_height.floor_point = position.y
		
		if _last_velocity.y > _bounce_threshold:
			_velocity += _get_bounce_vector(_last_velocity, _horizontal_bounce, _vertical_bounce, _mass)
			_last_velocity = Vector3.ZERO
	else:
		if _is_grounded:
			_is_grounded = false
			emit_signal("left_ground")
	
	_fake_height.height = -_physics_position.y
	move_and_slide(Vector2(_velocity.x, _velocity.z))

# public methods
func apply_force(vector : Vector3):
	_velocity += (vector / _mass)

func is_grounded():
	return _is_grounded

# private methods
func _update_target_position():
	_target_node.position.y = -_fake_height.height

func _get_bounce_vector(_vel : Vector3, _horizontal_b : float, _vertical_b : float, _body_mass : float) -> Vector3:
	var _bounce_vector = (Vector3(_vel.x * _horizontal_b,-(_vel.y * _vertical_b), _vel.z * _horizontal_b) / _body_mass)
	return _bounce_vector
