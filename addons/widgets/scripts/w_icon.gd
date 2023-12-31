@tool
class_name WIcon
extends "res://addons/widgets/scripts/w_control.gd"
## Widget to hold an icon. Essentially is a [TextureRect] with
## [code]expand_mode = TextureRect.EXPAND_IGNORE_SIZE[/code] and
## [code]stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED[/code].


@export_category("TextureRect")
## Icon texture.
@export var texture: Texture2D:
	set(texture_):
		texture = texture_
		_texture.texture = texture
## If [code]true[/code], icon texture is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		_texture.flip_h = flip_h
## If [code]true[/code], icon texture is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		_texture.flip_v = flip_v

# [TextureRect] for the icon.
var _texture: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_texture = TextureRect.new()
	add_child(_texture, false, Node.INTERNAL_MODE_BACK)
	_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func _set(property: StringName, value: Variant) -> bool:
	if property == "mouse_filter":
		_texture.mouse_filter = value
		return false
	return false


func _resize_children() -> void:
	_texture.size = size
