class_name Flags

static func has_flag(variable, flag):
	return (bool(variable & flag))

static func has_flag_multiple(variable, flags):
	return variable & flags == flags

static func set_flag(variable, flag):
	return variable|flag

static func unset_flag(variable, flag):
	return variable & ~flag
