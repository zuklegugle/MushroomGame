class_name ItemPickedUpEntity extends ItemBase

signal dropped(item, node)

# public methods
func drop(position : Vector2):
	var entity = Game.spawn_entity(metadata.entity_id, position, metadata.entity_metadata)
	print("DEBUD:", entity.metadata)
	emit_signal("dropped", self, entity)

# callbacks
func _ready():
	connect("dropped", self, "_on_dropped")

# private methods
# overrides

# signal callbacks
func _on_dropped(item, node):
	destroy()

func _on_use_started(user):
	var entity = Game.spawn_entity(metadata.entity_id, user.global_position, metadata.entity_metadata)
	print(entity)
	if entity:
		entity._physics_position = Vector3(user.global_position.x, (global_position.y - user.global_position.y), user.global_position.y)
		entity.apply_force(Vector3(500 * user._direction,-400,0))
		destroy()
		return true
	return false
