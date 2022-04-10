extends FakeHeightPhysicsBody

class_name ObjectBase

export(Resource) var object_data

var metadata : Dictionary = {}

onready var _sprite = $Sprite as Sprite
onready var _shadow = $Shadow as Sprite
onready var _entity_object = $EntityObject as EntityObject

func create():
	pass

func destroy():
	queue_free()

func _apply_metadata(data):
	if data:
		metadata = data
