@tool
class_name WIcon
extends Control
## A widget to hold an icon. Essentially is a [TextureRect] with
## [code]expand_mode = TextureRect.EXPAND_IGNORE_SIZE[/code] and
## [code]stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED[/code].


## Icon texture.
@export var icon: Texture2D:
	set(icon_):
		icon = icon_
		_texture_rect_icon.texture = icon
## If [code]true[/code], icon is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		_texture_rect_icon.flip_h = flip_h
## If [code]true[/code], icon is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		_texture_rect_icon.flip_v = flip_v

# [TextureRect] for the icon.
var _texture_rect_icon: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_texture_rect_icon = TextureRect.new()
	add_child(_texture_rect_icon, false, Node.INTERNAL_MODE_BACK)
	_texture_rect_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture_rect_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func _resize() -> void:
	_texture_rect_icon.size = size
