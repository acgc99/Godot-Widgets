@tool
class_name WPopupB2
extends Control
## A popup with two buttons.

## Emitted when the background button is pressed.
signal background_pressed
## Emitted when the left popup button is pressed.
signal left_button_pressed
## Emitted when the right popup button is pressed.
signal right_button_pressed

## Enum corresponding to [_container_buttons] size flags horizontal.
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
		if _label_title != null:
			_label_title.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Title horizontal alignment.
var title_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(title_horizontal_alignment_):
		title_horizontal_alignment = title_horizontal_alignment_
		if _label_title != null:
			_label_title.horizontal_alignment = title_horizontal_alignment
@export_group("Message")
## Popup message.
@export_multiline var message: String:
	set(message_):
		message = message_
		if _label_message != null:
			_label_message.text = message
@export_enum(
	"Left",
	"Center",
	"Right"
)
## Message horizontal alignment.
var message_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(message_horizontal_alignment_):
		message_horizontal_alignment = message_horizontal_alignment_
		if _label_message != null:
			_label_message.horizontal_alignment = message_horizontal_alignment
@export_group("Buttons")
## Popup left button text.
@export var button_left_text: String:
	set(button_left_text_):
		button_left_text = button_left_text_
		if _button_left != null:
			_button_left.text = button_left_text
## Popup right button text.
@export var button_right_text: String:
	set(button_right_text_):
		button_right_text = button_right_text_
		if _button_right != null:
			_button_right.text = button_right_text
@export_enum(
	"Fill",
	"Shrink begin",
	"Shrink center",
	"Shrink end"
)
## Popup button size flags horizontal.
var buttons_size_flags_horizontal: int:
	set(buttons_size_flags_horizontal_):
		buttons_size_flags_horizontal = buttons_size_flags_horizontal_
		if _container_buttons != null:
			_set_buttons_size_flags_horizontal()

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
## Buttons container.
var _container_buttons: HBoxContainer
## [Button] for popup left button.
var _button_left: Button
## [Button] for popup right button.
var _button_right: Button
## [Tween] for showing the popup.
var _tween_popup: Tween
## [Tween] for hiding the popup.
var _tween_dismiss: Tween


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _button_background #######################################################
	_button_background = Button.new()
	add_child(_button_background)
	_button_background.pressed.connect(_on_button_background_pressed)
	_button_background.focus_mode = focus_mode
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
	_label_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_label_title.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	_label_title.text = title
	_label_title.horizontal_alignment = title_horizontal_alignment
	# _label_message ###########################################################
	_label_message = Label.new()
	_container.add_child(_label_message)
	_label_message.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_label_message.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_label_message.text = message
	_label_message.horizontal_alignment = message_horizontal_alignment
	# _container_buttons #######################################################
	_container_buttons = HBoxContainer.new()
	_container.add_child(_container_buttons)
	_container_buttons.size_flags_vertical = Control.SIZE_SHRINK_END
	_container_buttons.add_theme_constant_override("separation", 0)
	# _button_left #############################################################
	_button_left = Button.new()
	_container_buttons.add_child(_button_left)
	_button_left.pressed.connect(_on_button_left_pressed)
	_button_left.focus_mode = focus_mode
	_button_left.text = button_left_text
	# _button_right #############################################################
	_button_right = Button.new()
	_container_buttons.add_child(_button_right)
	_button_right.pressed.connect(_on_button_right_pressed)
	_button_right.focus_mode = focus_mode
	_button_right.text = button_right_text
	# Others ###################################################################
	_set_buttons_size_flags_horizontal()


func _resize_children() -> void:
	_button_background.size = size
	_margin_container_external.size = size


func _set_buttons_size_flags_horizontal() -> void:
	if buttons_size_flags_horizontal == FILL:
		_container_buttons.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		_button_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		_button_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	elif buttons_size_flags_horizontal == SHRINK_BEGIN:
		_container_buttons.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		_button_left.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		_button_right.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	elif buttons_size_flags_horizontal == SHRINK_CENTER:
		_container_buttons.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		_button_left.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		_button_right.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	elif buttons_size_flags_horizontal == SHRINK_END:
		_container_buttons.size_flags_horizontal = Control.SIZE_SHRINK_END
		_button_left.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		_button_right.size_flags_horizontal = Control.SIZE_SHRINK_CENTER


func _on_button_background_pressed() -> void:
	background_pressed.emit()


func _on_button_left_pressed() -> void:
	left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	right_button_pressed.emit()


## Called to show the popup.
func popup() -> void:
	modulate.a = 0
	get_viewport().gui_release_focus()
	if _tween_dismiss != null and _tween_dismiss.is_running():
		_tween_dismiss.kill()
	_tween_popup = create_tween()
	_tween_popup.tween_property(self, "modulate:a", 1.0, animation_lenght)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true


## Called to dismiss the popup.
func dismiss() -> void:
	get_viewport().gui_release_focus()
	if _tween_popup != null and _tween_popup.is_running():
		_tween_popup.kill()
	_tween_dismiss = create_tween()
	_tween_dismiss.tween_property(self, "modulate:a", 0.0, animation_lenght)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	await _tween_dismiss.finished
	visible = false
