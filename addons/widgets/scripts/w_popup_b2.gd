@tool
class_name WPopupB2
extends Control
## A popup with two buttons.


## Emitted when the popup is popuped (animation start).
signal popuped
## Emitted when the popup is dismissed (animation end).
signal dismissed
## Emitted when the background button is pressed.
signal background_pressed
## Emitted when the popup left button is pressed.
signal left_button_pressed
## Emitted when the popup right button is pressed.
signal right_button_pressed

## Enum corresponding to [param buttons_focus_mode].
enum {
	BUTTONS_FOCUS_NONE,
	BUTTONS_FOCUS_CLICK,
	BUTTONS_FOCUS_ALL
}

## Enum corresponding to [param title_alignment] and [param message_alignment].
enum {
	ALIGNMENT_LEFT,
	ALIGNMENT_CENTER,
	ALIGNMENT_RIGHT
}

## Enum corresponding to [param sizing].
enum {
	SIZING_SHRINK_LEFT,
	SIZING_SHRINK_CENTER,
	SIZING_RIGHT,
	SIZING_FILL,
}

## The left button's text that will be displayed inside the button's area.
@export var left_button_text: String:
	set(left_button_text_):
		left_button_text = left_button_text_
		_button_left.text = left_button_text
		_resize()
## The right button's text that will be displayed inside the button's area.
@export var right_button_text: String:
	set(right_button_text_):
		right_button_text = right_button_text_
		_button_right.text = right_button_text
		_resize()
@export_category("WPopup")
@export_enum(
	"None",
	"Click",
	"All"
)
## [param focus_mode] for the popup buttons.
var buttons_focus_mode: int:
	set(buttons_focus_mode_):
		buttons_focus_mode = buttons_focus_mode_
		_popup.buttons_focus_mode = buttons_focus_mode
		_button_left.focus_mode = buttons_focus_mode
		_button_right.focus_mode = buttons_focus_mode
## Popup/dismiss animation duration. Not intended to be changed during runtime.
@export_range(0, 0, 0.25, "or_greater") var animation_lenght: float = 1:
	set(animation_lenght_):
		animation_lenght = animation_lenght_
		_popup.animation_lenght = animation_lenght
## Separation between the title, message and buttons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		_popup.separation = separation
		_resize()
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_popup.title_text = title_text
		_resize()
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Title horizontal alignment.
var title_alignment: int:
	set(title_alignment_):
		title_alignment = title_alignment_
		_popup.title_alignment = title_alignment
@export_group("Message", "message")
## Popup message.
@export_multiline var message_text: String:
	set(message_text_):
		message_text = message_text_
		_popup.message_text = message_text
		_resize()
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Message horizontal alignment.
var message_alignment: int:
	set(message_alignment_):
		message_alignment = message_alignment_
		_popup.message_alignment = message_alignment
@export_group("External Margin", "external_margin")
## Left external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_left: int:
	set(external_margin_left_):
		external_margin_left = external_margin_left_
		_popup.external_margin_left = external_margin_left
		_resize()
## Top external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_top: int:
	set(external_margin_top_):
		external_margin_top = external_margin_top_
		_popup.external_margin_top = external_margin_top
		_resize()
## Right external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_right: int:
	set(external_margin_right_):
		external_margin_right = external_margin_right_
		_popup.external_margin_right = external_margin_right
		_resize()
## Bottom external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_bottom: int:
	set(external_margin_bottom_):
		external_margin_bottom = external_margin_bottom_
		_popup.external_margin_bottom = external_margin_bottom
		_resize()
@export_group("Internal Margin", "internal_margin")
## Left internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_left: int:
	set(internal_margin_left_):
		internal_margin_left = internal_margin_left_
		_popup.internal_margin_left = internal_margin_left
		_resize()
## Top internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_top: int:
	set(internal_margin_top_):
		internal_margin_top = internal_margin_top_
		_popup.internal_margin_top = internal_margin_top
		_resize()
## Right internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_right: int:
	set(internal_margin_right_):
		internal_margin_right = internal_margin_right_
		_popup.internal_margin_right = internal_margin_right
		_resize()
## Bottom internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_bottom: int:
	set(internal_margin_bottom_):
		internal_margin_bottom = internal_margin_bottom_
		_popup.internal_margin_bottom = internal_margin_bottom
		_resize()
@export_category("WHSizingContainer")
## Separation between the the buttons.
@export_range(0, 0, 1, "or_greater") var buttons_separation: int = 4:
	set(buttons_separation_):
		buttons_separation = buttons_separation_
		_container_buttons.separation = buttons_separation
		_resize()
@export_enum(
	"Shrink Left",
	"Shrink Center",
	"Shrink Right",
	"Fill"
)
## Buttons' size and position mode.
var sizing: int:
	set(sizing_):
		sizing = sizing_
		_container_buttons.sizing = sizing

# Base [WPopup].
var _popup: WPopup
# [WHSizingContainer] for the buttons.
var _container_buttons: WHSizingContainer
# Popup left [Button].
var _button_left: Button
# Popup right [Button].
var _button_right: Button


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_popup = WPopup.new()
	add_child(_popup)
	_popup.background_pressed.connect(_on_background_pressed)
	
	_container_buttons = WHSizingContainer.new()
	_popup.add_buttons_container(_container_buttons)
	_popup.popuped.connect(_on_popup_popuped)
	_popup.popuped.connect(_on_popup_dismissed)
	_container_buttons.size_flags_vertical = SIZE_SHRINK_END
	_container_buttons.size_flags_horizontal = SIZE_EXPAND_FILL
	
	_button_left = Button.new()
	_container_buttons.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	_button_left.focus_mode = FOCUS_NONE
	
	_button_right = Button.new()
	_container_buttons.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)
	_button_right.focus_mode = FOCUS_NONE


func _resize() -> void:
	custom_minimum_size = _popup.custom_minimum_size + \
		_container_buttons.get_combined_minimum_size()
	
	_popup.size = size


func _on_popup_popuped() -> void:
	popuped.emit()


func _on_popup_dismissed() -> void:
	dismissed.emit()


func _on_background_pressed() -> void:
	background_pressed.emit()


func _on_button_left_pressed() -> void:
	left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	right_button_pressed.emit()


func popup() -> void:
	visible = true
	_popup.popup()


func dismiss() -> void:
	_popup.dismiss()
	await _popup.dismissed
	visible = false
