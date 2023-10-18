@tool
class_name WPopup
extends Control
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
## Separation between the title, message and buttons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		_container_tmb.add_theme_constant_override("separation", separation)
		_resize()
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_label_title.text = title_text
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
		_label_title.horizontal_alignment = title_alignment
@export_group("Message", "message")
## Popup message.
@export_multiline var message_text: String:
	set(message_text_):
		message_text = message_text_
		_label_message.text = message_text
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
		_label_message.horizontal_alignment = message_alignment
@export_group("External Margin", "external_margin")
## Left external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_left: int:
	set(external_margin_left_):
		external_margin_left = external_margin_left_
		_container_margin_external.add_theme_constant_override(
			"margin_left",
			external_margin_left
		)
		_resize()
## Top external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_top: int:
	set(external_margin_top_):
		external_margin_top = external_margin_top_
		_container_margin_external.add_theme_constant_override(
			"margin_top",
			external_margin_top
		)
		_resize()
## Right external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_right: int:
	set(external_margin_right_):
		external_margin_right = external_margin_right_
		_container_margin_external.add_theme_constant_override(
			"margin_right",
			external_margin_right
		)
		_resize()
## Bottom external margin.
@export_range(0, 0, 1, "or_greater") var external_margin_bottom: int:
	set(external_margin_bottom_):
		external_margin_bottom = external_margin_bottom_
		_container_margin_external.add_theme_constant_override(
			"margin_bottom",
			external_margin_bottom
		)
		_resize()
@export_group("Internal Margin", "internal_margin")
## Left internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_left: int:
	set(internal_margin_left_):
		internal_margin_left = internal_margin_left_
		_container_margin_internal.add_theme_constant_override(
			"margin_left",
			internal_margin_left
		)
		_resize()
## Top internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_top: int:
	set(internal_margin_top_):
		internal_margin_top = internal_margin_top_
		_container_margin_internal.add_theme_constant_override(
			"margin_top",
			internal_margin_top
		)
		_resize()
## Right internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_right: int:
	set(internal_margin_right_):
		internal_margin_right = internal_margin_right_
		_container_margin_internal.add_theme_constant_override(
			"margin_right",
			internal_margin_right
		)
		_resize()
## Bottom internal margin.
@export_range(0, 0, 1, "or_greater") var internal_margin_bottom: int:
	set(internal_margin_bottom_):
		internal_margin_bottom = internal_margin_bottom_
		_container_margin_internal.add_theme_constant_override(
			"margin_bottom",
			internal_margin_bottom
		)
		_resize()

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
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
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


func _resize() -> void:
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
	custom_minimum_size = \
		_button_background.get_combined_minimum_size() + \
		_label_title.get_combined_minimum_size() + \
		Vector2(0, _label_message.get_combined_minimum_size().y) + \
		Vector2(0, 3*_container_tmb.get_theme_constant("separation")) + \
		Vector2(margin_lr, margin_tb)
	
	_button_background.size = size
	
	_container_margin_external.size = size


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
