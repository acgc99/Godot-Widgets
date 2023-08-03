@tool
class_name NavBar
extends PanelContainer
## A widget for intended to be used for navigation arround the app screens/pages.

## Emitted when [code]left_button[/code] is pressed.
signal pressed_left
## Emitted when the [code]right_button[/code] is pressed.
signal pressed_right
## [param label.horizontal_alignment]
@export_enum(
	"HORIZONTAL_ALIGNMENT_LEFT",
	"HORIZONTAL_ALIGNMENT_CENTER",
	"HORIZONTAL_ALIGNMENT_RIGHT",
	"HORIZONTAL_ALIGNMENT_FILL"
) var horizontal_alignment: int = 1:
	set(horizontal_alignment_):
		horizontal_alignment = horizontal_alignment_
		if label != null:
			label.horizontal_alignment = horizontal_alignment
## [param label.text].
@export var text: String:
	set(text_):
		text = text_
		if label != null:
			label.text = text
## [param left_button.disabled].
@export var left_button_disabled: bool = false:
	set(left_button_disabled_):
		left_button_disabled = left_button_disabled_
		if left_button != null:
			left_button.disabled = left_button_disabled
## [param right_button.disabled].
@export var right_button_disabled: bool = false:
	set(right_button_disabled_):
		right_button_disabled = right_button_disabled_
		if right_button != null:
			right_button.disabled = right_button_disabled
## [param left_button.icon].
@export var left_button_icon: Texture2D = preload("res://addons/widgets/png_icons/arrow-left-bold.png"):
	set(left_button_icon_):
		left_button_icon = left_button_icon_
		if left_button != null:
			left_button.icon = left_button_icon
## [param right_button.icon].
@export var right_button_icon: Texture2D = preload("res://addons/widgets/png_icons/home.png"):
	set(right_button_icon_):
		right_button_icon = right_button_icon_
		if right_button != null:
			right_button.icon = right_button_icon
var container: HBoxContainer
var label: Label
var left_button: IconButton
var right_button: IconButton


func _enter_tree() -> void:
	container = HBoxContainer.new()
	add_child(container)
	container.add_theme_constant_override("separation", 0)
	
	left_button = IconButton.new()
	container.add_child(left_button)
	left_button.disabled = left_button_disabled
	left_button.icon = left_button_icon
	
	label = Label.new()
	container.add_child(label)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.horizontal_alignment = horizontal_alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.text = text
	
	right_button = IconButton.new()
	container.add_child(right_button)
	right_button.disabled = right_button_disabled
	right_button.icon = right_button_icon
	
	resized.connect(_on_resized)
	resized.emit()
	left_button.pressed.connect(_on_left_button_pressed)
	right_button.pressed.connect(_on_right_button_pressed)


func _on_resized() -> void:
	left_button.custom_minimum_size = Vector2(size[1], 0)
	label.add_theme_font_size_override("font_size", floor(size[1]/2.0))
	right_button.custom_minimum_size = Vector2(size[1], 0)


func _on_left_button_pressed() -> void:
	pressed_left.emit()


func _on_right_button_pressed() -> void:
	pressed_right.emit()
