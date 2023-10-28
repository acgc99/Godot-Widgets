@tool
class_name WIconButton
extends "res://addons/widgets/scripts/w_control.gd"
## Widget of a button with an icon.


signal button_down
signal button_up
signal pressed
signal toggled(button_pressed_: bool)


@export_category("Button")
## Icon texture.
@export var icon: Texture2D:
	set(icon_):
		icon = icon_
		_button.icon = icon
@export_group("Theme Type Variation Button", "ttv")
## [param theme_type_variation] of the button.
## Base type: [Button].
@export var ttv_button: String:
	set(ttv_button_):
		ttv_button = ttv_button_
		_button.theme_type_variation = ttv_button
@export_category("BaseButton")
@export var disabled: bool:
	set(disabled_):
		disabled = disabled_
		_button.disabled = disabled
@export var toggle_mode: bool:
	set(toggle_mode_):
		toggle_mode = toggle_mode_
		_button.toggle_mode = toggle_mode
@export var button_pressed: bool:
	set(button_pressed_):
		button_pressed = button_pressed_
		_button.button_pressed = button_pressed
@export_enum(
	"Button Press",
	"Button Release"
)
var action_mode: int = 1:
	set(action_mode_):
		action_mode = action_mode_
		_button.action_mode = action_mode
@export_flags(
	"Mouse Left",
	"Mouse Right",
	"Mouse Middle"
)
var button_mask: int = 1:
	set(button_mask_):
		button_mask = button_mask_
		_button.button_mask = button_mask
@export var keep_pressed_outside: bool:
	set(keep_pressed_outside_):
		keep_pressed_outside = keep_pressed_outside_
		_button.keep_pressed_outside = keep_pressed_outside
@export var button_group: ButtonGroup:
	set(button_group_):
		button_group = button_group_
		_button.button_group = button_group
@export_group("Shortcut")
@export var shortcut: Shortcut:
	set(shortcut_):
		shortcut = shortcut_
		_button.shortcut = shortcut
@export var shortcut_feedback: bool = true:
	set(shortcut_feedback_):
		shortcut_feedback = shortcut_feedback_
		_button.shortcut_feedback = shortcut_feedback
@export var shortcut_in_tooltip: bool = true:
	set(shortcut_in_tooltip_):
		shortcut_in_tooltip = shortcut_in_tooltip_
		_button.shortcut_in_tooltip = shortcut_in_tooltip

# Base button.
var _button: Button


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_button = Button.new()
	add_child(_button, false, Node.INTERNAL_MODE_BACK)
	_button.button_down.connect(_on_button_button_down)
	_button.button_up.connect(_on_button_button_up)
	_button.pressed.connect(_on_button_pressed)
	_button.toggled.connect(_on_button_toggled)
	_button.flat = true
	_button.expand_icon = true
	_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_button.action_mode = BaseButton.ACTION_MODE_BUTTON_RELEASE


func _resize_children() -> void:
	_button.size = size


func _on_button_button_down() -> void:
	button_down.emit()


func _on_button_button_up() -> void:
	button_up.emit()


func _on_button_pressed() -> void:
	pressed.emit()


func _on_button_toggled(button_pressed_: bool) -> void:
	toggled.emit(button_pressed_)
