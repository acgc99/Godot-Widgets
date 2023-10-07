@tool
class_name WPopupButtonTwo
extends Button
## A popup with two buttons.



## Emitted when the outside button is pressed.
signal button_outside_pressed
## Emitted when the left popup button is pressed.
signal button_left_popup_pressed
## Emitted when the right popup button is pressed.
signal button_right_popup_pressed

@export_group("Texts")
@export_subgroup("Title", "label_title")
## Popup title.
@export var label_title_text: String:
	set(label_title_text_):
		label_title_text = label_title_text_
		if label_title != null:
			label_title.text = label_title_text
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## Popup title [param horizontal_alignment].
var label_title_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(label_title_horizontal_alignment_):
		label_title_horizontal_alignment = label_title_horizontal_alignment_
		if label_title != null:
			label_title.horizontal_alignment = label_title_horizontal_alignment
@export_subgroup("Message", "label_message")
## Popup message.
@export_multiline var label_message_text: String:
	set(label_message_text_):
		label_message_text = label_message_text_
		if label_message != null:
			label_message.text = label_message_text
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## Popup message [param horizontal_alignment].
var label_message_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(label_message_horizontal_alignment_):
		label_message_horizontal_alignment = label_message_horizontal_alignment_
		if label_message != null:
			label_message.horizontal_alignment = label_message_horizontal_alignment
@export_subgroup("Buttons")
## Popup left button text.
@export var button_left_text: String:
	set(button_left_text_):
		button_left_text = button_left_text_
		if button_left != null:
			button_left.text = button_left_text
## Popup right button text.
@export var button_right_text: String:
	set(button_right_text_):
		button_right_text = button_right_text_
		if button_right != null:
			button_right.text = button_right_text
@export_group("Size Flags")
@export_enum(
	"Size Shrink Begin:0",
	"Size Fill:1",
	"Size Expand:2",
	"Size Expand Fill:3",
	"Size Shrink Center:4",
	"Size Shrink End:8"
)
## Popup buttons constainer [param size_flags_horizontal].
var buttons_container_size_flags_horizontal: int = Control.SIZE_SHRINK_CENTER:
	set(buttons_container_size_flags_horizontal_):
		buttons_container_size_flags_horizontal = buttons_container_size_flags_horizontal_
		if buttons_container != null:
			buttons_container.size_flags_horizontal = buttons_container_size_flags_horizontal
@export_group("Animations")
## Popup/dismiss animation duration. Not intended to be changed during runtime.
@export_range(0, 2, 0.25, "or_greater") var animation_lenght: float = 1

var panel_container: PanelContainer
var margin_container: MarginContainer
var message_container: VBoxContainer
var label_title: Label
var label_message: Label
var buttons_container: HBoxContainer
var button_left: Button
var button_right: Button
var tween_popup: Tween
var tween_dismiss: Tween


func _enter_tree() -> void:
	pressed.connect(
		func _on_outside_pressed() -> void:
			button_outside_pressed.emit()
	)
	top_level = true
	size = get_parent().size
	modulate = Color(1, 1, 1, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	
	panel_container = PanelContainer.new()
	add_child(panel_container)
	
	margin_container = MarginContainer.new()
	panel_container.add_child(margin_container)
	
	message_container = VBoxContainer.new()
	margin_container.add_child(message_container)
	
	label_title = Label.new()
	message_container.add_child(label_title)
	label_title.text = label_title_text
	label_title.horizontal_alignment = label_title_horizontal_alignment
	
	label_message = Label.new()
	message_container.add_child(label_message)
	label_message.text = label_message_text
	label_message.horizontal_alignment = label_message_horizontal_alignment
	
	buttons_container = HBoxContainer.new()
	message_container.add_child(buttons_container)
	buttons_container.size_flags_horizontal = buttons_container_size_flags_horizontal
	
	button_left = Button.new()
	buttons_container.add_child(button_left)
	button_left.pressed.connect(
		func _on_button_left_popup_pressed() -> void:
			button_left_popup_pressed.emit()
	)
	button_left.text = button_left_text
	button_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	button_right = Button.new()
	buttons_container.add_child(button_right)
	button_right.pressed.connect(
		func _on_button_right_popup_pressed() -> void:
			button_right_popup_pressed.emit()
	)
	button_right.text = button_right_text
	button_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL


func _ready() -> void:
	# Panel size is set after all its childrens are added
	panel_container.position = (size  - panel_container.size)/2.0


## Called to show the popup.
func popup() -> void:
	get_viewport().gui_release_focus()
	if tween_dismiss != null and tween_dismiss.is_running():
		tween_dismiss.kill()
	tween_popup = create_tween()
	tween_popup.tween_property(self, "modulate:a", 1.0, animation_lenght)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true


## Called to dismiss the popup.
func dismiss() -> void:
	get_viewport().gui_release_focus()
	if tween_popup != null and tween_popup.is_running():
		tween_popup.kill()
	tween_dismiss = create_tween()
	tween_dismiss.tween_property(self, "modulate:a", 0.0, animation_lenght)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	await  tween_dismiss.finished
	visible = false
