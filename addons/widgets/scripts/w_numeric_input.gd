@tool
class_name WNumericInput
extends Control
## A widget for numeric inputs with two [WIconButton] for easy touch.


## Text.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
@export_group("Values", "value")
## Maximum value.
@export var value_max: float = INF:
	set(value_max_):
		value_max = value_max_
		_filtered_line_edit.value_max = value_max
## Minimum value.
@export var value_min: float = -INF:
	set(value_min_):
		value_min = value_min_
		_filtered_line_edit.value_min = value_min
## Initial value.
@export var value_initial: float:
	set(value_initial_):
		value_initial = value_initial_
		_filtered_line_edit.text = str(value_initial)
		_filtered_line_edit.clamp_text()
## Step added/subtracted when the buttons are pressed.
@export_range(0.0, 0.0, 1.0, "or_greater") var value_step: float = 1.0
@export_group("Up Button", "button_up")
## Up icon button [member WIconButton.icon].
@export var button_up_icon: Texture2D:
	set(button_up_icon_):
		button_up_icon = button_up_icon_
		_button_up.icon = button_up_icon
## Up icon button [member WIconButton.flip_h].
@export var button_up_flip_h: bool:
	set(button_up_flip_h_):
		button_up_flip_h = button_up_flip_h_
		_button_up.flip_h = button_up_flip_h
## Up icon button [member WIconButton.flip_v].
@export var button_up_flip_v: bool:
	set(button_up_flip_v_):
		button_up_flip_v = button_up_flip_v_
		_button_up.flip_v = button_up_flip_v
## Up icon button [member WIconButton.disabled].
@export var button_up_disabled: bool:
	set(button_up_disabled_):
		button_up_disabled = button_up_disabled_
		_button_up.disabled = button_up_disabled
@export_group("Down Button", "button_down")
## Down icon button [member WIconButton.icon].
@export var button_down_icon: Texture2D:
	set(button_down_icon_):
		button_down_icon = button_down_icon_
		_button_down.icon = button_down_icon
## Down icon button [member WIconButton.flip_h].
@export var button_down_flip_h: bool:
	set(button_down_flip_h_):
		button_down_flip_h = button_down_flip_h_
		_button_down.flip_h = button_down_flip_h
## Down icon button [member WIconButton.flip_v].
@export var button_down_flip_v: bool:
	set(button_down_flip_v_):
		button_down_flip_v = button_down_flip_v_
		_button_down.flip_v = button_down_flip_v
## Down icon button [member WIconButton.disabled].
@export var button_down_disabled: bool:
	set(button_down_disabled_):
		button_down_disabled = button_down_disabled_
		_button_down.disabled = button_down_disabled

# Panel container for a panel background
var _panel_container: PanelContainer
# [MarginContainer] to set margins for the widget.
var _margin_container: MarginContainer
# Container of all elements.
var _container: HBoxContainer
# [Label] holding the text.
var _label: Label
# [WFilteredLineEdit] holding the value.
var _filtered_line_edit: WFilteredLineEdit
# Up [WIconButton].
var _button_up: WIconButton
# Down [WIconButton].
var _button_down: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_panel_container = PanelContainer.new()
	add_child(_panel_container, false, Node.INTERNAL_MODE_BACK)
	
	_margin_container = MarginContainer.new()
	_panel_container.add_child(_margin_container)
	
	_container = HBoxContainer.new()
	_margin_container.add_child(_container)
	
	_label = Label.new()
	_container.add_child(_label)
	_label.size_flags_horizontal = SIZE_EXPAND_FILL
	_label.clip_text = true
	_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	
	_filtered_line_edit = WFilteredLineEdit.new()
	_container.add_child(_filtered_line_edit)
	_filtered_line_edit.filter_mode = WFilteredLineEdit.FLOAT
	_filtered_line_edit.flat = true
	_filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	_filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
	_button_up = WIconButton.new()
	_container.add_child(_button_up)
	_button_up.pressed.connect(_on_button_up_pressed)
	
	_button_down = WIconButton.new()
	_container.add_child(_button_down)
	_button_down.pressed.connect(_on_button_down_pressed)


func _resize() -> void:
	_button_up.custom_minimum_size = Vector2(size[1], 0)
	_button_down.custom_minimum_size = Vector2(size[1], 0)


func _on_button_up_pressed() -> void:
	var value: float = float(_filtered_line_edit.text)
	value += value_step
	_filtered_line_edit.text = str(value)
	_filtered_line_edit.clamp_text()


func _on_button_down_pressed() -> void:
	var value: float = float(_filtered_line_edit.text)
	value -= value_step
	_filtered_line_edit.text = str(value)
	_filtered_line_edit.clamp_text()
