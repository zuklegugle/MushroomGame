extends VBoxContainer

class_name UIInteractionPopup

export(Resource) var _player_interaction_data

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
		visible = true
	else:
		visible = false
