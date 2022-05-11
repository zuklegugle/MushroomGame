class_name NodeUtils extends Node

static func reparent_node(node, new_parent, match_position : bool = true):
	var parent = node.get_parent()
	if parent:
		node.get_parent().remove_child(node)
	new_parent.add_child(node)
	if match_position:
		node.global_position = new_parent.global_position
