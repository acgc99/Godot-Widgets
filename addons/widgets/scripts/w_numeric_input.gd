@tool
class_name WNumericInput
extends Control
## A widget for numeric inputs with two [WIconButton] for easy touch.


## Text.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
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
## Step added/subtracted when the buttons are pressed.
@export_range(0.0, 0.0, 1.0, "or_greater") var step: float = 1.0
@export_group("Up Button", "up")
## Up icon button [member WIconButton.icon].
@export var up_texture: Texture2D:
	set(up_texture_):
		up_texture = up_texture_
		_button_up.texture = up_texture
## Up icon button [member WIconButton.flip_h].
@export var up_flip_h: bool:
	set(up_flip_h_):
		up_flip_h = up_flip_h_
		_button_up.flip_h = up_flip_h
## Up icon button [member WIconButton.flip_v].
@export var up_flip_v: bool:
	set(up_flip_v_):
		up_flip_v = up_flip_v_
		_button_up.flip_v = up_flip_v
## Up icon button [member WIconButton.disabled].
@export var up_disabled: bool:
	set(up_disabled_):
		up_disabled = up_disabled_
		_button_up.disabled = up_disabled
@export_group("Down Button", "down")
## Down icon button [member WIconButton.icon].
@export var down_texture: Texture2D:
	set(down_texture_):
		down_texture = down_texture_
		_button_down.texture = down_texture
## Down icon button [member WIconButton.flip_h].
@export var down_flip_h: bool:
	set(down_flip_h_):
		down_flip_h = down_flip_h_
		_button_down.flip_h = down_flip_h
## Down icon button [member WIconButton.flip_v].
@export var down_flip_v: bool:
	set(down_flip_v_):
		down_flip_v = down_flip_v_
		_button_down.flip_v = down_flip_v
## Down icon button [member WIconButton.disabled].
@export var down_disabled: bool:
	set(down_disabled_):
		down_disabled = down_disabled_
		_button_down.disabled = down_disabled

# Panel container for a panel background
var _container_panel: PanelContainer
# [MarginContainer] to set margins for the widget.
var _container_margin: MarginContainer
# Container of all elements.
var _container_input: HBoxContainer
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
	
	_container_panel = PanelContainer.new()
	add_child(_container_panel, false, Node.INTERNAL_MODE_BACK)
	
	_container_margin = MarginContainer.new()
	_container_panel.add_child(_container_margin)
	
	_container_input = HBoxContainer.new()
	_container_margin.add_child(_container_input)
	
	_label = Label.new()
	_container_input.add_child(_label)
	_label.size_flags_horizontal = SIZE_EXPAND_FILL
	_label.clip_text = true
	_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	
	_filtered_line_edit = WFilteredLineEdit.new()
	_container_input.add_child(_filtered_line_edit)
	_filtered_line_edit.filter_mode = WFilteredLineEdit.FILTER_FLOAT
	_filtered_line_edit.flat = true
	_filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	_filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
	_button_up = WIconButton.new()
	_container_input.add_child(_button_up)
	_button_up.pressed.connect(_on_button_up_pressed)
	
	_button_down = WIconButton.new()
	_container_input.add_child(_button_down)
	_button_down.pressed.connect(_on_button_down_pressed)


func _resize() -> void:
	_button_up.custom_minimum_size = Vector2(size[1], 0)
	_button_down.custom_minimum_size = Vector2(size[1], 0)


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
