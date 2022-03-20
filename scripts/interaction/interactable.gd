extends Node

class_name Interactable

signal interacted

func interact():
	print("interacted with interactable")
	emit_signal("interacted")
