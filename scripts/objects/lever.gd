extends Area2D

export(NodePath) var device

onready var sprite = $Sprite
onready var _device = get_node_or_null(device)

var switched : bool = false setget _set_switched

func _on_interacted(interactor, interactable, state):
	if state == Interaction.STARTED:
		self.switched = !switched

func _set_switched(value):
	switched = value
	if switched:
		sprite.frame = 1
	else:
		sprite.frame = 0
	
	if _device:
		_device.operate(switched)
