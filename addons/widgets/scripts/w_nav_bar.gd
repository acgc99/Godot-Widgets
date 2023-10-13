@tool
class_name WNavBar
extends Control
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
		if _label_title != null:
			_label_title.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
## [WNavBar] title horizontal alignment.
var horizontal_alignment: int = 1:
	set(horizontal_alignment_):
		horizontal_alignment = horizontal_alignment_
		if _label_title != null:
			_label_title.horizontal_alignment = horizontal_alignment
@export_group("Left button", "button_left")
## Left icon button [member WIconButton.icon].
@export var button_left_icon: Texture2D:
	set(button_left_icon_):
		button_left_icon = button_left_icon_
		if _button_left != null:
			_button_left.icon = button_left_icon
## Left icon button [member WIconButton.flip_h].
@export var button_left_flip_h: bool:
	set(button_left_flip_h_):
		button_left_flip_h = button_left_flip_h_
		if _button_left != null:
			_button_left.flip_h = button_left_flip_h
## Left icon button [member WIconButton.flip_v].
@export var button_left_flip_v: bool:
	set(button_left_flip_v_):
		button_left_flip_v = button_left_flip_v_
		if _button_left != null:
			_button_left.flip_v = button_left_flip_v
## Left icon button [member WIconButton.disabled].
@export var button_left_disabled: bool:
	set(button_left_disabled_):
		button_left_disabled = button_left_disabled_
		if _button_left != null:
			_button_left.disabled = button_left_disabled
@export_group("Right button", "button_right")
## Right icon button [member WIconButton.icon].
@export var button_right_icon: Texture2D:
	set(button_right_icon_):
		button_right_icon = button_right_icon_
		if _button_right != null:
			_button_right.icon = button_right_icon
## Right icon button [member WIconButton.flip_h].
@export var button_right_flip_h: bool:
	set(button_right_flip_h_):
		button_right_flip_h = button_right_flip_h_
		if _button_right != null:
			_button_right.flip_h = button_right_flip_h
## Right icon button [member WIconButton.flip_v].
@export var button_right_flip_v: bool:
	set(button_right_flip_v_):
		button_right_flip_v = button_right_flip_v_
		if _button_right != null:
			_button_right.flip_v = button_right_flip_v
## Right icon button [member WIconButton.disabled].
@export var button_right_disabled: bool = false:
	set(button_right_disabled_):
		button_right_disabled = button_right_disabled_
		if _button_right != null:
			_button_right.disabled = button_right_disabled

## Panel container for a panel background
var _panel_container: PanelContainer
## Container for all elements.
var _container: HBoxContainer
## [Label] holding the title.
var _label_title: Label
## Left [WIconButton].
var _button_left: WIconButton
## Right [WIconButton].
var _button_right: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _panel_container #########################################################
	_panel_container = PanelContainer.new()
	add_child(_panel_container)
	# _container ###############################################################
	_container = HBoxContainer.new()
	_panel_container.add_child(_container)
	# _button_left #############################################################
	_button_left = WIconButton.new()
	_container.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	_button_left.icon = button_left_icon
	_button_left.flip_h = button_left_flip_h
	_button_left.flip_v = button_left_flip_v
	_button_left.disabled = button_left_disabled
	# _label_title #############################################################
	_label_title = Label.new()
	_container.add_child(_label_title)
	_label_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_label_title.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_label_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label_title.horizontal_alignment = horizontal_alignment
	_label_title.text = title
	# _button_right ############################################################
	_button_right = WIconButton.new()
	_container.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)
	_button_right.icon = button_right_icon
	_button_right.flip_h = button_right_flip_h
	_button_right.flip_v = button_right_flip_v
	_button_right.disabled = button_right_disabled


# Signal callables #############################################################


func _resize_children() -> void:
	_button_left.custom_minimum_size = Vector2(size[1], 0)
	_button_right.custom_minimum_size = Vector2(size[1], 0)


func _on_button_left_pressed() -> void:
	pressed_left.emit()


func _on_button_right_pressed() -> void:
	pressed_right.emit()
