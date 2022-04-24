tool
class_name EntityObject extends EntityBase

# exports
onready var _fake_height = $FakeHeight
var _body_mass := 1.0
var _body_gravity_strength := Vector3(0.0, 1000.0, 0.0)
var _body_horizontal_bounce := .8
var _body_vertical_bounce := .5
var _body_bounce_threshold := 400

#signals
signal hit_ground
signal left_ground
signal grounded

func _get_property_list() -> Array:
	return [{
			name = "FakeHeightPhysicsBody",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY 
		},{
			name = "Body",
			type = TYPE_NIL,
			hint_string = "_body",
			usage = PROPERTY_USAGE_GROUP
		},{
			name = "_body_mass",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		},{
			name = "_body_vertical_bounce",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		},{
			name = "_body_horizontal_bounce",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		},{
			name = "_body_bounce_threshold",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		},{
			name = "_body_gravity_strength",
			type = TYPE_VECTOR3,
			usage = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		}]

# public properties

#private properties
var _target_node : Node2D
var _physics_position = Vector3.ZERO
var _velocity = Vector3.ZERO;
var _is_grounded := false

#callbacks
func _ready():
	if Engine.editor_hint:
		return
	_fake_height.floor_point = position.y
	_physics_position = Vector3(position.x, 0.0 , position.y)
	_velocity = Vector3.ZERO

func _process(delta):
	if Engine.editor_hint:
		return
	var gravity_force = ( _body_gravity_strength / _body_mass )
	
	_velocity += gravity_force * delta;
	_physics_position += _velocity * delta;
	
	if _physics_position.y > 0:
		var _last_velocity = _velocity
		
		if !_is_grounded:
			_is_grounded = true
			emit_signal("hit_ground")
			if _last_velocity.y < _body_bounce_threshold:
				emit_signal("grounded")
		_velocity = Vector3(0.0, 0.0, 0.0)
		_physics_position.y = 0
		_fake_height.floor_point = position.y
		
		if _last_velocity.y > _body_bounce_threshold:
			_velocity += _get_bounce_vector(_last_velocity, _body_horizontal_bounce, _body_vertical_bounce, _body_mass)
			_last_velocity = Vector3.ZERO
	else:
		if _is_grounded:
			_is_grounded = false
			emit_signal("left_ground")
	
	_fake_height.height = -_physics_position.y
	move_and_slide(Vector2(_velocity.x, _velocity.z))

# public methods
func apply_force(vector : Vector3):
	_velocity += (vector / _body_mass)

func is_grounded():
	return _is_grounded

# private methods
func _update_target_position():
	_target_node.position.y = -_fake_height.height

func _get_bounce_vector(_vel : Vector3, _horizontal_b : float, _vertical_b : float, _body_mass : float) -> Vector3:
	var _bounce_vector = (Vector3(_vel.x * _horizontal_b,-(_vel.y * _vertical_b), _vel.z * _horizontal_b) / _body_mass)
	return _bounce_vector
