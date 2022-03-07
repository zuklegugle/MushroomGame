extends Node

class_name InteractionInterface

signal interacted(interface, trigger)

func interact(trigger):
	emit_signal("interacted", self, trigger)
	print(trigger, "triggered an interaction")
