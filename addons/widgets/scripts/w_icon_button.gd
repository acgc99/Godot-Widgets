@tool
class_name WIconButton
extends BaseButton
## Button that consists of an icon.


## Icon texture.
@export var icon: Texture2D:
	set(icon_):
		icon = icon_
		if texture_rect_icon != null:
			texture_rect_icon.texture = icon
## If [code]true[/code], texture is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		if texture_rect_icon != null:
			texture_rect_icon.flip_h = flip_h
## If [code]true[/code], texture is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		if texture_rect_icon != null:
			texture_rect_icon.flip_v = flip_v
## [TextureRect] for the icon.
var texture_rect_icon: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# texture_rect_icon ########################################################
	texture_rect_icon = TextureRect.new()
	add_child(texture_rect_icon)
	texture_rect_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect_icon.texture = icon
	texture_rect_icon.flip_h = flip_h
	texture_rect_icon.flip_v = flip_v


# Signal callables #############################################################


func _resize_children() -> void:
	texture_rect_icon.size = size
