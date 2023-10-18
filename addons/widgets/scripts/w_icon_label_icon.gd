@tool
class_name WIconLabelIcon
extends Control
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
## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		_container_ili.add_theme_constant_override("separation", separation)
		_resize()
@export_group("Left Icon", "left")
## Left icon texture.
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_icon_left.texture = left_texture
		_set_icon_left_custom_minimum_size()
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
@export_group("Margin", "margin")
## Left margin.
@export_range(0, 0, 1, "or_greater") var margin_left: int:
	set(margin_left_):
		margin_left = margin_left_
		_container_margin.add_theme_constant_override("margin_left", margin_left)
		_resize()
## Top margin.
@export_range(0, 0, 1, "or_greater") var margin_top: int:
	set(margin_top_):
		margin_top = margin_top_
		_container_margin.add_theme_constant_override("margin_top", margin_top)
		_resize()
## Right margin.
@export_range(0, 0, 1, "or_greater") var margin_right: int:
	set(margin_right_):
		margin_right = margin_right_
		_container_margin.add_theme_constant_override("margin_right", margin_right)
		_resize()
## Bottom margin.
@export_range(0, 0, 1, "or_greater") var margin_bottom: int:
	set(margin_bottom_):
		margin_bottom = margin_bottom_
		_container_margin.add_theme_constant_override("margin_bottom", margin_bottom)
		_resize()

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
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
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
	_label.item_rect_changed.connect(_resize)
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	_icon_right = WIcon.new()
	_container_ili.add_child(_icon_right)


func _ready() -> void:
	_set_icon_left_custom_minimum_size()
	_set_icon_right_custom_minimum_size()


func _resize() -> void:
	custom_minimum_size = \
		_icon_left.get_combined_minimum_size() + \
		_icon_right.get_combined_minimum_size() + \
		_label.get_combined_minimum_size() + \
		Vector2(margin_left + margin_right, margin_top + margin_bottom) + \
		Vector2(2*_container_ili.get_theme_constant("separation"), 0)
	
	_container_panel.size = size


func _set_icon_left_custom_minimum_size() -> void:
	if left_texture == null:
		_icon_left.custom_minimum_size.x = 0
	else:
		_icon_left.custom_minimum_size.x = _label.size.y
	_resize()


func _set_icon_right_custom_minimum_size() -> void:
	if right_texture == null:
		_icon_right.custom_minimum_size.x = 0
	else:
		_icon_right.custom_minimum_size.x = _label.size.y
	_resize()
