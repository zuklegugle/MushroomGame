extends VBoxContainer

class_name UIInteractionPopup

export(Resource) var _player_interaction_data

onready var label = $Label as Label

func _ready():
	_player_interaction_data = _player_interaction_data as PlayerInteractionData
	if _player_interaction_data:
		_player_interaction_data.connect("data_changed", self, "_on_data_changed")

func _exit_tree():
	if _player_interaction_data:
		if _player_interaction_data.is_connected("data_changed", self, "_on_data_changed"):
			_player_interaction_data.disconnect("data_changed", self, "_on_data_changed")

func _on_data_changed():
	var _data = _player_interaction_data as PlayerInteractionData
	if _data.has_avaible_interactions():
		var closest_interaction_entry = null
		var closest_interaction_index = _data.get_closest_interaction_index()
		if closest_interaction_index != -1:
			visible = true
			closest_interaction_entry = _data._avaible_interactions[closest_interaction_index] as PlayerInteractionData.PlayerInteractionDataEntry
			label.text =  str("Press 'Use' to ", closest_interaction_entry.type.display_name)
		else:
			visible = false
	else:
			visible = false
