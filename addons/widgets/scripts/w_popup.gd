@tool
class_name WPopup
extends "res://addons/widgets/scripts/w_control.gd"
## Widget popup without buttons.


## Emitted when the popup is popuped (animation start).
signal popuped
## Emitted when the popup is dismissed (animation end).
signal dismissed
## Emitted when the background button is pressed.
signal background_pressed

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

@export_enum(
	"None",
	"Click",
	"All"
)
## [param focus_mode] for the popup buttons.
var buttons_focus_mode: int:
	set(buttons_focus_mode_):
		buttons_focus_mode = buttons_focus_mode_
		_button_background.focus_mode = buttons_focus_mode
## Popup/dismiss animation duration. Not intended to be changed during runtime.
@export_range(0, 0, 0.25, "or_greater") var animation_lenght: float = 1
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_label_title.text = title_text
		_set_custom_minimum_size(get_combined_minimum_size())
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Title horizontal alignment.
var title_alignment: int:
	set(title_alignment_):
		title_alignment = title_alignment_
		_label_title.horizontal_alignment = title_alignment
@export_group("Message", "message")
## Popup message.
@export_multiline var message_text: String:
	set(message_text_):
		message_text = message_text_
		_label_message.text = message_text
		_set_custom_minimum_size(get_combined_minimum_size())
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Message horizontal alignment.
var message_alignment: int:
	set(message_alignment_):
		message_alignment = message_alignment_
		_label_message.horizontal_alignment = message_alignment
@export_group("Theme Type Variation", "ttv")
## [param theme_type_variation] of the background button.
## Base type: [Button].
@export var ttv_background: String:
	set(ttv_background_):
		ttv_background = ttv_background_
		_button_background.theme_type_variation = ttv_background
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the popup panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_container_panel.theme_type_variation = ttv_panel
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the title.
## Base type: [Label].
@export var ttv_title: String:
	set(ttv_title_):
		ttv_title = ttv_title_
		_label_title.theme_type_variation = ttv_title
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the message.
## Base type: [Label].
@export var ttv_message: String:
	set(ttv_message_):
		ttv_message = ttv_message_
		_label_message.theme_type_variation = ttv_message
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the title, message and buttons container.
## Base type: [VBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_container_tmb.theme_type_variation = ttv_separation
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the external margins.
## Base type: [MarginContainer].
@export var ttv_external_margin: String:
	set(ttv_external_margin_):
		ttv_external_margin = ttv_external_margin_
		_container_margin_external.theme_type_variation = ttv_external_margin
		_set_custom_minimum_size(get_combined_minimum_size())
## [param theme_type_variation] of the internal margins.
## Base type: [MarginContainer].
@export var ttv_internal_margin: String:
	set(ttv_internal_margin_):
		ttv_internal_margin = ttv_internal_margin_
		_container_margin_internal.theme_type_variation = ttv_internal_margin
		_set_custom_minimum_size(get_combined_minimum_size())

# Main widget container. Background [Button].
var _button_background: Button
# External margins for setting popup size.
var _container_margin_external: MarginContainer
# Popup contents background.
var _container_panel: PanelContainer
# Internal margins.
var _container_margin_internal: MarginContainer
# Container for popup contents. TMB: title, message and buttons.
var _container_tmb: VBoxContainer
# [Label] for popup title.
var _label_title: Label
# [Label] for popup message.
var _label_message: Label
# [Tween] for showing the popup.
var _tween_popup: Tween
# [Tween] for hiding the popup.
var _tween_dismiss: Tween


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_button_background = Button.new()
	add_child(_button_background, false, Node.INTERNAL_MODE_BACK)
	_button_background.pressed.connect(_on_button_background_pressed)
	_button_background.focus_mode = FOCUS_NONE
	
	_container_margin_external = MarginContainer.new()
	_button_background.add_child(_container_margin_external)
	
	_container_panel = PanelContainer.new()
	_container_margin_external.add_child(_container_panel)
	
	_container_margin_internal = MarginContainer.new()
	_container_panel.add_child(_container_margin_internal)
	
	_container_tmb = VBoxContainer.new()
	_container_margin_internal.add_child(_container_tmb)
	
	_label_title = Label.new()
	_container_tmb.add_child(_label_title)
	_label_title.size_flags_horizontal = SIZE_SHRINK_BEGIN
	_label_title.size_flags_vertical = SIZE_SHRINK_BEGIN
	
	_label_message = Label.new()
	_container_tmb.add_child(_label_message)
	_label_message.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_message.size_flags_vertical = SIZE_EXPAND_FILL
	_label_message.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART


func _resize_children() -> void:
	_button_background.size = size
	_container_margin_external.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var margin_lr: int = 0
	margin_lr += _container_margin_external.get_theme_constant("margin_left")
	margin_lr += _container_margin_external.get_theme_constant("margin_right")
	margin_lr += _container_margin_internal.get_theme_constant("margin_left")
	margin_lr += _container_margin_internal.get_theme_constant("margin_right")
	var margin_tb: int = 0
	margin_tb += _container_margin_external.get_theme_constant("margin_top")
	margin_tb += _container_margin_external.get_theme_constant("margin_bottom")
	margin_tb += _container_margin_internal.get_theme_constant("margin_top")
	margin_tb += _container_margin_internal.get_theme_constant("margin_bottom")
	var widget_minimum_size: Vector2
	widget_minimum_size = \
		_label_title.get_combined_minimum_size() + \
		Vector2(0, _label_message.get_combined_minimum_size().y) + \
		_container_tmb.get_combined_minimum_size() + \
		Vector2(margin_lr, margin_tb)
	return widget_minimum_size


func _on_button_background_pressed() -> void:
	background_pressed.emit()


## Adds the buttons container ([WHButtonsContainer]) to the popup and sets its
## size flags. It does not handle button positions neither sizes.
func add_buttons_container(buttons_container: WHSizingContainer) -> void:
	_container_tmb.add_child(buttons_container)
	buttons_container.size_flags_horizontal = SIZE_EXPAND_FILL
	buttons_container.size_flags_vertical = SIZE_SHRINK_END


## Called to show the popup.
func popup() -> void:
	popuped.emit()
	modulate.a = 0
	get_viewport().gui_release_focus()
	if _tween_dismiss != null and _tween_dismiss.is_running():
		_tween_dismiss.kill()
	_tween_popup = create_tween()
	_tween_popup.tween_property(self, "modulate:a", 1.0, animation_lenght)
	mouse_filter = MOUSE_FILTER_STOP
	visible = true


## Called to dismiss the popup.
func dismiss() -> void:
	get_viewport().gui_release_focus()
	if _tween_popup != null and _tween_popup.is_running():
		_tween_popup.kill()
	_tween_dismiss = create_tween()
	_tween_dismiss.tween_property(self, "modulate:a", 0.0, animation_lenght)
	mouse_filter = MOUSE_FILTER_IGNORE
	await _tween_dismiss.finished
	visible = false
	dismissed.emit()
