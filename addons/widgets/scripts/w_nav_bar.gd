@tool
class_name WNavBar
extends "res://addons/widgets/scripts/w_control.gd"
## Widget with two [WIconButton] and a [Label] in the middle. Buttons are pushed
## to left/right sides. Intended to be placed at the top/bottom of the scene
## (left/right buttons), but it can also be placed on sides if rotated.


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

## [WNavBar] text.
@export var text: String:
	set(text_):
		text = text_
		_label.text = text
		_set_custom_minimum_size(get_combined_minimum_size())
@export_enum(
	"Left",
	"Center",
	"Right"
)
## [WNavBar] text horizontal alignment.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		_label.horizontal_alignment = alignment
@export_group("Left button", "left")
## Left [WIconButton] texture.
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_button_left.texture = left_texture
		_set_button_left_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], left [WIconButton] texture is flipped horizontally.
@export var left_flip_h: bool:
	set(left_flip_h_):
		left_flip_h = left_flip_h_
		_button_left.flip_h = left_flip_h
## If [code]true[/code], left [WIconButton] texture is flipped vertically.
@export var left_flip_v: bool:
	set(left_flip_v_):
		left_flip_v = left_flip_v_
		_button_left.flip_v = left_flip_v
## If [code]true[/code], left [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var left_disabled: bool:
	set(left_disabled_):
		left_disabled = left_disabled_
		_button_left.disabled = left_disabled
@export_group("Right button", "right")
## Right [WIconButton] texture.
@export var right_texture: Texture2D:
	set(right_texture_):
		right_texture = right_texture_
		_button_right.texture = right_texture
		_set_button_right_custom_minimum_size()
		_set_custom_minimum_size(get_combined_minimum_size())
## If [code]true[/code], right [WIconButton] texture is flipped horizontally.
@export var right_flip_h: bool:
	set(right_flip_h_):
		right_flip_h = right_flip_h_
		_button_right.flip_h = right_flip_h
## If [code]true[/code], right [WIconButton] texture is flipped vertically.
@export var right_flip_v: bool:
	set(right_flip_v_):
		right_flip_v = right_flip_v_
		_button_right.flip_v = right_flip_v
## If [code]true[/code], right [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var right_disabled: bool:
	set(right_disabled_):
		right_disabled = right_disabled_
		_button_right.disabled = right_disabled

# Main widget container.
var _container_panel: PanelContainer
# Container of the buttons and the label. BLB: button, label, button.
var _container_blb: HBoxContainer
# [Label] for the text.
var _label: Label
# Left [WIconButton].
var _button_left: WIconButton
# Right [WIconButton].
var _button_right: WIconButton


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_container_panel = PanelContainer.new()
	add_child(_container_panel, false, Node.INTERNAL_MODE_BACK)
	
	_container_blb = HBoxContainer.new()
	_container_panel.add_child(_container_blb)
	
	_button_left = WIconButton.new()
	_container_blb.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	
	_label = Label.new()
	_container_blb.add_child(_label)
	_label.size_flags_horizontal = SIZE_EXPAND_FILL
	_label.size_flags_vertical = SIZE_EXPAND_FILL
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	_button_right = WIconButton.new()
	_container_blb.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)


func _ready() -> void:
	_set_button_left_custom_minimum_size()
	_set_button_right_custom_minimum_size()
	_set_custom_minimum_size(get_combined_minimum_size())


func _resize_children() -> void:
	_container_panel.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _container_blb.get_combined_minimum_size()
	return widget_minimum_size


func _set_button_left_custom_minimum_size() -> void:
	if left_texture == null:
		_button_left.custom_minimum_size.x = 0
	else:
		_button_left.custom_minimum_size.x = _container_panel.size.y


func _set_button_right_custom_minimum_size() -> void:
	if right_texture == null:
		_button_right.custom_minimum_size.x = 0
	else:
		_button_right.custom_minimum_size.x = _container_panel.size.y


func _on_button_left_pressed() -> void:
	left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	right_button_pressed.emit()
