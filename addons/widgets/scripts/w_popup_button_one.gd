@tool
class_name WPopupButtonOne
extends Button
## A popup with one button.


## Emitted when the outside button is pressed.
signal button_outside_pressed
## Emitted when the popup button is pressed.
signal button_popup_pressed

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
@export_subgroup("Buttons", "button")
## Popup button text.
@export var button_text: String:
	set(button_text_):
		button_text = button_text_
		if button != null:
			button.text = button_text
@export_group("Size Flags")
@export_enum(
	"Size Shrink Begin:0",
	"Size Fill:1",
	"Size Expand:2",
	"Size Expand Fill:3",
	"Size Shrink Center:4",
	"Size Shrink End:8"
)
## Popup button [param size_flags_horizontal].
var button_size_flags_horizontal: int = Control.SIZE_SHRINK_CENTER:
	set(button_size_flags_horizontal_):
		button_size_flags_horizontal = button_size_flags_horizontal_
		if button != null:
			button.size_flags_horizontal = button_size_flags_horizontal
@export_group("Animations")
## Popup/dismiss animation duration. Not intended to be changed during runtime.
@export_range(0, 2, 0.25, "or_greater") var animation_lenght: float = 1

var animation_player: AnimationPlayer
var panel_container: PanelContainer
var margin_container: MarginContainer
var message_container: VBoxContainer
var label_title: Label
var label_message: Label
var button: Button


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
	
	animation_player = AnimationPlayer.new()
	add_child(animation_player)
	
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
	
	button = Button.new()
	message_container.add_child(button)
	button.pressed.connect(
		func _on_button_popup_pressed() -> void:
			button_popup_pressed.emit()
	)
	button.text = button_text
	button.size_flags_horizontal = button_size_flags_horizontal
	
	var animation_library: AnimationLibrary = AnimationLibrary.new()
	var animation: Animation
	# show animation
	animation = Animation.new()
	animation.length = animation_lenght
	animation_library.add_animation("popup", animation)
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(0, str(get_path()) + ":modulate")
	animation.value_track_set_update_mode(0, Animation.UPDATE_CAPTURE)
	animation.track_insert_key(0, animation.length, Color(1, 1, 1, 1))
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(1, str(get_path()) + ":mouse_filter")
	animation.track_insert_key(1, 0, Control.MOUSE_FILTER_STOP)
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(2, str(get_path()) + ":visible")
	animation.track_insert_key(2, 0, true)
	# dismiss animation
	animation = Animation.new()
	animation.length = animation_lenght
	animation_library.add_animation("dismiss", animation)
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(0, str(get_path()) + ":modulate")
	animation.value_track_set_update_mode(0, Animation.UPDATE_CAPTURE)
	animation.track_insert_key(0, animation.length, Color(1, 1, 1, 0))
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(1, str(get_path()) + ":mouse_filter")
	animation.track_insert_key(1, 0, Control.MOUSE_FILTER_IGNORE)
	# I don't know why but if I do this like an animation, it is hidden abruptly.
	animation_player.animation_finished.connect(
		func _on_hide(anim_name: StringName) -> void:
			if anim_name == "dismiss":
				visible = false
	)
	
	animation_player.add_animation_library("", animation_library)


func _ready() -> void:
	# Panel size is set after all its childrens are added
	panel_container.position = (size  - panel_container.size)/2.0


## Called to show the popup.
func popup() -> void:
	get_viewport().gui_release_focus()
	animation_player.stop(true)
	animation_player.play("popup")


## Called to dismiss the popup.
func dismiss() -> void:
	get_viewport().gui_release_focus()
	animation_player.stop(true)
	animation_player.play("dismiss")
