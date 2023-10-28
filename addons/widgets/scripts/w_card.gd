@tool
class_name WCard
extends "res://addons/widgets/scripts/w_control.gd"
## Widget button similar to [WTextureRounded] but with a [WIconLabelIcon] for
## text and icons.

signal button_down
signal button_up
signal pressed
signal toggled(button_pressed_: bool)

## Enum corresponding to [param ili_position].
enum {
	ILI_BOTTOM,
	ILI_TOP
}

## Enum corresponding to [param stretch_mode].
enum {
	STRETCH_SCALE,
	STRETCH_TILE,
	STRETCH_KEEP,
	STRETCH_KEEP_CENTERED,
	STRETCH_KEEP_ASPECT,
	STRETCH_KEEP_ASPECT_CENTERED,
	STRETCH_KEEP_ASPECT_COVERED
}

## Enum corresponding to [param alignment].
enum {
	ALIGNMENT_LEFT,
	ALIGNMENT_CENTER,
	ALIGNMENT_RIGHT
}

@export_enum(
	"Bottom",
	"Top"
)
## Position of the [WIconLabelIcon].
var ili_position: int:
	set(ili_position_):
		ili_position = ili_position_
		if ili_position == ILI_BOTTOM:
			_ili.size_flags_vertical = Control.SIZE_SHRINK_END
		else:
			_ili.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
@export_category("Button")
@export_group("Theme Type Variation Button", "ttv")
## [param theme_type_variation] of the button.
## Base type: [Button].
@export var ttv_button: String:
	set(ttv_button_):
		ttv_button = ttv_button_
		_button.theme_type_variation = ttv_button
@export_category("BaseButton")
@export var disabled: bool:
	set(disabled_):
		disabled = disabled_
		_button.disabled = disabled
		if disabled:
			_container_clipping.modulate = _button.get_theme_stylebox("disabled", ttv_button).bg_color
		else:
			_container_clipping.modulate = _button.get_theme_stylebox("normal", ttv_button).bg_color
@export var toggle_mode: bool:
	set(toggle_mode_):
		toggle_mode = toggle_mode_
		_button.toggle_mode = toggle_mode
@export var button_pressed: bool:
	set(button_pressed_):
		button_pressed = button_pressed_
		_button.button_pressed = button_pressed
@export_enum(
	"Button Press",
	"Button Release"
)
var action_mode: int = 1:
	set(action_mode_):
		action_mode = action_mode_
		_button.action_mode = action_mode
@export_flags(
	"Mouse Left",
	"Mouse Right",
	"Mouse Middle"
)
var button_mask: int = 1:
	set(button_mask_):
		button_mask = button_mask_
		_button.button_mask = button_mask
@export var keep_pressed_outside: bool:
	set(keep_pressed_outside_):
		keep_pressed_outside = keep_pressed_outside_
		_button.keep_pressed_outside = keep_pressed_outside
@export var button_group: ButtonGroup:
	set(button_group_):
		button_group = button_group_
		_button.button_group = button_group
@export_group("Shortcut")
@export var shortcut: Shortcut:
	set(shortcut_):
		shortcut = shortcut_
		_button.shortcut = shortcut
@export var shortcut_feedback: bool = true:
	set(shortcut_feedback_):
		shortcut_feedback = shortcut_feedback_
		_button.shortcut_feedback = shortcut_feedback
@export var shortcut_in_tooltip: bool = true:
	set(shortcut_in_tooltip_):
		shortcut_in_tooltip = shortcut_in_tooltip_
		_button.shortcut_in_tooltip = shortcut_in_tooltip
@export_category("TextureRect")
## The node's [Texture2D] resource.
@export var texture: Texture2D:
	set(texture_):
		texture = texture_
		_texture.texture = texture
@export_enum(
	"Scale",
	"Tile",
	"Keep",
	"Keep Centered",
	"Keep Aspect",
	"Keep Aspect Centered",
	"Keep Aspect Covered"
)
## Controls the texture's behavior when resizing the node's bounding rectangle.
## See [member StretchMode].
## [br]
## [br]
## [b]Stretch Scale[/b]: Scale to fit the node's bounding rectangle.
## [br]
## [br]
## [b]Stretch Tile[/b]: Tile inside the node's bounding rectangle.
## [br]
## [br]
## [b]Stretch Keep[/b]: The texture keeps its original size and stays in the
## bounding rectangle's top-left corner.
## [br]
## [br]
## [b]Stretch Keep Centered[/b]: The texture keeps its original size and stays
## centered in the node's bounding rectangle.
## [br]
## [br]
## [b]Stretch Keep Aspect[/b]: Scale the texture to fit the node's bounding
## rectangle, but maintain the texture's aspect ratio.
## [br]
## [br]
## [b]Stretch Keep Aspect Centered[/b]: Scale the texture to fit the node's
## bounding rectangle, center it and maintain its aspect ratio.
## [br]
## [br]
## [b]Stretch Keep Aspect Covered[/b]: Scale the texture so that the shorter
## side fits the bounding rectangle. The other side clips to the node's limits.
var stretch_mode: int:
	set(stretch_mode_):
		stretch_mode = stretch_mode_
		_texture.stretch_mode = stretch_mode
@export_category("WIconLabelIcon")
## [WCard] text.
@export var text: String:
	set(text_):
		text = text_
		_ili.text = text
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
@export_enum(
	"Left",
	"Center",
	"Right"
)
# Text horizontal alignment.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		_align_elements()
@export_group("Left icon", "left")
## Left icon texture.
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_ili.left_texture = left_texture_
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
## If [code]true[/code], left icon texture is flipped horizontally.
@export var left_flip_h: bool:
	set(left_flip_h_):
		left_flip_h = left_flip_h_
		_ili.left_flip_h = left_flip_h
