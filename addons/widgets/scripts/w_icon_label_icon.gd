@tool
class_name WIconLabelIcon
extends Control
## A [PanelContainer] with a [Label] and one [WIcon] on each side.


## Enum corresponding to [param alignment].
enum {
	LEFT,
	CENTER,
	RIGHT
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
		if alignment == LEFT:
			_container_horizontal.size_flags_horizontal = SIZE_SHRINK_BEGIN
		elif alignment == CENTER:
			_container_horizontal.size_flags_horizontal = SIZE_SHRINK_CENTER
		else:
			_container_horizontal.size_flags_horizontal = SIZE_SHRINK_END
## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var separation: int:
	set(separation_):
		separation = separation_
		_container_horizontal.add_theme_constant_override("separation", separation)
@export_group("Left icon", "icon_left")
## Left icon texture.
@export var icon_left_icon: Texture2D:
	set(icon_left_icon_):
		icon_left_icon = icon_left_icon_
		_icon_left.icon = icon_left_icon
		_set_icon_left_custom_minimum_size()
## If [code]true[/code], left icon texture is flipped horizontally.
@export var icon_left_flip_h: bool:
	set(icon_left_flip_h_):
		icon_left_flip_h = icon_left_flip_h_
		_icon_left.flip_h = icon_left_flip_h
## If [code]true[/code], left icon texture is flipped vertically.
@export var icon_left_flip_v: bool:
	set(icon_left_flip_v_):
		icon_left_flip_v = icon_left_flip_v_
		_icon_left.flip_v = icon_left_flip_v
@export_group("Right Icon", "icon_right")
## Right icon texture.
@export var icon_right_icon: Texture2D:
	set(icon_right_icon_):
		icon_right_icon = icon_right_icon_
		_icon_right.icon = icon_right_icon
		_set_icon_right_custom_minimum_size()
## If [code]true[/code], right icon texture is flipped horizontally.
@export var icon_right_flip_h: bool:
	set(icon_right_flip_h_):
		icon_right_flip_h = icon_right_flip_h_
		_icon_right.flip_h = icon_right_flip_h
## If [code]true[/code], right icon texture is flipped vertically.
@export var icon_right_flip_v: bool:
	set(icon_right_flip_v_):
		icon_right_flip_v = icon_right_flip_v_
		_icon_right.flip_v = icon_right_flip_v
@export_group("Margin", "margin")
## Left margin.
@export_range(0, 0, 1, "or_greater") var margin_left: int:
	set(margin_left_):
		margin_left = margin_left_
		_container_margin.add_theme_constant_override("margin_left", margin_left)
## Top margin.
@export_range(0, 0, 1, "or_greater") var margin_top: int:
	set(margin_top_):
		margin_top = margin_top_
		_container_margin.add_theme_constant_override("margin_top", margin_top)
## Right margin.
@export_range(0, 0, 1, "or_greater") var margin_right: int:
	set(margin_right_):
		margin_right = margin_right_
		_container_margin.add_theme_constant_override("margin_right", margin_right)
## Bottom margin.
@export_range(0, 0, 1, "or_greater") var margin_bottom: int:
	set(margin_bottom_):
		margin_bottom = margin_bottom_
		_container_margin.add_theme_constant_override("margin_bottom", margin_bottom)

# [PanelContainer] for the widget. It is the background.
var _container_panel: PanelContainer
# [MarginContainer] for left and right margins.
var _container_margin: MarginContainer
# [HBoxContainer] for the [Label] and [WIcon]s.
var _container_horizontal: HBoxContainer
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
	
	_container_horizontal = HBoxContainer.new()
	_container_margin.add_child(_container_horizontal)
	
	_icon_left = WIcon.new()
	_container_horizontal.add_child(_icon_left)
	
	_label = Label.new()
	_container_horizontal.add_child(_label)
	
	_icon_right = WIcon.new()
	_container_horizontal.add_child(_icon_right)


func _ready() -> void:
	_set_icon_left_custom_minimum_size()
	_set_icon_right_custom_minimum_size()


func _resize() -> void:
	custom_minimum_size = \
		_icon_left.custom_minimum_size + \
		_icon_right.custom_minimum_size + \
		_label.size + \
		Vector2(margin_left + margin_right, margin_top + margin_bottom) + \
		Vector2(2*_container_horizontal.get_theme_constant("separation"), 0)
	
	_container_panel.size = size


func _set_icon_left_custom_minimum_size() -> void:
	if _icon_left.icon == null:
		_icon_left.custom_minimum_size.x = 0
	else:
		_icon_left.custom_minimum_size.x = _label.size.y


func _set_icon_right_custom_minimum_size() -> void:
	if _icon_right.icon == null:
		_icon_right.custom_minimum_size.x = 0
	else:
		_icon_right.custom_minimum_size.x = _label.size.y
