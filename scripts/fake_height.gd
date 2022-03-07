extends Node

class_name FakeHeight

var _height : float
var _max_height : float
export(float) var _floor_point : float

func set_altitude(value : float):
	if value <= _max_height && value >= 0:
		_height = value
	elif value < 0:
		_height = 0
	elif value > _max_height:
		_height = _max_height
func get_height() -> float:
	return _height
