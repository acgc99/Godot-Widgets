@tool
class_name NumericInput
extends PanelContainer
## A widget for numeric inputs.


## [param label.text].
@export var text: String = "":
	set(text_):
		text = text_
		if label != null:
			label.text = text
## [param filtered_line_edit.max_value].
@export var max_value: float = INF:
	set(max_value_):
		max_value = max_value_
		if filtered_line_edit != null:
			filtered_line_edit.max_value = max_value
## [param filtered_line_edit.min_value].
@export var min_value: float = -INF:
	set(min_value_):
		min_value = min_value_
		if filtered_line_edit != null:
			filtered_line_edit.min_value = min_value
## Initial value for [code]filtered_line_edit[/code].
@export var initial_value: float = 0:
	set(initial_value_):
		initial_value = initial_value_
		if filtered_line_edit != null:
			filtered_line_edit.text = str(initial_value)
## [param filtered_line_edit.max_length].
@export var max_length: int = 3:
	set(max_length_):
		max_length = max_length_
		if filtered_line_edit != null:
			filtered_line_edit.max_length = max_length
## [param filtered_line_edit.minimum_character_width].
@export var minimum_character_width: int = 2:
	set(minimum_character_width_):
		minimum_character_width = minimum_character_width_
		if filtered_line_edit != null:
			filtered_line_edit.add_theme_constant_override("minimum_character_width", minimum_character_width)
## Step applied when buttons are pressed.
@export var step: float = 1.0
## [param up_button.icon].
@export var up_button_icon: Texture2D = preload("res://addons/widgets/png_icons/arrow-up-bold.png"):
	set(up_button_icon_):
		up_button_icon = up_button_icon_
		if up_button != null:
			up_button.icon = up_button_icon
## [param down_button.icon].
@export var down_button_icon: Texture2D = preload("res://addons/widgets/png_icons/arrow-down-bold.png"):
	set(down_button_icon_):
		down_button_icon = down_button_icon_
		if down_button != null:
			down_button.icon = down_button_icon
var container: HBoxContainer
var label: Label
var filtered_line_edit: FilteredLineEdit
var up_button: IconButton
var down_button: IconButton


func _enter_tree() -> void:
	
	container = HBoxContainer.new()
	add_child(container)
	container.add_theme_constant_override("separation", 0)
	
	label = Label.new()
	container.add_child(label)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.clip_text = true
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	label.text = text
	
	filtered_line_edit = FilteredLineEdit.new()
	container.add_child(filtered_line_edit)
	filtered_line_edit.add_theme_constant_override("minimum_character_width", minimum_character_width)
	filtered_line_edit.max_length = max_length
	filtered_line_edit.filter_mode = 5
	filtered_line_edit.flat = true
	filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	filtered_line_edit.max_value = max_value
	filtered_line_edit.min_value = min_value
	filtered_line_edit.text = str(initial_value)
	filtered_line_edit.clamp_text()
	
	up_button = IconButton.new()
	container.add_child(up_button)
	up_button.icon = up_button_icon
	
	down_button = IconButton.new()
	container.add_child(down_button)
	down_button.icon = down_button_icon
	
	# This check is to avoid conflict with [code]@tool[/code].
	if not is_connected("resized", _on_resized):
		resized.connect(_on_resized)
	resized.emit()
	up_button.pressed.connect(_on_up_button_pressed)
	down_button.pressed.connect(_on_down_button_pressed)


func _on_resized() -> void:
	label.add_theme_font_size_override("font_size", floor(size[1]/2.0))
	filtered_line_edit.add_theme_font_size_override("font_size", floor(size[1]/2.0))
	up_button.custom_minimum_size = Vector2(size[1], 0)
	down_button.custom_minimum_size = Vector2(size[1], 0)


func _on_up_button_pressed() -> void:
	var value: float = float(filtered_line_edit.text)
	value += step
	filtered_line_edit.text = str(value)
	filtered_line_edit.clamp_text()


func _on_down_button_pressed() -> void:
	var value: float = float(filtered_line_edit.text)
	value -= step
	filtered_line_edit.text = str(value)
	filtered_line_edit.clamp_text()
