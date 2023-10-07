@tool
class_name WNumericInput
extends PanelContainer
## A widget for numeric inputs.


## Text.
@export var text: String = "":
	set(text_):
		text = text_
		if label != null:
			label.text = text
@export_group("Values")
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
@export var initial_value: float = 0:
	set(initial_value_):
		initial_value = initial_value_
		if filtered_line_edit != null:
			filtered_line_edit.text = str(initial_value)
## Maximum lenght of the number.
@export var max_length: int = 3:
	set(max_length_):
		max_length = max_length_
		if filtered_line_edit != null:
			filtered_line_edit.max_length = max_length
## Step applied when buttons are pressed.
@export var step: float = 1.0
@export_group("Buttons")
## Up button icon.
@export var button_up: Texture2D:
	set(button_up_):
		button_up = button_up_
		if up_button != null:
			up_button.icon = button_up
## Down button icon.
@export var button_down_icon: Texture2D:
	set(button_down_icon_):
		button_down_icon = button_down_icon_
		if button_down != null:
			button_down.icon = button_down_icon
@export_group("Theme type variations")
## NumericInput panel container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]PanelContainer[/code].
@export var panel_container_theme_type_variation: String:
	set(panel_container_theme_type_variation_):
		panel_container_theme_type_variation = panel_container_theme_type_variation_
		theme_type_variation = panel_container_theme_type_variation
## Margin container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]MarginContainer[/code].
@export var margin_container_theme_type_variation: String:
	set(margin_container_theme_type_variation_):
		margin_container_theme_type_variation = margin_container_theme_type_variation_
		if margin_container != null:
			margin_container.theme_type_variation = margin_container_theme_type_variation
## Contents container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]HBoxContainer[/code].
@export var container_theme_type_variation: String:
	set(container_theme_type_variation_):
		container_theme_type_variation = container_theme_type_variation_
		if container != null:
			container.theme_type_variation = container_theme_type_variation
## NumericInput label [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var label_theme_type_variation: String:
	set(label_theme_type_variation_):
		label_theme_type_variation = label_theme_type_variation_
		if label != null:
			label.theme_type_variation = label_theme_type_variation
## LineEdit [param theme_type_variation].
## The [code]Base Type[/code] must be [code]LineEdit[/code].
@export var filtered_line_edit_theme_type_variation: String:
	set(filtered_line_edit_theme_type_variation_):
		filtered_line_edit_theme_type_variation = filtered_line_edit_theme_type_variation_
		if filtered_line_edit != null:
			filtered_line_edit.theme_type_variation = filtered_line_edit_theme_type_variation
## Up button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var up_button_theme_type_variation: String:
	set(up_button_theme_type_variation_):
		up_button_theme_type_variation = up_button_theme_type_variation_
		if up_button != null:
			up_button.theme_type_variation = up_button_theme_type_variation
## Down button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var button_down_theme_type_variation: String:
	set(button_down_theme_type_variation_):
		button_down_theme_type_variation = button_down_theme_type_variation_
		if button_down != null:
			button_down.theme_type_variation = button_down_theme_type_variation

var margin_container: MarginContainer
var container: HBoxContainer
var label: Label
var filtered_line_edit: WFilteredLineEdit
var up_button: WIconButton
var button_down: WIconButton


func _enter_tree() -> void:
	theme_type_variation = panel_container_theme_type_variation
	
	margin_container = MarginContainer.new()
	add_child(margin_container)
	margin_container.theme_type_variation = margin_container_theme_type_variation
	
	container = HBoxContainer.new()
	margin_container.add_child(container)
	container.theme_type_variation = container_theme_type_variation
	
	label = Label.new()
	container.add_child(label)
	label.theme_type_variation = label_theme_type_variation
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.clip_text = true
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	label.text = text
	
	filtered_line_edit = WFilteredLineEdit.new()
	container.add_child(filtered_line_edit)
	filtered_line_edit.theme_type_variation = filtered_line_edit_theme_type_variation
	filtered_line_edit.max_length = max_length
	filtered_line_edit.filter_mode = 5
	filtered_line_edit.flat = true
	filtered_line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	filtered_line_edit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	filtered_line_edit.value_max = value_max
	filtered_line_edit.value_min = value_min
	filtered_line_edit.text = str(initial_value)
	filtered_line_edit.clamp_text()
	
	up_button = WIconButton.new()
	container.add_child(up_button)
	up_button.theme_type_variation = up_button_theme_type_variation
	up_button.icon = button_up
	
	button_down = WIconButton.new()
	container.add_child(button_down)
	button_down.theme_type_variation = button_down_theme_type_variation
	button_down.icon = button_down_icon
	
	up_button.pressed.connect(
		func _on_up_button_pressed() -> void:
			var value: float = float(filtered_line_edit.text)
			value += step
			filtered_line_edit.text = str(value)
			filtered_line_edit.clamp_text()
	)
	button_down.pressed.connect(
		func _on_button_down_pressed() -> void:
			var value: float = float(filtered_line_edit.text)
			value -= step
			filtered_line_edit.text = str(value)
			filtered_line_edit.clamp_text()
	)


func _ready() -> void:
	item_rect_changed.connect(
		func _on_item_rect_changed() -> void:
			up_button.custom_minimum_size = Vector2(size[1], 0)
			button_down.custom_minimum_size = Vector2(size[1], 0)
	)
	item_rect_changed.emit()