## If [code]true[/code], left icon texture is flipped vertically.
@export var left_flip_v: bool:
	set(left_flip_v_):
		left_flip_v = left_flip_v_
		_ili.left_flip_v = left_flip_v
@export_group("Right Icon", "right")
## Right icon texture.
@export var right_texture: Texture2D:
	set(right_texture_):
		right_texture = right_texture_
		_ili.right_texture = right_texture
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
## If [code]true[/code], right icon texture is flipped horizontally.
@export var right_flip_h: bool:
	set(right_flip_h_):
		right_flip_h_ = right_flip_h
		_ili.right_flip_h = right_flip_h
## If [code]true[/code], right icon texture is flipped vertically.
@export var right_flip_v: bool:
	set(right_flip_v_):
		right_flip_v = right_flip_v_
		_ili.right_flip_v = right_flip_v
@export_group("Theme Type Variation WIconLabelIcon", "ttv")
## [param theme_type_variation] of background panel.
## Base type: [PanelContainer].
@export var ttv_background: String:
	set(ttv_background_):
		ttv_background = ttv_background_
		_ili.ttv_background = ttv_background
## [param theme_type_variation] of margins.
## Base type: [MarginContainer].
@export var ttv_margin: String:
	set(ttv_margin_):
		ttv_margin = ttv_margin_
		_ili.ttv_margin = ttv_margin
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
## [param theme_type_variation] of icons and label container.
## Base type: [HBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_ili.ttv_separation = ttv_separation
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()		
## [param theme_type_variation] of the label.
## Base type: [Label].
@export var ttv_label: String:
	set(ttv_label_):
		ttv_label = ttv_label_
		_ili.ttv_label = ttv_label
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
@export_category("WRoundClippingContainer")
@export_group("Theme Type Variation WRoundClippingContainer", "ttv")
## [param theme_type_variation] of panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_container_clipping.theme_type_variation = ttv_panel
		_align_elements()

# Main widget container. Mask for round clipping.
var _container_clipping: WRoundClippingContainer
## Underlaying button.
var _button: Button
# [TextureRect] holding the texture.
var _texture: TextureRect
# [WIConLabelIcon] for the label and icons.
var _ili: WIconLabelIcon


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_container_clipping = WRoundClippingContainer.new()
	add_child(_container_clipping, false, Node.INTERNAL_MODE_BACK)
	_container_clipping.mouse_filter = MOUSE_FILTER_IGNORE
	
	_button = Button.new()
	_container_clipping.add_child(_button)
	_button.button_down.connect(_on_button_button_down)
	_button.button_up.connect(_on_button_button_up)
	_button.pressed.connect(_on_button_pressed)
	_button.toggled.connect(_on_button_toggled)
	_button.mouse_entered.connect(_on_button_mouse_entered)
	_button.mouse_exited.connect(_on_button_mouse_exited)
	_button.focus_entered.connect(_on_button_focus_entered)
	_button.focus_exited.connect(_on_button_focus_exited)
	
	_texture = TextureRect.new()
	_container_clipping.add_child(_texture)
	_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture.mouse_filter = MOUSE_FILTER_IGNORE
	
	_ili = WIconLabelIcon.new()
	_container_clipping.add_child(_ili)
	_ili.size_flags_vertical = Control.SIZE_SHRINK_END
	_ili.mouse_filter = MOUSE_FILTER_IGNORE


func _ready() -> void:
	if disabled:
		_container_clipping.modulate = _button.get_theme_stylebox("disabled", ttv_button).bg_color
	else:
		_container_clipping.modulate = _button.get_theme_stylebox("normal", ttv_button).bg_color


func _resize_children() -> void:
	_container_clipping.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _ili.get_combined_minimum_size()
	return widget_minimum_size


func _align_elements() -> void:
	_ili.alignment = alignment
	if alignment == ALIGNMENT_LEFT:
		_ili.add_theme_constant_override(
			"margin_left",
			_container_clipping.get_theme_stylebox("panel", ttv_panel).corner_radius_bottom_left
		)
		_ili.add_theme_constant_override("margin_right", 0)
	elif alignment == ALIGNMENT_CENTER:
		_ili.add_theme_constant_override("margin_left", 0)
		_ili.add_theme_constant_override("margin_right", 0)
	else:
		_ili.add_theme_constant_override("margin_left", 0)
		_ili.add_theme_constant_override(
			"margin_right",
			_container_clipping.get_theme_stylebox("panel", ttv_panel).corner_radius_bottom_right
		)


func _on_button_button_down() -> void:
	_container_clipping.modulate = _button.get_theme_stylebox("pressed", ttv_button).bg_color
	button_down.emit()


func _on_button_button_up() -> void:
	# TODO: this requires control over focus mode to fully set focus style
	_container_clipping.modulate = _button.get_theme_stylebox("normal", ttv_button).bg_color
	button_up.emit()


func _on_button_pressed() -> void:
	pressed.emit()


func _on_button_toggled(button_pressed_: bool) -> void:
	toggled.emit(button_pressed_)


func _on_button_mouse_entered() -> void:
	if not disabled:
		_container_clipping.modulate = _button.get_theme_stylebox("hover", ttv_button).bg_color


func _on_button_mouse_exited() -> void:
	if not disabled:
		_container_clipping.modulate = _button.get_theme_stylebox("normal", ttv_button).bg_color


func _on_button_focus_entered() -> void:
	if not disabled:
		_container_clipping.modulate = _button.get_theme_stylebox("focus", ttv_button).bg_color


func _on_button_focus_exited() -> void:
	if not disabled:
		_container_clipping.modulate = _button.get_theme_stylebox("normal", ttv_button).bg_color
