@tool
class_name WIconLabelIcon
extends "res://addons/widgets/scripts/w_control.gd"
## Widget with two [WIcon] and a [Label] in the middle.


## Enum corresponding to [param alignment].
enum {
	ALIGNMENT_LEFT,
	ALIGNMENT_CENTER,
	ALIGNMENT_RIGHT
}

## The text to display between the icons.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
		_set_custom_minimum_size(get_combined_minimum_size())
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Controls the text's horizontal alignment. Supports left, center and right.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		if alignment == ALIGNMENT_LEFT:
			_container_ili.size_flags_horizontal = SIZE_SHRINK_BEGIN
		elif alignment == ALIGNMENT_CENTER:
			_container_ili.size_flags_horizontal = SIZE_SHRINK_CENTER
		else:
			_container_ili.size_flags_horizontal = SIZE_SHRINK_END
@export_group("Left Icon", "left")
## Left icon texture.
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_icon_left.texture = left_texture
		_set_icon_left_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], left icon texture is flipped horizontally.
@export var left_flip_h: bool:
	set(left_flip_h_):
		left_flip_h = left_flip_h_
		_icon_left.flip_h = left_flip_h
## If [code]true[/code], left icon texture is flipped vertically.
@export var left_flip_v: bool:
	set(left_flip_v_):
		left_flip_v = left_flip_v_
		_icon_left.flip_v = left_flip_v
@export_group("Right Icon", "right")
## Right icon texture.
@export var right_texture: Texture2D:
	set(right_texture_):
		right_texture = right_texture_
		_icon_right.texture = right_texture
		_set_icon_right_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], right icon texture is flipped horizontally.
@export var right_flip_h: bool:
	set(right_flip_h):
		right_flip_h = right_flip_h
		_icon_right.flip_h = right_flip_h
## If [code]true[/code], right icon texture is flipped vertically.
@export var right_flip_v: bool:
	set(right_flip_v_):
		right_flip_v_ = right_flip_v_
		_icon_right.flip_v = right_flip_v
@export_group("Theme Type Variation", "ttv")
## [param theme_type_variation] of background panel.
## Base type: [PanelContainer].
@export var ttv_background: String:
	set(ttv_background_):
		ttv_background = ttv_background_
		_container_panel.theme_type_variation = ttv_background
## [param theme_type_variation] of margins.
## Base type: [MarginContainer].
@export var ttv_margin: String:
	set(ttv_margin_):
		ttv_margin = ttv_margin_
		_container_margin.theme_type_variation = ttv_margin
## [param theme_type_variation] of icons and label container.
## Base type: [HBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_container_ili.theme_type_variation = ttv_separation
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the label.
## Base type: [Label].
@export var ttv_label: String:
	set(ttv_label_):
		ttv_label = ttv_label_
		_label.theme_type_variation = ttv_label
		_set_custom_minimum_size(get_combined_minimum_size())

# [PanelContainer] for the widget. It is the background.
var _container_panel: PanelContainer
# [MarginContainer] for left and right margins.
var _container_margin: MarginContainer
# [HBoxContainer] for the [Label] and [WIcon]s.
var _container_ili: HBoxContainer
# [Label].
var _label: Label
# Left [WIcon].
var _icon_left: WIcon
# Right [WIcon].
var _icon_right: WIcon


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_container_panel = PanelContainer.new()
	add_child(_container_panel)
	
	_container_margin = MarginContainer.new()
	_container_panel.add_child(_container_margin)
	
	_container_ili = HBoxContainer.new()
	_container_margin.add_child(_container_ili)
	
	_icon_left = WIcon.new()
	_container_ili.add_child(_icon_left)
	
	_label = Label.new()
	_container_ili.add_child(_label)
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	_icon_right = WIcon.new()
	_container_ili.add_child(_icon_right)


func _ready() -> void:
	_set_icon_left_custom_minimum_size()
	_set_icon_right_custom_minimum_size()
	_set_custom_minimum_size(get_combined_minimum_size())


func _set(property: StringName, value: Variant) -> bool:
	if property == "mouse_filter":
		_container_panel.mouse_filter = value
		_container_margin.mouse_filter = value
		_container_ili.mouse_filter = value
		_icon_left.mouse_filter = value
		_icon_right.mouse_filter = value
		return false
	return false


func _resize_children() -> void:
	_container_panel.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _container_margin.get_combined_minimum_size()
	return widget_minimum_size


func _set_icon_left_custom_minimum_size() -> void:
	if left_texture == null:
		_icon_left.custom_minimum_size.x = 0
	else:
		_icon_left.custom_minimum_size.x = _label.size.y


func _set_icon_right_custom_minimum_size() -> void:
	if right_texture == null:
		_icon_right.custom_minimum_size.x = 0
	else:
		_icon_right.custom_minimum_size.x = _label.size.y
