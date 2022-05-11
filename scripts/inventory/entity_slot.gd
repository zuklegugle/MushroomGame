class_name EntitySlot extends Position2D

signal entity_added(slot, entity)
signal entity_removed(slot, entity)

var occupied : bool = false

var _entity : Entity

func add_entity(entity : Entity) -> bool:
	if !_entity:
		if entity:
			_entity = entity
			NodeUtils.reparent_node(entity, self)
			emit_signal("entity_added", self, entity)
			occupied = true
			return true
		else:
			return false
	else:
		return false

func remove_entity() -> Entity:
	if _entity:
		var entity = _entity
		remove_child(_entity)
		_entity = null
		emit_signal("entity_removed", self, entity)
		occupied = false
		return entity
	else:
		return null

func get_entity() -> Entity:
	return _entity

func remove_and_drop(position : Vector2) -> Entity:
	if _entity:
		var level = Game.get_current_level() as Level
		NodeUtils.reparent_node(_entity, level.spawn_root)
		_entity.global_position = position
		_entity = null
		occupied = false
		return _entity
	else:
		return null
