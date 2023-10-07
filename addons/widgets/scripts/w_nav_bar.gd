@tool
class_name WNavBar
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
@export_group("Left button", "button_left")
## Left button disabled state.
@export var button_left_disabled: bool = false:
	set(button_left_disabled_):
		button_left_disabled = button_left_disabled_
		if button_left != null:
			button_left.disabled = button_left_disabled
## Left button icon.
@export var button_left_icon: Texture2D:
	set(button_left_icon_):
		button_left_icon = button_left_icon_
		if button_left != null:
			button_left.icon = button_left_icon
@export_group("Right button", "button_right")
## Left button disabled state.
@export var button_right_disabled: bool = false:
	set(button_right_disabled_):
		button_right_disabled = button_right_disabled_
		if button_right != null:
			button_right.disabled = button_right_disabled
## Left button icon.
@export var button_right_icon: Texture2D:
	set(button_right_icon_):
		button_right_icon = button_right_icon_
		if button_right != null:
			button_right.icon = button_right_icon
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
@export var button_left_theme_type_variation: String:
	set(button_left_theme_type_variation_):
		button_left_theme_type_variation = button_left_theme_type_variation_
		if button_left != null:
			button_left.theme_type_variation = button_left_theme_type_variation
## NavBar right button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var button_right_theme_type_variation: String:
	set(button_right_theme_type_variation_):
		button_right_theme_type_variation = button_right_theme_type_variation_
		if button_right != null:
			button_right.theme_type_variation = button_right_theme_type_variation

var container: HBoxContainer
var title_label: Label
var button_left: WIconButton
var button_right: WIconButton


func _enter_tree() -> void:
	theme_type_variation = panel_container_theme_type_variation
	
	container = HBoxContainer.new()
	add_child(container)
	container.theme_type_variation = container_theme_type_variation
	
	button_left = WIconButton.new()
	container.add_child(button_left)
	button_left.theme_type_variation = button_left_theme_type_variation
	button_left.disabled = button_left_disabled
	button_left.icon = button_left_icon
	
	title_label = Label.new()
	container.add_child(title_label)
	title_label.theme_type_variation = title_label_theme_type_variation
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title_label.horizontal_alignment = horizontal_alignment
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.text = title
	
	button_right = WIconButton.new()
	container.add_child(button_right)
	button_right.theme_type_variation = button_right_theme_type_variation
	button_right.disabled = button_right_disabled
	button_right.icon = button_right_icon
	
	button_left.pressed.connect(
		func _on_button_left_pressed() -> void:
			pressed_left.emit()
	)
	button_right.pressed.connect(
		func _on_button_right_pressed() -> void:
			pressed_right.emit()
	)


func _ready() -> void:
	item_rect_changed.connect(
	func _on_item_rect_changed() -> void:
		button_left.custom_minimum_size = Vector2(size[1], 0)
		button_right.custom_minimum_size = Vector2(size[1], 0)
	)
	item_rect_changed.emit()
