@tool
class_name WPopup
extends Control
## A popup without buttons.


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
		_container.add_theme_constant_override("separation", separation)
@export_group("Title", "title")
## Popup title.
@export var title_text: String:
	set(title_text_):
		title_text = title_text_
		_label_title.text = title_text
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
## Message text.
@export_multiline var message_text: String:
	set(message_text_):
		message_text = message_text_
		_label_message.text = message_text
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
@export_group("External Margin", "margin_external")
## Left external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_left: int:
	set(margin_external_left_):
		margin_external_left = margin_external_left_
		_margin_container_external.add_theme_constant_override(
			"margin_left",
			margin_external_left
		)
## Top external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_top: int:
	set(margin_external_top_):
		margin_external_top = margin_external_top_
		_margin_container_external.add_theme_constant_override(
			"margin_top",
			margin_external_top
		)
## Right external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_right: int:
	set(margin_external_right_):
		margin_external_right = margin_external_right_
		_margin_container_external.add_theme_constant_override(
			"margin_right",
			margin_external_right
		)
## Bottom external margin.
@export_range(0, 0, 1, "or_greater") var margin_external_bottom: int:
	set(margin_external_bottom_):
		margin_external_bottom = margin_external_bottom_
		_margin_container_external.add_theme_constant_override(
			"margin_bottom",
			margin_external_bottom
		)
@export_group("Internal Margin", "margin_internal")
## Left internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_left: int:
	set(margin_internal_left_):
		margin_internal_left = margin_internal_left_
		_margin_container_internal.add_theme_constant_override(
			"margin_left",
			margin_internal_left
		)
## Top internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_top: int:
	set(margin_internal_top_):
		margin_internal_top = margin_internal_top_
		_margin_container_internal.add_theme_constant_override(
			"margin_top",
			margin_internal_top
		)
## Right internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_right: int:
	set(margin_internal_right_):
		margin_internal_right = margin_internal_right_
		_margin_container_internal.add_theme_constant_override(
			"margin_right",
			margin_internal_right
		)
## Bottom internal margin.
@export_range(0, 0, 1, "or_greater") var margin_internal_bottom: int:
	set(margin_internal_bottom_):
		margin_internal_bottom = margin_internal_bottom_
		_margin_container_internal.add_theme_constant_override(
			"margin_bottom",
			margin_internal_bottom
		)

# Background [Button].
var _button_background: Button
# External [MarginContainer] for setting popup size.
var _margin_container_external: MarginContainer
# [PanelContainer] for popup contents background.
var _panel_container: PanelContainer
# Internal [MarginContainer] for internal margins.
var _margin_container_internal: MarginContainer
# [VBoxContainer] for popup contents.
var _container: VBoxContainer
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
	
	_margin_container_external = MarginContainer.new()
	_button_background.add_child(_margin_container_external)
	
	_panel_container = PanelContainer.new()
	_margin_container_external.add_child(_panel_container)
	
	_margin_container_internal = MarginContainer.new()
	_panel_container.add_child(_margin_container_internal)
	
	_container = VBoxContainer.new()
	_margin_container_internal.add_child(_container)
	
	_label_title = Label.new()
	_container.add_child(_label_title)
	_label_title.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_title.size_flags_vertical = SIZE_SHRINK_BEGIN
	
	_label_message = Label.new()
	_container.add_child(_label_message)
	_label_message.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_message.size_flags_vertical = SIZE_EXPAND_FILL


func _resize() -> void:
	_button_background.size = size
	_margin_container_external.size = size


func _on_button_background_pressed() -> void:
	background_pressed.emit()


## Adds the buttons container ([HBoxContainer]) to the popup and sets its
## size flags. It does not handle button positions neither sizes.
func add_buttons_container(buttons_container: HBoxContainer) -> void:
	_container.add_child(buttons_container)
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
