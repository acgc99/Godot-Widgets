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
## The right button's text that will be displayed inside the button's area.
@export var right_button_text: String:
	set(right_button_text_):
		right_button_text = right_button_text_
		_button_right.text = right_button_text
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
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_popup.title_text = title_text
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
## Message text.
@export_multiline var message_text: String:
	set(message_text_):
		message_text = message_text_
		_popup.message_text = message_text
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
@export_group("External Margin", "margin_external")
## Left external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_left: int:
	set(margin_external_left_):
		margin_external_left = margin_external_left_
		_popup.margin_external_left = margin_external_left
## Top external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_top: int:
	set(margin_external_top_):
		margin_external_top = margin_external_top_
		_popup.margin_external_top = margin_external_top
## Right external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_right: int:
	set(margin_external_right_):
		margin_external_right = margin_external_right_
		_popup.margin_external_right = margin_external_right
## Bottom external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_bottom: int:
	set(margin_external_bottom_):
		margin_external_bottom = margin_external_bottom_
		_popup.margin_external_bottom = margin_external_bottom
@export_group("Internal Margin", "margin_internal")
## Left internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_left: int:
	set(margin_internal_left_):
		margin_internal_left = margin_internal_left_
		_popup.margin_internal_left = margin_internal_left
## Top internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_top: int:
	set(margin_internal_top_):
		margin_internal_top = margin_internal_top_
		_popup.margin_internal_top = margin_internal_top
## Right internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_right: int:
	set(margin_internal_right_):
		margin_internal_right = margin_internal_right_
		_popup.margin_internal_right = margin_internal_right
## Bottom internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_bottom: int:
	set(margin_internal_bottom_):
		margin_internal_bottom = margin_internal_bottom_
		_popup.margin_internal_bottom = margin_internal_bottom
@export_category("WHButtonsContainer")
## Separation between the the buttons.
@export_range(0, 0, 1, "or_greater") var buttons_separation: int = 4:
	set(buttons_separation_):
		buttons_separation = buttons_separation_
		_buttons_container.buttons_separation = buttons_separation
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
		_buttons_container.sizing = sizing

# [WPopup] base.
var _popup: WPopup
# [HBoxContainer] for the buttons.
var _buttons_container: WHButtonsContainer
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
	
	_buttons_container = WHButtonsContainer.new()
	_popup.add_buttons_container(_buttons_container)
	_popup.popuped.connect(_on_popup_popuped)
	_popup.popuped.connect(_on_popup_dismissed)
	_buttons_container.size_flags_vertical = SIZE_SHRINK_END
	_buttons_container.size_flags_horizontal = SIZE_EXPAND_FILL
	
	_button_left = Button.new()
	_buttons_container.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	_button_left.focus_mode = FOCUS_NONE
	
	_button_right = Button.new()
	_buttons_container.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)
	_button_right.focus_mode = FOCUS_NONE


func _resize() -> void:
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
