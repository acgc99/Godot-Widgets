@tool
class_name WNavBar
extends Control
## A widget with to [WIconButton] and a [Label] in the middle. Intended to be
## placed at the top/bottom of the scene (left/right buttons), but it can also
## be placed on sides.


## Emitted when the left button is pressed.
signal left_button_pressed
## Emitted when the right button is pressed.
signal right_button_pressed

## Enum corresponding to [param alignment].
enum {
	ALIGNMENT_LEFT,
	ALIGNMEN_CENTER,
	ALIGNMENT_RIGHT
}

## [WNavBar] title.
@export var title: String:
	set(title_):
		title = title_
		_label_title.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
## [WNavBar] title horizontal alignment.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		_label_title.horizontal_alignment = alignment
@export_group("Left button", "button_left")
## Left icon button [member WIconButton.icon].
@export var button_left_icon: Texture2D:
	set(button_left_icon_):
		button_left_icon = button_left_icon_
		_button_left.icon = button_left_icon
## Left icon button [member WIconButton.flip_h].
@export var button_left_flip_h: bool:
	set(button_left_flip_h_):
		button_left_flip_h = button_left_flip_h_
		_button_left.flip_h = button_left_flip_h
## Left icon button [member WIconButton.flip_v].
@export var button_left_flip_v: bool:
	set(button_left_flip_v_):
		button_left_flip_v = button_left_flip_v_
		_button_left.flip_v = button_left_flip_v
## Left icon button [member WIconButton.disabled].
@export var button_left_disabled: bool:
	set(button_left_disabled_):
		button_left_disabled = button_left_disabled_
		_button_left.disabled = button_left_disabled
@export_group("Right button", "button_right")
## Right icon button [member WIconButton.icon].
@export var button_right_icon: Texture2D:
	set(button_right_icon_):
		button_right_icon = button_right_icon_
		_button_right.icon = button_right_icon
## Right icon button [member WIconButton.flip_h].
@export var button_right_flip_h: bool:
	set(button_right_flip_h_):
		button_right_flip_h = button_right_flip_h_
		_button_right.flip_h = button_right_flip_h
## Right icon button [member WIconButton.flip_v].
@export var button_right_flip_v: bool:
	set(button_right_flip_v_):
		button_right_flip_v = button_right_flip_v_
		_button_right.flip_v = button_right_flip_v
## Right icon button [member WIconButton.disabled].
@export var button_right_disabled: bool:
	set(button_right_disabled_):
		button_right_disabled = button_right_disabled_
		_button_right.disabled = button_right_disabled

# [PanelContainer] for the widget. It is the background.
var _panel_container: PanelContainer
# [HBoxContainer] for the buttons and the label.
var _title_container: HBoxContainer
# [Label] holding the title.
var _label_title: Label
# Left [WIconButton].
var _button_left: WIconButton
# Right [WIconButton].
var _button_right: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_panel_container = PanelContainer.new()
	add_child(_panel_container, false, Node.INTERNAL_MODE_BACK)
	
	_title_container = HBoxContainer.new()
	_panel_container.add_child(_title_container)
	
	_button_left = WIconButton.new()
	_title_container.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	
	_label_title = Label.new()
	_title_container.add_child(_label_title)
	_label_title.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_title.size_flags_vertical = SIZE_EXPAND_FILL
	_label_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	_button_right = WIconButton.new()
	_title_container.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)


func _resize() -> void:
	_button_left.custom_minimum_size = Vector2(size[1], 0)
	_button_right.custom_minimum_size = Vector2(size[1], 0)


func _on_button_left_pressed() -> void:
	left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	right_button_pressed.emit()
