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
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
@export_enum(
	"Left",
	"Center",
	"Right"
)
## [WNavBar] title horizontal alignment.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		_label.horizontal_alignment = alignment
@export_group("Left button", "left")
## Left icon button [member WIconButton.icon].
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_button_left.texture = left_texture
## Left icon button [member WIconButton.flip_h].
@export var left_flip_h: bool:
	set(left_flip_h_):
		left_flip_h = left_flip_h_
		_button_left.flip_h = left_flip_h
## Left icon button [member WIconButton.flip_v].
@export var left_flip_v: bool:
	set(left_flip_v_):
		left_flip_v = left_flip_v_
		_button_left.flip_v = left_flip_v
## Left icon button [member WIconButton.disabled].
@export var left_disabled: bool:
	set(left_disabled_):
		left_disabled = left_disabled_
		_button_left.disabled = left_disabled
@export_group("Right button", "right")
## Right icon button [member WIconButton.icon].
@export var right_texture: Texture2D:
	set(right_texture_):
		right_texture = right_texture_
		_button_right.texture = right_texture
## Right icon button [member WIconButton.flip_h].
@export var right_flip_h: bool:
	set(right_flip_h_):
		right_flip_h = right_flip_h_
		_button_right.flip_h = right_flip_h
## Right icon button [member WIconButton.flip_v].
@export var right_flip_v: bool:
	set(right_flip_v_):
		right_flip_v = right_flip_v_
		_button_right.flip_v = right_flip_v
## Right icon button [member WIconButton.disabled].
@export var right_disabled: bool:
	set(right_disabled_):
		right_disabled = right_disabled_
		_button_right.disabled = right_disabled

# [PanelContainer] for the widget. It is the background.
var _container_panel: PanelContainer
# [HBoxContainer] for the buttons and the label.
var _container_title: HBoxContainer
# [Label] holding the title.
var _label: Label
# Left [WIconButton].
var _button_left: WIconButton
# Right [WIconButton].
var _button_right: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_container_panel = PanelContainer.new()
	add_child(_container_panel, false, Node.INTERNAL_MODE_BACK)
	
	_container_title = HBoxContainer.new()
	_container_panel.add_child(_container_title)
	
	_button_left = WIconButton.new()
	_container_title.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	
	_label = Label.new()
	_container_title.add_child(_label)
	_label.size_flags_horizontal = SIZE_EXPAND_FILL
	_label.size_flags_vertical = SIZE_EXPAND_FILL
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	_button_right = WIconButton.new()
	_container_title.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)


func _resize() -> void:
	_button_left.custom_minimum_size = Vector2(size[1], 0)
	_button_right.custom_minimum_size = Vector2(size[1], 0)


func _on_button_left_pressed() -> void:
	left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	right_button_pressed.emit()
