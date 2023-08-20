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
		if title_label != null:
			title_label.text = title
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
		if title_label != null:
			title_label.horizontal_alignment = horizontal_alignment
@export_group("Buttons")
@export_subgroup("Left Button", "left_button")
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
@export_subgroup("Right Button", "right_button")
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
@export_group("Theme type variations")
## NavBar panel container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]PanelContainer[/code].
@export var panel_container_theme_type_variation: String:
	set(panel_container_theme_type_variation_):
		panel_container_theme_type_variation = panel_container_theme_type_variation_
		theme_type_variation = panel_container_theme_type_variation
## NavBar contents container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]HBoxContainer[/code].
@export var container_theme_type_variation: String:
	set(container_theme_type_variation_):
		container_theme_type_variation = container_theme_type_variation_
		if container != null:
			container.theme_type_variation = container_theme_type_variation
## NavBar title [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var title_label_theme_type_variation: String:
	set(title_label_theme_type_variation_):
		title_label_theme_type_variation = title_label_theme_type_variation_
		if title_label != null:
			title_label.theme_type_variation = title_label_theme_type_variation
## NavBar left button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var left_button_theme_type_variation: String:
	set(left_button_theme_type_variation_):
		left_button_theme_type_variation = left_button_theme_type_variation_
		if left_button != null:
			left_button.theme_type_variation = left_button_theme_type_variation
## NavBar right button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var right_button_theme_type_variation: String:
	set(right_button_theme_type_variation_):
		right_button_theme_type_variation = right_button_theme_type_variation_
		if right_button != null:
			right_button.theme_type_variation = right_button_theme_type_variation

var container: HBoxContainer
var title_label: Label
var left_button: IconButton
var right_button: IconButton


func _enter_tree() -> void:
	theme_type_variation = panel_container_theme_type_variation
	
	container = HBoxContainer.new()
	add_child(container)
	container.theme_type_variation = container_theme_type_variation
	
	left_button = IconButton.new()
	container.add_child(left_button)
	left_button.theme_type_variation = left_button_theme_type_variation
	left_button.disabled = left_button_disabled
	left_button.icon = left_button_icon
	
	title_label = Label.new()
	container.add_child(title_label)
	title_label.theme_type_variation = title_label_theme_type_variation
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title_label.horizontal_alignment = horizontal_alignment
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.text = title
	
	right_button = IconButton.new()
	container.add_child(right_button)
	right_button.theme_type_variation = right_button_theme_type_variation
	right_button.disabled = right_button_disabled
	right_button.icon = right_button_icon
	
	left_button.pressed.connect(
		func _on_left_button_pressed() -> void:
			pressed_left.emit()
	)
	right_button.pressed.connect(
		func _on_right_button_pressed() -> void:
			pressed_right.emit()
	)


func _ready() -> void:
	resized.connect(
	func _on_resized() -> void:
		left_button.custom_minimum_size = Vector2(size[1], 0)
		right_button.custom_minimum_size = Vector2(size[1], 0)
	)
	resized.emit()
