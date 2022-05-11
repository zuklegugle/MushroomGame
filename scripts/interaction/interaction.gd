class_name Interaction

enum {
	UNDEFINED,
	STARTED,
	CANCELED,
	PERFORMED
}

enum ContextFlags {
	HAS_INVENTORY = 1,
	HOLDING_ITEM = 2
}

var interacted_by # interacted by
var interacted_with # interacted with
var state := UNDEFINED
var flags = 0

func _init(_interacted_by, _interacted_with, _state = UNDEFINED):
	interacted_by = _interacted_by
	interacted_with = _interacted_with
	state = _state
