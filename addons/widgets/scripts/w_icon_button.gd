@tool
class_name WIconButton
extends "res://addons/widgets/scripts/w_base_button.gd"
## Widget button based on [WIcon].


@export_category("TextureRect")
## Icon texture.
@export var texture: Texture2D:
	set(texture_):
		texture = texture_
		_icon.texture = texture
## If [code]true[/code], icon texture is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		_icon.flip_h = flip_h
## If [code]true[/code], icon texture is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		_icon.flip_v = flip_v

# [WIcon] for the button's texture.
var _icon: WIcon


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_icon = WIcon.new()
	add_child(_icon, false, Node.INTERNAL_MODE_BACK)
	_icon.mouse_filter = MOUSE_FILTER_IGNORE


func _resize_children() -> void:
	_icon.size = size
