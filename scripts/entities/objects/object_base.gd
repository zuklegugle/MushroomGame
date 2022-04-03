extends FakeHeightPhysicsBody

class_name ObjectBase

export(Resource) var object_data

onready var _sprite = $Sprite as Sprite
onready var _shadow = $Shadow as Sprite
onready var _entity_object = $EntityObject as EntityObject

func destroy():
	queue_free()
