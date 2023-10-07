@tool
class_name WNavBar
extends PanelContainer
## A widget with to [WIconButton] and a [Label] in the middle. Intended to be
## placed at the top/bottom of the scene (left/right buttons), but it can also
## be placed on sides.


## Emitted when the left button is pressed.
signal pressed_left
## Emitted when the right button is pressed.
signal pressed_right

@export_group("Title")
## [WNavBar] title.
@export var title: String:
	set(title_):
		title = title_
		if label_title != null:
			label_title.text = title
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## [WNavBar] title horizontal alignment.
var horizontal_alignment: int:
	set(horizontal_alignment_):
		horizontal_alignment = horizontal_alignment_
		if label_title != null:
			label_title.horizontal_alignment = horizontal_alignment
@export_group("Left button", "button_left")
## Left icon button [member WIconButton.icon].
@export var button_left_icon: Texture2D:
	set(button_left_icon_):
		button_left_icon = button_left_icon_
		if button_left != null:
			button_left.icon = button_left_icon
## Left icon button [member WIconButton.flip_h].
@export var button_left_flip_h: bool:
	set(button_left_flip_h_):
		button_left_flip_h = button_left_flip_h_
		if button_left != null:
			button_left.flip_h = button_left_flip_h
## Left icon button [member WIconButton.flip_v].
@export var button_left_flip_v: bool:
	set(button_left_flip_v_):
		button_left_flip_v = button_left_flip_v_
		if button_left != null:
			button_left.flip_v = button_left_flip_v
## Left icon button [member WIconButton.disabled].
@export var button_left_disabled: bool:
	set(button_left_disabled_):
		button_left_disabled = button_left_disabled_
		if button_left != null:
			button_left.disabled = button_left_disabled
@export_group("Right button", "button_right")
## Right icon button [member WIconButton.icon].
@export var button_right_icon: Texture2D:
	set(button_right_icon_):
		button_right_icon = button_right_icon_
		if button_right != null:
			button_right.icon = button_right_icon
## Right icon button [member WIconButton.flip_h].
@export var button_right_flip_h: bool:
	set(button_right_flip_h_):
		button_right_flip_h = button_right_flip_h_
		if button_right != null:
			button_right.flip_h = button_right_flip_h
## Right icon button [member WIconButton.flip_v].
@export var button_right_flip_v: bool:
	set(button_right_flip_v_):
		button_right_flip_v = button_right_flip_v_
		if button_right != null:
			button_right.flip_v = button_right_flip_v
## Right icon button [member WIconButton.disabled].
@export var button_right_disabled: bool = false:
	set(button_right_disabled_):
		button_right_disabled = button_right_disabled_
		if button_right != null:
			button_right.disabled = button_right_disabled

## Container for all elements.
var container: HBoxContainer
## [Label] holding the title.
var label_title: Label
## Left [WIconButton].
var button_left: WIconButton
## Right [WIconButton].
var button_right: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# container ################################################################
	container = HBoxContainer.new()
	add_child(container)
	# button_left ##############################################################
	button_left = WIconButton.new()
	container.add_child(button_left)
	button_left.pressed.connect(_on_button_left_pressed)
	button_left.icon = button_left_icon
	button_left.flip_h = button_left_flip_h
	button_left.flip_v = button_left_flip_v
	button_left.disabled = button_left_disabled
	# label_title ##############################################################
	label_title = Label.new()
	container.add_child(label_title)
	label_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label_title.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label_title.horizontal_alignment = horizontal_alignment
	label_title.text = title
	# button_right #############################################################
	button_right = WIconButton.new()
	container.add_child(button_right)
	button_right.pressed.connect(_on_button_right_pressed)
	button_right.icon = button_right_icon
	button_right.flip_h = button_right_flip_h
	button_right.flip_v = button_right_flip_v
	button_right.disabled = button_right_disabled


# Signal callables #############################################################


func _resize_children() -> void:
		button_left.custom_minimum_size = Vector2(size[1], 0)
		button_right.custom_minimum_size = Vector2(size[1], 0)


func _on_button_left_pressed() -> void:
	pressed_left.emit()


func _on_button_right_pressed() -> void:
	pressed_right.emit()
