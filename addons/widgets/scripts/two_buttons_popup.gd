@tool
class_name TwoButtonsPopup
extends Button
## A popup with two buttons.



## Emitted when the outside button is pressed.
signal outside_button_pressed
## Emitted when the left popup button is pressed.
signal popup_left_button_pressed
## Emitted when the right popup button is pressed.
signal popup_right_button_pressed

@export_group("Texts")
@export_subgroup("Title", "title_label")
## Popup title.
@export var title_label_text: String:
	set(title_label_text_):
		title_label_text = title_label_text_
		if title_label != null:
			title_label.text = title_label_text
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## Popup title [param horizontal_alignment].
var title_label_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(title_label_horizontal_alignment_):
		title_label_horizontal_alignment = title_label_horizontal_alignment_
		if title_label != null:
			title_label.horizontal_alignment = title_label_horizontal_alignment
@export_subgroup("Message", "message_label")
## Popup message.
@export_multiline var message_label_text: String:
	set(message_label_text_):
		message_label_text = message_label_text_
		if message_label != null:
			message_label.text = message_label_text
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## Popup message [param horizontal_alignment].
var message_label_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(message_label_horizontal_alignment_):
		message_label_horizontal_alignment = message_label_horizontal_alignment_
		if message_label != null:
			message_label.horizontal_alignment = message_label_horizontal_alignment
@export_subgroup("Buttons")
## Popup left button text.
@export var left_button_text: String:
	set(left_button_text_):
		left_button_text = left_button_text_
		if left_button != null:
			left_button.text = left_button_text
## Popup right button text.
@export var right_button_text: String:
	set(right_button_text_):
		right_button_text = right_button_text_
		if right_button != null:
			right_button.text = right_button_text
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
@export var outside_button_theme_type_variation: String:
	set(outside_button_theme_type_variation_):
		outside_button_theme_type_variation = outside_button_theme_type_variation_
		theme_type_variation = outside_button_theme_type_variation
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
@export var title_label_theme_type_variation: String:
	set(title_label_theme_type_variation_):
		title_label_theme_type_variation = title_label_theme_type_variation_
		if title_label != null:
			title_label.theme_type_variation = title_label_theme_type_variation
## Popup message [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var message_label_theme_type_variation: String:
	set(message_label_theme_type_variation_):
		message_label_theme_type_variation = message_label_theme_type_variation_
		if message_label != null:
			message_label.theme_type_variation = message_label_theme_type_variation
## Popup buttons container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]HBoxContainer[/code].
@export var buttons_container_theme_type_variation: String:
	set(buttons_container_theme_type_variation_):
		buttons_container_theme_type_variation = buttons_container_theme_type_variation_
		if buttons_container != null:
			buttons_container.theme_type_variation = buttons_container_theme_type_variation
## Popup left button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var left_button_theme_type_variation: String:
	set(left_button_theme_type_variation_):
		left_button_theme_type_variation = left_button_theme_type_variation_
		if left_button != null:
			left_button.theme_type_variation = left_button_theme_type_variation
## Popup right button [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Button[/code].
@export var right_button_theme_type_variation: String:
	set(right_button_theme_type_variation_):
		right_button_theme_type_variation = right_button_theme_type_variation_
		if right_button != null:
			right_button.theme_type_variation = right_button_theme_type_variation

var animation_player: AnimationPlayer
var panel_container: PanelContainer
var margin_container: MarginContainer
var message_container: VBoxContainer
var title_label: Label
var message_label: Label
var buttons_container: HBoxContainer
var left_button: Button
var right_button: Button


func _enter_tree() -> void:
	pressed.connect(
		func _on_outside_pressed() -> void:
			outside_button_pressed.emit()
	)
	theme_type_variation = outside_button_theme_type_variation
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
	
	title_label = Label.new()
	message_container.add_child(title_label)
	title_label.theme_type_variation = title_label_theme_type_variation
	title_label.text = title_label_text
	title_label.horizontal_alignment = title_label_horizontal_alignment
	
	message_label = Label.new()
	message_container.add_child(message_label)
	message_label.theme_type_variation = message_label_theme_type_variation
	message_label.text = message_label_text
	message_label.horizontal_alignment = message_label_horizontal_alignment
	
	buttons_container = HBoxContainer.new()
	message_container.add_child(buttons_container)
	buttons_container.theme_type_variation = buttons_container_theme_type_variation
	buttons_container.size_flags_horizontal = buttons_container_size_flags_horizontal
	
	left_button = Button.new()
	buttons_container.add_child(left_button)
	left_button.pressed.connect(
		func _on_popup_left_button_pressed() -> void:
			popup_left_button_pressed.emit()
	)
	left_button.theme_type_variation = left_button_theme_type_variation
	left_button.text = left_button_text
	left_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	right_button = Button.new()
	buttons_container.add_child(right_button)
	right_button.pressed.connect(
		func _on_popup_right_button_pressed() -> void:
			popup_right_button_pressed.emit()
	)
	right_button.theme_type_variation = right_button_theme_type_variation
	right_button.text = right_button_text
	right_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
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
