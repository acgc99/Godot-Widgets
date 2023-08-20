@tool
class_name NavBar
extends PanelContainer
## A widget for intended to be used for navigation arround the app screens/pages.
## It might have zero height if [param custom_minimum_height] not specified.


## Emitted when left button is pressed.
signal pressed_left
## Emitted when the right button is pressed.
signal pressed_right


@export_group("Title")
## NavBar title.
@export var title: String:
	set(title_):
		title = title_
		if label != null:
			label.text = title
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## NavBar title horizontal alignment.
var horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(horizontal_alignment_):
		horizontal_alignment = horizontal_alignment_
		if label != null:
			label.horizontal_alignment = horizontal_alignment
@export_group("Buttons")
@export_subgroup("Left Button")
## Left button disabled state.
@export var left_button_disabled: bool = false:
	set(left_button_disabled_):
		left_button_disabled = left_button_disabled_
		if left_button != null:
			left_button.disabled = left_button_disabled
## Left button icon.
@export var left_button_icon: Texture2D = preload("res://addons/widgets/png_icons/arrow-left-bold.png"):
	set(left_button_icon_):
		left_button_icon = left_button_icon_
		if left_button != null:
			left_button.icon = left_button_icon
@export_subgroup("Right Button")
## Left button disabled state.
@export var right_button_disabled: bool = false:
	set(right_button_disabled_):
		right_button_disabled = right_button_disabled_
		if right_button != null:
			right_button.disabled = right_button_disabled
## Left button icon.
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
	label.text = title
	
	right_button = IconButton.new()
	container.add_child(right_button)
	right_button.disabled = right_button_disabled
	right_button.icon = right_button_icon
	
	# This check is to avoid conflict with [code]@tool[/code].
	if not is_connected("resized", _on_resized):
		resized.connect(_on_resized)
	resized.emit()
	left_button.pressed.connect(
		func left_button_pressed() -> void:
			pressed_left.emit()
	)
	right_button.pressed.connect(
		func right_button_pressed() -> void:
			pressed_right.emit()
	)


func _on_resized() -> void:
	left_button.custom_minimum_size = Vector2(size[1], 0)
	label.add_theme_font_size_override("font_size", floor(size[1]/2.0))
	right_button.custom_minimum_size = Vector2(size[1], 0)
