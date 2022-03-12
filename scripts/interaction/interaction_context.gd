extends Reference

class_name InteractionContext

var type : InteractionType
var interacted_by
var interacted_with
var interaction_data = {}

func _to_string():
	var string = ""
	string += str("Type: ",type.display_name,"|")
	string += str("Interacted By: ",interacted_by,"|")
	string += str("Interacted With: ",interacted_with,"|")
	string += str(interaction_data)
	return string
