class_name Interactable extends Node

export(String) var default_interaction = "Interact"

signal interacted(node)

var _hint = "Interact"

var avaible_interactions = {
	"Interact" : funcref(self, "_on_interact")
}
func _ready():
	print(avaible_interactions)

func interact(_node, interaction, interaction_data) -> Node:
	print("interacted with interactable")
	emit_signal("interacted", _node)
	if interaction != "":
		var data = avaible_interactions[interaction].call_func(_node, interaction_data)
		var context = InteractionContext.new(interaction, _node, self, data)
		print(context.data)
		return context
	else:
		var data = avaible_interactions[default_interaction].call_func(_node, interaction_data)
		var context = InteractionContext.new(default_interaction, _node, self, data)
		print(context.data)
		return context

func get_hint() -> String:
	return avaible_interactions[default_interaction]

func _add_interaction(name : String, method : FuncRef):
	if !avaible_interactions.has(name):
		avaible_interactions[name] = method
	
func _on_interact(_node, _interaction_data):
	print("called Interact function")
	return _node
