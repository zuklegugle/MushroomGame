class_name EntityRenderer extends Node2D

export(NodePath) var sprite
export(NodePath) var shadow
export(bool) var render_shadow = true setget _set_render_shadow

onready var _sprite = get_node_or_null(sprite) as Sprite
onready var _shadow = get_node_or_null(shadow) as Sprite

var flipped : bool setget _set_flipped

func flip():
	self.flipped = !self.flipped

func _set_flipped(value):
	flipped = value
	if _sprite:
		_sprite.flip_h = value

func _set_render_shadow(value):
	render_shadow = value
	if _shadow:
		_shadow.visible = value
