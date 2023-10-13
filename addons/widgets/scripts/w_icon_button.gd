@tool
class_name WIconButton
extends BaseButton
## Button that consists of an icon.


## Icon texture.
@export var icon: Texture2D:
	set(icon_):
		icon = icon_
		if _texture_rect_icon != null:
			_texture_rect_icon.texture = icon
## If [code]true[/code], texture is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		if _texture_rect_icon != null:
			_texture_rect_icon.flip_h = flip_h
## If [code]true[/code], texture is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		if _texture_rect_icon != null:
			_texture_rect_icon.flip_v = flip_v
## [TextureRect] for the icon.
var _texture_rect_icon: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _texture_rect_icon #######################################################
	_texture_rect_icon = TextureRect.new()
	add_child(_texture_rect_icon, false, Node.INTERNAL_MODE_BACK)
	_texture_rect_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_texture_rect_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture_rect_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_texture_rect_icon.texture = icon
	_texture_rect_icon.flip_h = flip_h
	_texture_rect_icon.flip_v = flip_v


func _resize_children() -> void:
	_texture_rect_icon.size = size
