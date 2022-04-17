class_name ItemPickedUpEntity extends ItemBase

var entity_id : String
var entity_metadata : Dictionary

func drop():
	var entity = Game.spawn_entity(entity_id, global_position, entity_metadata)
	destroy()

func _ready():
	PlayerEvents.connect("action_performed", self, "_on_item_drop")

func _on_create(_data):
	var id = _data.get("entity_id")
	var meta = _data.get("entity_metadata")
	
	if !meta:
		meta = {}
	
	entity_id = id
	entity_metadata = meta.duplicate()
	print("PICKED UP ENTITY: ",{
		"entity_id": entity_id,
		"entity_metadata": entity_metadata
	})
	
func _on_item_drop(player, action_name):
	match(action_name):
		"attack":
			print("ITEM SHOULD BE DROPPED NOW")
			drop()
			destroy()
