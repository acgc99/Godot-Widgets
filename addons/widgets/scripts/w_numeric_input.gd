@tool
class_name WNumericInput
extends "res://addons/widgets/scripts/w_control.gd"
## Widget for numeric inputs with two [WIconButton] for easy touch.


## Enum corresponding to [param text_overrun_behavior].
enum {
	OVERRUN_NO_TRIMMING,
	OVERRUN_TRIM_CHAR,
	OVERRUN_TRIM_WORD,
	OVERRUN_TRIM_ELLIPSIS,
	OVERRUN_TRIM_WORD_ELLIPSIS
}

## Text.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
		_set_custom_minimum_size(get_combined_minimum_size())
## Maximum value.
@export var max: float = INF:
	set(max_):
		max = max_
		_filtered_line_edit.max = max
## Minimum value.
@export var min: float = -INF:
	set(min_):
		min = min_
		_filtered_line_edit.min = min
## Initial value.
@export var initial: float:
	set(initial_):
		initial = initial_
		_filtered_line_edit.text = str(initial)
		_filtered_line_edit.clamp_text()
## Step added/subtracted when buttons are pressed.
@export_range(0.0, 0.0, 1.0, "or_greater") var step: float = 1.0
@export_enum(
	"Trim Nothing",
	"Trim Characters",
	"Trim Words",
	"Ellipsis",
	"Word Ellipsis"
)
## Sets the clipping behavior when the text exceeds the node's bounding
## rectangle. See [TextServer.OverrunBehavior] for description of all modes.
## [b]It might be needed to enlarge [param custom_minimum_size.x] to visualize
## text when this parameter is different from [param OVERRUN_NO_TRIMMING][/b].
var text_overrun_behavior: int:
	set(text_overrun_behavior_):
		text_overrun_behavior = text_overrun_behavior_
		_label.text_overrun_behavior = text_overrun_behavior
@export_group("Up Button", "up")
## Up [WIconButton] texture.
@export var up_texture: Texture2D:
	set(up_texture_):
		up_texture = up_texture_
		_button_up.texture = up_texture
		_set_button_up_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], up [WIconButton] texture is flipped horizontally.
@export var up_flip_h: bool:
	set(up_flip_h_):
		up_flip_h = up_flip_h_
		_button_up.flip_h = up_flip_h
## If [code]true[/code], left [WIconButton] texture is flipped vertically.
@export var up_flip_v: bool:
	set(up_flip_v_):
		up_flip_v = up_flip_v_
		_button_up.flip_v = up_flip_v
## If [code]true[/code], up [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var up_disabled: bool:
	set(up_disabled_):
		up_disabled = up_disabled_
		_button_up.disabled = up_disabled
@export_group("Down Button", "down")
## Down [WIconButton] texture.
@export var down_texture: Texture2D:
	set(down_texture_):
		down_texture = down_texture_
		_button_down.texture = down_texture
		_set_button_down_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], down [WIconButton] texture is flipped horizontally.
@export var down_flip_h: bool:
	set(down_flip_h_):
		down_flip_h = down_flip_h_
		_button_down.flip_h = down_flip_h
## If [code]true[/code], down [WIconButton] texture is flipped vertically.
@export var down_flip_v: bool:
	set(down_flip_v_):
		down_flip_v = down_flip_v_
		_button_down.flip_v = down_flip_v
## If [code]true[/code], down [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var down_disabled: bool:
	set(down_disabled_):
		down_disabled = down_disabled_
		_button_down.disabled = down_disabled

# Main widget container.
var _container_panel: PanelContainer
# [MarginContainer] to set margins for the widget.
var _container_margin: MarginContainer
# Container of label, line edit and buttons.
var _container_input: HBoxContainer
# [Label] for the text.
var _label: Label
# [WFilteredLineEdit] for the value.
var _filtered_line_edit: WFilteredLineEdit
# Up [WIconButton].
var _button_up: WIconButton
# Down [WIconButton].
var _button_down: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_container_panel = PanelContainer.new()
	add_child(_container_panel, false, Node.INTERNAL_MODE_BACK)
	
	_container_margin = MarginContainer.new()
	_container_panel.add_child(_container_margin)
	
	_container_input = HBoxContainer.new()
	_container_margin.add_child(_container_input)
	
	_label = Label.new()
	_container_input.add_child(_label)
	_label.size_flags_horizontal = SIZE_EXPAND_FILL
	
	_filtered_line_edit = WFilteredLineEdit.new()
	_container_input.add_child(_filtered_line_edit)
	_filtered_line_edit.filter_mode = WFilteredLineEdit.FILTER_FLOAT
	_filtered_line_edit.flat = true
	_filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	_filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_filtered_line_edit.text = "0"
	
	_button_up = WIconButton.new()
	_container_input.add_child(_button_up)
	_button_up.pressed.connect(_on_button_up_pressed)
	
	_button_down = WIconButton.new()
	_container_input.add_child(_button_down)
	_button_down.pressed.connect(_on_button_down_pressed)


func _ready() -> void:
	_set_button_up_custom_minimum_size()
	_set_button_down_custom_minimum_size()
	_set_custom_minimum_size(get_combined_minimum_size())


func _resize_children() -> void:
	_container_panel.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _container_panel.get_combined_minimum_size()
	return widget_minimum_size


func _set_button_up_custom_minimum_size() -> void:
	if up_texture == null:
		_button_up.custom_minimum_size.x = 0
	else:
		_button_up.custom_minimum_size.x = _label.size.y


func _set_button_down_custom_minimum_size() -> void:
	if down_texture == null:
		_button_down.custom_minimum_size.x = 0
	else:
		_button_down.custom_minimum_size.x = _label.size.y


func _on_button_up_pressed() -> void:
	var value: float = float(_filtered_line_edit.text)
	value += step
	_filtered_line_edit.text = str(value)
	_filtered_line_edit.clamp_text()


func _on_button_down_pressed() -> void:
	var value: float = float(_filtered_line_edit.text)
	value -= step
	_filtered_line_edit.text = str(value)
	_filtered_line_edit.clamp_text()
