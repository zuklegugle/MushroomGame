class_name Pickup extends Node

export(NodePath) var target

signal picked_up
signal dropped

onready var _target = get_node_or_null(target)

var _slot : EntitySlot

# callbacks
func _ready():
	add_to_group("Pickup", true)
	if !_target:
		target = owner

#public methods
func pickup(slot : EntitySlot):
	if slot:
		if slot.add(target):
			emit_signal("picked_up")

func drop(position : Vector2):
	if _slot:
		if _slot.get_entity() == target:
			var level = Game.get_current_level() as Level
			NodeUtils.reparent_node(target, level.spawn_root)
			target.global_position = position
