@tool
class_name WPopupB1
extends Control
## A popup with one button.

## Emitted when the background button is pressed.
signal background_pressed
## Emitted when the popup button is pressed.
signal button_pressed

## Enum corresponding to [_button] size flags horizontal.
enum {
	FILL,
	SHRINK_BEGIN,
	SHRINK_CENTER,
	SHRINK_END
}

## Popup/dismiss animation duration. Not intended to be changed during runtime.
@export_range(0, 2, 0.25, "or_greater") var animation_lenght: float = 1
@export_group("Title")
## Popup title.
@export var title: String:
	set(title_):
		title = title_
		_label_title.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Title horizontal alignment.
var title_horizontal_alignment: int:
	set(title_horizontal_alignment_):
		title_horizontal_alignment = title_horizontal_alignment_
		_label_title.horizontal_alignment = title_horizontal_alignment
@export_group("Message")
## Popup message.
@export_multiline var message: String:
	set(message_):
		message = message_
		_label_message.text = message
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Message horizontal alignment.
var message_horizontal_alignment: int:
	set(message_horizontal_alignment_):
		message_horizontal_alignment = message_horizontal_alignment_
		_label_message.horizontal_alignment = message_horizontal_alignment
@export_group("Button")
## Popup button text.
@export var button_text: String:
	set(button_text_):
		button_text = button_text_
		_button.text = button_text
@export_enum(
	"Fill",
	"Shrink begin",
	"Shrink center",
	"Shrink end"
)
## Popup button size flags horizontal.
var button_size_flags_horizontal: int:
	set(button_size_flags_horizontal_):
		button_size_flags_horizontal = button_size_flags_horizontal_
		_set_button_size_flags_horizontal()
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
		_button.focus_mode = buttons_focus_mode

## Background [Button].
var _button_background: Button
## External [MarginContainer] for setting popup size.
var _margin_container_external: MarginContainer
## [PanelContainer] for popup contents background.
var _panel_container: PanelContainer
## Internal [MarginContainer] for internal margins.
var _margin_container_internal: MarginContainer
## [VBoxContainer] for popup contents.
var _container: VBoxContainer
## [Label] for popup title.
var _label_title: Label
## [Label] for popup message.
var _label_message: Label
## [Button] for popup button.
var _button: Button
## [Tween] for showing the popup.
var _tween_popup: Tween
## [Tween] for hiding the popup.
var _tween_dismiss: Tween


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _button_background #######################################################
	_button_background = Button.new()
	add_child(_button_background, false, Node.INTERNAL_MODE_BACK)
	_button_background.pressed.connect(_on_button_background_pressed)
	_button_background.focus_mode = FOCUS_NONE
	# _margin_container_external ###############################################
	_margin_container_external = MarginContainer.new()
	_button_background.add_child(_margin_container_external)
	_margin_container_external.add_theme_constant_override("margin_left", 50)
	_margin_container_external.add_theme_constant_override("margin_top", 500)
	_margin_container_external.add_theme_constant_override("margin_right", 50)
	_margin_container_external.add_theme_constant_override("margin_bottom", 500)
	# _panel_container #########################################################
	_panel_container = PanelContainer.new()
	_margin_container_external.add_child(_panel_container)
	# _margin_container_internal ###############################################
	_margin_container_internal = MarginContainer.new()
	_panel_container.add_child(_margin_container_internal)
	_margin_container_internal.add_theme_constant_override("margin_left", 50)
	_margin_container_internal.add_theme_constant_override("margin_top", 50)
	_margin_container_internal.add_theme_constant_override("margin_right", 50)
	_margin_container_internal.add_theme_constant_override("margin_bottom", 50)
	# _container ###############################################################
	_container = VBoxContainer.new()
	_margin_container_internal.add_child(_container)
	_container.add_theme_constant_override("separation", 0)
	# _label_title #############################################################
	_label_title = Label.new()
	_container.add_child(_label_title)
	_label_title.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_title.size_flags_vertical = SIZE_SHRINK_BEGIN
	# _label_message ###########################################################
	_label_message = Label.new()
	_container.add_child(_label_message)
	_label_message.size_flags_horizontal = SIZE_EXPAND_FILL
	_label_message.size_flags_vertical = SIZE_EXPAND_FILL
	# _button ##################################################################
	_button = Button.new()
	_container.add_child(_button)
	_button.pressed.connect(_on_button_pressed)
	_button.size_flags_vertical = SIZE_SHRINK_END
	_button.focus_mode = FOCUS_NONE


func _resize_children() -> void:
	_button_background.size = size
	_margin_container_external.size = size


func _set_button_size_flags_horizontal() -> void:
	if button_size_flags_horizontal == FILL:
		_button.size_flags_horizontal = SIZE_EXPAND_FILL
	elif button_size_flags_horizontal == SHRINK_BEGIN:
		_button.size_flags_horizontal = SIZE_SHRINK_BEGIN
	elif button_size_flags_horizontal == SHRINK_CENTER:
		_button.size_flags_horizontal = SIZE_SHRINK_CENTER
	else:
		_button.size_flags_horizontal = SIZE_SHRINK_END


func _on_button_background_pressed() -> void:
	background_pressed.emit()


func _on_button_pressed() -> void:
	button_pressed.emit()


## Called to show the popup.
func popup() -> void:
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
