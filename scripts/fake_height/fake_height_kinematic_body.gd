extends KinematicBody2D
tool
class_name FakeHeightKinematicBody

enum Mode {
	FakePhysics,
	Kinematic
}

var _floor_point : float

# exports
export(NodePath) var _target_path setget _set_target_path
export(Mode) var _mode := 0
export(float) var _max_height := 1000.0
export (float) var _height : float setget _set_height
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
var _target_reference : Node2D
var _physics_position = Vector3.ZERO
var _velocity = Vector3.ZERO;
var _is_grounded := false

#callbacks
func _ready():
	_floor_point = position.y
	_physics_position = Vector3(position.x, 0.0 , position.y)
	_velocity = Vector3.ZERO
	_target_node = get_node_or_null(self._target_path)

func _process(delta):
	if Engine.editor_hint:
		if _target_node:
			_update_target_position()
	
	if not Engine.editor_hint:
		if _mode == Mode.Kinematic:
			_update_target_position()
			move_and_slide(Vector2(_velocity.x, _velocity.z))
			return
			
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
			_floor_point = position.y
			
			if _last_velocity.y > _bounce_threshold:
				_velocity += _get_bounce_vector(_last_velocity, _horizontal_bounce, _vertical_bounce, _mass)
				_last_velocity = Vector3.ZERO
		else:
			if _is_grounded:
				_is_grounded = false
				emit_signal("left_ground")
		
		_height = -_physics_position.y
		_update_target_position()
		move_and_slide(Vector2(_velocity.x, _velocity.z))

# public methods
func apply_force(vector : Vector3):
	_velocity += (vector / _mass)

func is_grounded():
	return _is_grounded

# private methods
func _update_target_position():
	_target_node.position.y = -_height

func _get_bounce_vector(_velocity : Vector3, _horizontal_bounce : float, _vertical_bounce : float, _body_mass : float) -> Vector3:
	var _bounce_vector = (Vector3(_velocity.x * _horizontal_bounce,-(_velocity.y * _vertical_bounce), _velocity.z * _horizontal_bounce) / _body_mass)
	return _bounce_vector

# getters / setters
func _set_height(value : float):
	if value <= _max_height && value >= 0:
		_height = value
	elif value < 0:
		_height = 0
	elif value > _max_height:
		_height = _max_height

func _set_target_path(value):
	_target_path = value
	if Engine.editor_hint:
		_target_path = value
