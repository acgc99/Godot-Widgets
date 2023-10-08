@tool
class_name WNumericInput
extends Control
## A widget for numeric inputs with two [WIconButton] for easy touch.


## Text.
@export var text: String:
	set(text_):
		text = text_
		if label != null:
			label.text = text
@export_group("Values", "value")
## Maximum value.
@export var value_max: float = INF:
	set(value_max_):
		value_max = value_max_
		if filtered_line_edit != null:
			filtered_line_edit.value_max = value_max
## Minimum value.
@export var value_min: float = -INF:
	set(value_min_):
		value_min = value_min_
		if filtered_line_edit != null:
			filtered_line_edit.value_min = value_min
## Initial value.
@export var value_initial: float:
	set(value_initial_):
		value_initial = value_initial_
		if filtered_line_edit != null:
			filtered_line_edit.text = str(value_initial)
## Step added/subtracted when the buttons are pressed.
@export_range(0.0, 0.0, 1.0, "or_greater") var value_step: float = 1.0
@export_group("Up Button", "button_up")
## Up icon button [member WIconButton.icon].
@export var button_up_icon: Texture2D:
	set(button_up_icon_):
		button_up_icon = button_up_icon_
		if button_up != null:
			button_up.icon = button_up_icon
## Up icon button [member WIconButton.flip_h].
@export var button_up_flip_h: bool:
	set(button_up_flip_h_):
		button_up_flip_h = button_up_flip_h_
		if button_up != null:
			button_up.flip_h = button_up_flip_h
## Up icon button [member WIconButton.flip_v].
@export var button_up_flip_v: bool:
	set(button_up_flip_v_):
		button_up_flip_v = button_up_flip_v_
		if button_up != null:
			button_up.flip_v = button_up_flip_v
## Up icon button [member WIconButton.disabled].
@export var button_up_disabled: bool = false:
	set(button_up_disabled_):
		button_up_disabled = button_up_disabled_
		if button_up != null:
			button_up.disabled = button_up_disabled
@export_group("Down Button", "button_down")
## Down icon button [member WIconButton.icon].
@export var button_down_icon: Texture2D:
	set(button_down_icon_):
		button_down_icon = button_down_icon_
		if button_down != null:
			button_down.icon = button_down_icon
## Down icon button [member WIconButton.flip_h].
@export var button_down_flip_h: bool:
	set(button_down_flip_h_):
		button_down_flip_h = button_down_flip_h_
		if button_down != null:
			button_down.flip_h = button_down_flip_h
## Down icon button [member WIconButton.flip_v].
@export var button_down_flip_v: bool:
	set(button_down_flip_v_):
		button_down_flip_v = button_down_flip_v_
		if button_down != null:
			button_down.flip_v = button_down_flip_v
## Down icon button [member WIconButton.disabled].
@export var button_down_disabled: bool = false:
	set(button_down_disabled_):
		button_down_disabled = button_down_disabled_
		if button_down != null:
			button_down.disabled = button_down_disabled

## Panel container for a panel background
var panel_container: PanelContainer
## [MarginContainer] to set margins for the widget.
var margin_container: MarginContainer
## Container of all elements.
var container: HBoxContainer
## [Label] holding the text.
var label: Label
## [WFilteredLineEdit] holding the value.
var filtered_line_edit: WFilteredLineEdit
## Up [WIconButton].
var button_up: WIconButton
## Down [WIconButton].
var button_down: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# panel_container ##########################################################
	panel_container = PanelContainer.new()
	add_child(panel_container)
	# margin_container #########################################################
	margin_container = MarginContainer.new()
	panel_container.add_child(margin_container)
	# container ################################################################
	container = HBoxContainer.new()
	margin_container.add_child(container)
	# label ####################################################################
	label = Label.new()
	container.add_child(label)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.clip_text = true
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	label.text = text
	# filtered_line_edit #######################################################
	filtered_line_edit = WFilteredLineEdit.new()
	container.add_child(filtered_line_edit)
	filtered_line_edit.filter_mode = WFilteredLineEdit.FLOAT
	filtered_line_edit.flat = true
	filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	filtered_line_edit.value_max = value_max
	filtered_line_edit.value_min = value_min
	filtered_line_edit.text = str(value_initial)
	filtered_line_edit.clamp_text()
	# button_up ################################################################
	button_up = WIconButton.new()
	container.add_child(button_up)
	button_up.pressed.connect(_on_button_up_pressed)
	button_up.icon = button_up_icon
	button_up.flip_h = button_up_flip_h
	button_up.flip_v = button_up_flip_v
	button_up.disabled = button_up_disabled
	# button_down ##############################################################
	button_down = WIconButton.new()
	container.add_child(button_down)
	button_down.pressed.connect(_on_button_down_pressed)
	button_down.icon = button_down_icon
	button_down.flip_h = button_down_flip_h
	button_down.flip_v = button_down_flip_v
	button_down.disabled = button_down_disabled


# Signal callables #############################################################


func _resize_children() -> void:
	button_up.custom_minimum_size = Vector2(size[1], 0)
	button_down.custom_minimum_size = Vector2(size[1], 0)


func _on_button_up_pressed() -> void:
	var value: float = float(filtered_line_edit.text)
	value += value_step
	filtered_line_edit.text = str(value)
	filtered_line_edit.clamp_text()


func _on_button_down_pressed() -> void:
	var value: float = float(filtered_line_edit.text)
	value -= value_step
	filtered_line_edit.text = str(value)
	filtered_line_edit.clamp_text()
