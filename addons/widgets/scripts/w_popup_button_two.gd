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
@export_group("Theme type variations")
## Outside button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var button_outside_theme_type_variation: String:
	set(button_outside_theme_type_variation_):
		button_outside_theme_type_variation = button_outside_theme_type_variation_
		theme_type_variation = button_outside_theme_type_variation
## Popup container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]PanelContainer[/code].
@export var panel_container_theme_type_variation: String:
	set(panel_container_theme_type_variation_):
		panel_container_theme_type_variation = panel_container_theme_type_variation_
		if panel_container != null:
			panel_container.theme_type_variation = panel_container_theme_type_variation
## Popup margin container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]MarginContainer[/code].
@export var margin_container_theme_type_variation: String:
	set(margin_container_theme_type_variation_):
		margin_container_theme_type_variation = margin_container_theme_type_variation_
		if margin_container != null:
			margin_container.theme_type_variation = margin_container_theme_type_variation
## Popup message container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]VBoxContainer[/code].
@export var message_container_theme_type_variation: String:
	set(message_container_theme_type_variation_):
		message_container_theme_type_variation = message_container_theme_type_variation_
		if message_container != null:
			message_container.theme_type_variation = message_container_theme_type_variation
## Popup title [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var label_title_theme_type_variation: String:
	set(label_title_theme_type_variation_):
		label_title_theme_type_variation = label_title_theme_type_variation_
		if label_title != null:
			label_title.theme_type_variation = label_title_theme_type_variation
## Popup message [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var label_message_theme_type_variation: String:
	set(label_message_theme_type_variation_):
		label_message_theme_type_variation = label_message_theme_type_variation_
		if label_message != null:
			label_message.theme_type_variation = label_message_theme_type_variation
## Popup buttons container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]HBoxContainer[/code].
@export var buttons_container_theme_type_variation: String:
	set(buttons_container_theme_type_variation_):
		buttons_container_theme_type_variation = buttons_container_theme_type_variation_
		if buttons_container != null:
			buttons_container.theme_type_variation = buttons_container_theme_type_variation
## Popup left button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var button_left_theme_type_variation: String:
	set(button_left_theme_type_variation_):
		button_left_theme_type_variation = button_left_theme_type_variation_
		if button_left != null:
			button_left.theme_type_variation = button_left_theme_type_variation
## Popup right button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var button_right_theme_type_variation: String:
	set(button_right_theme_type_variation_):
		button_right_theme_type_variation = button_right_theme_type_variation_
		if button_right != null:
			button_right.theme_type_variation = button_right_theme_type_variation

var animation_player: AnimationPlayer
var panel_container: PanelContainer
var margin_container: MarginContainer
var message_container: VBoxContainer
var label_title: Label
var label_message: Label
var buttons_container: HBoxContainer
var button_left: Button
var button_right: Button


func _enter_tree() -> void:
	pressed.connect(
		func _on_outside_pressed() -> void:
			button_outside_pressed.emit()
	)
	theme_type_variation = button_outside_theme_type_variation
	top_level = true
	size = get_parent().size
	modulate = Color(1, 1, 1, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	
	animation_player = AnimationPlayer.new()
	add_child(animation_player)
	
	panel_container = PanelContainer.new()
	add_child(panel_container)
	panel_container.theme_type_variation = panel_container_theme_type_variation
	
	margin_container = MarginContainer.new()
	panel_container.add_child(margin_container)
	margin_container.theme_type_variation = margin_container_theme_type_variation
	
	message_container = VBoxContainer.new()
	margin_container.add_child(message_container)
	message_container.theme_type_variation = message_container_theme_type_variation
	
	label_title = Label.new()
	message_container.add_child(label_title)
	label_title.theme_type_variation = label_title_theme_type_variation
	label_title.text = label_title_text
	label_title.horizontal_alignment = label_title_horizontal_alignment
	
	label_message = Label.new()
	message_container.add_child(label_message)
	label_message.theme_type_variation = label_message_theme_type_variation
	label_message.text = label_message_text
	label_message.horizontal_alignment = label_message_horizontal_alignment
	
	buttons_container = HBoxContainer.new()
	message_container.add_child(buttons_container)
	buttons_container.theme_type_variation = buttons_container_theme_type_variation
	buttons_container.size_flags_horizontal = buttons_container_size_flags_horizontal
	
	button_left = Button.new()
	buttons_container.add_child(button_left)
	button_left.pressed.connect(
		func _on_button_left_popup_pressed() -> void:
			button_left_popup_pressed.emit()
	)
	button_left.theme_type_variation = button_left_theme_type_variation
	button_left.text = button_left_text
	button_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	button_right = Button.new()
	buttons_container.add_child(button_right)
	button_right.pressed.connect(
		func _on_button_right_popup_pressed() -> void:
			button_right_popup_pressed.emit()
	)
	button_right.theme_type_variation = button_right_theme_type_variation
	button_right.text = button_right_text
	button_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
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
