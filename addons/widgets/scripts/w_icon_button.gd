@tool
class_name WIconButton
extends BaseButton
## A button based on [WIcon].


## Icon texture.
@export var icon: Texture2D:
	set(icon_):
		icon = icon_
		if _icon != null:
			_icon.icon = icon
## If [code]true[/code], icon is flipped horizontally.
@export var flip_h: bool:
	set(flip_h_):
		flip_h = flip_h_
		if _icon != null:
			_icon.flip_h = flip_h
## If [code]true[/code], icon is flipped vertically.
@export var flip_v: bool:
	set(flip_v_):
		flip_v = flip_v_
		if _icon != null:
			_icon.flip_v = flip_v

## [WIcon] for the button.
var _icon: WIcon


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _icon ####################################################################
	_icon = WIcon.new()
	add_child(_icon, false, Node.INTERNAL_MODE_BACK)
	_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_icon.icon = icon
	_icon.flip_h = flip_h
	_icon.flip_v = flip_v


func _resize_children() -> void:
	_icon.size = size
