class_name ItemPickedUpEntity extends ItemBase

signal dropped(item, node)

var entity_data = {}

# public methods
func drop(position : Vector2):
	var entity = Game.spawn_entity(metadata.entity_id, position)
	emit_signal("dropped", self, entity)

# callbacks
func _ready():
	connect("dropped", self, "_on_dropped")

# private methods
# overrides
func _on_create(data = {}):
	var entity = data.get("entity")
	entity_data = entity.duplicate()
	return data
	
func _to_metadata():
	var meta = ._to_metadata()
	meta.entity = entity_data.duplicate()
	return meta

# signal callbacks
func _on_dropped(item, node):
	destroy()

func _on_use_started(user):
	var entity = Game.spawn_entity(metadata.entity_id, user.global_position)
	print(entity)
	if entity:
		entity._physics_position = Vector3(user.global_position.x, (global_position.y - user.global_position.y), user.global_position.y)
		entity.apply_force(Vector3(500 * user._direction,-400,0))
		destroy()
		return true
	return false
