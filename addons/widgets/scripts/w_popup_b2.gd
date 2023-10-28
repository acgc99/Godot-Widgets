@tool
class_name WPopupB2
extends "res://addons/widgets/scripts/w_control.gd"
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
		_set_custom_minimum_size(get_combined_minimum_size())
		_popup.force_minimum_size()
## The right button's text that will be displayed inside the button's area.
@export var right_button_text: String:
	set(right_button_text_):
		right_button_text = right_button_text_
		_button_right.text = right_button_text
		_set_custom_minimum_size(get_combined_minimum_size())
		_popup.force_minimum_size()
@export_group("Theme Type Variation", "ttv")
## [param theme_type_variation] of the left button.
## Base type: [Button].
@export var ttv_left_button: String:
	set(ttv_left_button_):
		ttv_left_button = ttv_left_button_
		_button_left.theme_type_variation = ttv_left_button
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the right button.
## Base type: [Button].
@export var ttv_right_button: String:
	set(ttv_right_button_):
		ttv_right_button = ttv_right_button_
		_button_right.theme_type_variation = ttv_right_button
		_set_custom_minimum_size(get_combined_minimum_size())
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
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_popup.title_text = title_text
		_set_custom_minimum_size(get_combined_minimum_size())
		_popup.force_minimum_size()
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
		_set_custom_minimum_size(get_combined_minimum_size())
		_popup.force_minimum_size()
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
@export_group("Theme Type Variation WPopup", "ttv")
## [param theme_type_variation] of the background button.
## Base type: [Button].
@export var ttv_background: String:
	set(ttv_background_):
		ttv_background = ttv_background_
		_popup.ttv_background = ttv_background
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the popup panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_popup.ttv_panel = ttv_panel
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the title.
## Base type: [Label].
@export var ttv_title: String:
	set(ttv_title_):
		ttv_title = ttv_title_
		_popup.ttv_title = ttv_title
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the message.
## Base type: [Label].
@export var ttv_message: String:
	set(ttv_message_):
		ttv_message = ttv_message_
		_popup.ttv_message = ttv_message
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the title, message and buttons container.
## Base type: [VBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_popup.ttv_separation = ttv_separation
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the external margins.
## Base type: [MarginContainer].
@export var ttv_external_margin: String:
	set(ttv_external_margin_):
		ttv_external_margin = ttv_external_margin_
		_popup.ttv_external_margin = ttv_external_margin
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the internal margins.
## Base type: [MarginContainer].
@export var ttv_internal_margin: String:
	set(ttv_internal_margin_):
		ttv_internal_margin = ttv_internal_margin_
		_popup.ttv_internal_margin = ttv_internal_margin
		_set_custom_minimum_size(get_combined_minimum_size())
@export_category("WHSizingContainer")
## Separation between the the buttons.
#@export_range(0, 0, 1, "or_greater") var buttons_separation: int = 4:
#	set(buttons_separation_):
#		buttons_separation = buttons_separation_
#		_container_buttons.separation = buttons_separation
#		_set_custom_minimum_size(get_combined_minimum_size())
#		_popup.force_minimum_size()
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
@export_group("Theme Type Variation WHSizingContainer", "ttv")
## [param theme_type_variation] of the buttons separation.
## Base type: [HBoxContainer].
@export var ttv_buttons_separation: String:
	set(ttv_buttons_separation_):
		ttv_buttons_separation = ttv_buttons_separation_
		_container_buttons.theme_type_variation = ttv_buttons_separation
		_set_custom_minimum_size(get_combined_minimum_size())

# Base [WPopup].
var _popup: WPopup
# [WHSizingContainer] for the buttons.
var _container_buttons: WHSizingContainer
# Popup left [Button].
var _button_left: Button
# Popup right [Button].
var _button_right: Button


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
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


func _resize_children() -> void:
	_popup.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _popup.get_combined_minimum_size()
	return widget_minimum_size


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
