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
## Enum correspoding to [member filter_mode].
enum {
	FILTER_INTEGER_POSITIVE,
	FILTER_INTEGER,
	FILTER_FLOAT_POSITIVE,
	FILTER_FLOAT
}

## Step added/subtracted when buttons are pressed.
@export_range(0.0, 0.0, 1.0, "or_greater") var step: float = 1.0
@export_group("Up Button", "up")
## Up [WIconButton] texture.
@export var up_icon: Texture2D:
	set(up_icon_):
		up_icon = up_icon_
		_button_up.icon = up_icon
		_set_button_up_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], up [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var up_disabled: bool:
	set(up_disabled_):
		up_disabled = up_disabled_
		_button_up.disabled = up_disabled
@export_group("Down Button", "down")
## Down [WIconButton] texture.
@export var down_icon: Texture2D:
	set(down_icon_):
		down_icon = down_icon_
		_button_down.icon = down_icon
		_set_button_down_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], down [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var down_disabled: bool:
	set(down_disabled_):
		down_disabled = down_disabled_
		_button_down.disabled = down_disabled
@export_group("Theme Type Variation", "ttv")
## [param theme_type_variation] of the background panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_container_panel.theme_type_variation = ttv_panel
## [param theme_type_variation] of the margins.
## Base type: [MarginContainer].
@export var ttv_maring: String:
	set(ttv_maring_):
		ttv_maring = ttv_maring_
		_container_margin.theme_type_variation = ttv_maring
## [param theme_type_variation] of the label, line edit and buttons container.
## Base type: [HBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_container_input.theme_type_variation = ttv_separation
## [param theme_type_variation] of the up button.
## Base type: [Button].
@export var ttv_up_button: String:
	set(ttv_up_button_):
		ttv_up_button = ttv_up_button_
		_button_up.theme_type_variation = ttv_up_button
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the down button.
## Base type: [Button].
@export var ttv_down_button: String:
	set(ttv_down_button_):
		ttv_down_button = ttv_down_button_
		_button_down.theme_type_variation = ttv_down_button
		_set_custom_minimum_size(get_combined_minimum_size())
@export_category("Label")
## Text.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
		_set_custom_minimum_size(get_combined_minimum_size())
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
@export_group("Theme Type Variation Label", "ttv")
## [param theme_type_variation] of the label.
## Base type: [Label].
@export var ttv_label: String:
	set(ttv_label_):
		ttv_label = ttv_label_
		_label.theme_type_variation = ttv_label
@export_category("WFilteredLineEdit")
@export_enum(
	"Positive Integer",
	"Integer",
	"Positive Float",
	"Float"
)
## Filter modes.
## [param Positive Integer]. Positive or zero integer.
## [br]
## [br]
## [param Integer]. Integer.
## [br]
## [br]
## [param Positive float]. Positive float.
## [br]
## [br]
## [param Float]. Float.
var filter_mode: int:
	set(filter_mode_):
		filter_mode = filter_mode_
		_filtered_line_edit.filter_mode = filter_mode + 2
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
@export_group("Theme Type Variation WFIlteredLineEdit", "ttv")
## [param theme_type_variation] of the input field.
## Base type: [LineEdit].
@export var ttv_line_edit: String:
	set(ttv_line_edit_):
		ttv_line_edit = ttv_line_edit_
		_filtered_line_edit.theme_type_variation = ttv_line_edit

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
	_filtered_line_edit.flat = true
	_filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	_filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_filtered_line_edit.text = "0"
	_filtered_line_edit.filter_mode = WFilteredLineEdit.FILTER_INTEGER_POSITIVE
	
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
	if up_icon == null:
		_button_up.custom_minimum_size.x = 0
	else:
		_button_up.custom_minimum_size.x = _label.size.y


func _set_button_down_custom_minimum_size() -> void:
	if down_icon == null:
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
