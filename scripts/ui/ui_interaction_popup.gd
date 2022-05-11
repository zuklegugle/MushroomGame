extends VBoxContainer

class_name UIInteractionPopup

export(Resource) var _interactor_data

onready var label = $Label as Label
var player

func _ready():
	_interactor_data = _interactor_data as InteractorData
	if _interactor_data:
		_interactor_data.connect("data_changed", self, "_on_data_changed")
	var player_nodes = get_tree().get_nodes_in_group("Player")
	if player_nodes:
		player = player_nodes[0]
		print("Player found: ", player)

func _exit_tree():
	if _interactor_data:
		if _interactor_data.is_connected("data_changed", self, "_on_data_changed"):
			_interactor_data.disconnect("data_changed", self, "_on_data_changed")

func _on_data_changed():
	var _data = _interactor_data as InteractorData
	var interactable = _data.get_closest_interactable() as Interactable
	var container = _data.get_closest_interactable() as PickupItemContainer
	label.text = str("Press 'Use' to ")
	if interactable != null:
		visible = true
	else:
		visible = false
