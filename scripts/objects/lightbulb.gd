extends Node2D

var state
onready var animation_player = $AnimationPlayer

func operate(value):
	state = value
	if state:
		animation_player.play("flicker")
	else:
		animation_player.play("off")
