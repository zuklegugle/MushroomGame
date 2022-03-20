extends Node2D

class_name SlotableObject

export(NodePath) var _interaction_interface
export(Array, Resource) var avaible_interaction_types

signal sloted
signal unsloted
signal interacted(context)

var _slot
var slot setget _set_slot, _get_slot 

func _ready():
	_interaction_interface = get_node_or_null(_interaction_interface)

func get_interface() -> InteractionInterface:
	return _interaction_interface

func interact(callback_context : InteractionContext):
	var context = _on_interact(callback_context)
	var _interaction_valid : bool
	
	if _is_interaction_valid(callback_context.type):
		emit_signal("interacted", context)

func _on_interact(callback_context : InteractionContext) -> InteractionContext:
	return callback_context

func _is_interaction_valid(interaction : InteractionType) -> bool:
	var interaction_valid : bool
	if !avaible_interaction_types.empty():
		for interaction_type in avaible_interaction_types:
			if interaction_type is InteractionType:
				if interaction_type.display_name == interaction.display_name:
					interaction_valid = true
					return interaction_valid
		interaction_valid = false
	else:
		interaction_valid = false
	return interaction_valid

func _set_slot(value):
	if value:
		emit_signal("sloted")
	else:
		_slot.unequip()
		emit_signal("unsloted")
	_slot = value

func _get_slot():
	return _slot
