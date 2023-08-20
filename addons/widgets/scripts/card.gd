@tool
class_name Card
extends PanelContainer
## Card. A button with a texture and a label.


## Emitted when the card is pressed.
signal pressed

enum {BOTTOM, TOP}
const SHADER: Shader = preload("res://addons/widgets/shaders/card.gdshader")

@export_group("Texture")
## Background texture.
@export var background_texture: Texture2D:
	set(background_texture_):
		background_texture = background_texture_
		if shader_material != null:
			shader_material.set_shader_parameter("tex", background_texture)
## Corner radius.
@export var corner_radius: int:
	set(corner_radius_):
		corner_radius = corner_radius_
		if style_box != null:
			style_box.corner_radius_top_left = corner_radius
			style_box.corner_radius_top_right = corner_radius
			style_box.corner_radius_bottom_right = corner_radius
			style_box.corner_radius_bottom_left = corner_radius
		if style_box_label_container != null:
			if label_postion == BOTTOM:
				style_box_label_container.corner_radius_bottom_right = corner_radius
				style_box_label_container.corner_radius_bottom_left = corner_radius
			else:
				style_box_label_container.corner_radius_top_left = corner_radius
				style_box_label_container.corner_radius_top_right = corner_radius
@export_group("Card Label", "label")
## Label text.
@export var label_text: String:
	set(label_text_):
		label_text = label_text_
		if label != null:
			label.text = label_text
@export_enum(
	"Bottom",
	"Top"
)
## Label position.
var label_postion: int = BOTTOM:
	set(label_position_):
		label_postion = label_position_
		if label != null:
			if label_postion == BOTTOM:
				label_container.size_flags_vertical = Control.SIZE_SHRINK_END
				style_box_label_container.corner_radius_bottom_right = corner_radius
				style_box_label_container.corner_radius_bottom_left = corner_radius
				style_box_label_container.corner_radius_top_left = 0
				style_box_label_container.corner_radius_top_right = 0
			else:
				label_container.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
				style_box_label_container.corner_radius_top_left = corner_radius
				style_box_label_container.corner_radius_top_right = corner_radius
				style_box_label_container.corner_radius_bottom_right = 0
				style_box_label_container.corner_radius_bottom_left = 0
@export_enum(
	"Horizontal alignment left",
	"Horizontal alignment center",
	"Horizontal alignment right",
	"Horizontal alignment fill"
)
## Label [param horizontal_alignment].
var label_horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(label_horizontal_alignment_):
		label_horizontal_alignment = label_horizontal_alignment_
		if label != null:
			label.horizontal_alignment = label_horizontal_alignment
@export_group("Theme type variations")
## Label [param theme_type_variation].
## The [code]Base Type[/code] must be [code]Label[/code].
@export var label_theme_type_variation: String:
	set(label_theme_type_variation_):
		label_theme_type_variation = label_theme_type_variation_
		if label != null:
			label.theme_type_variation = label_theme_type_variation
## Label margin container [param theme_type_variation].
## The [code]Base Type[/code] must be [code]MarginContainer[/code].
@export var label_margin_container_theme_type_variation: String:
	set(label_margin_container_theme_type_variation_):
		label_margin_container_theme_type_variation = label_margin_container_theme_type_variation_
		if label_margin_container != null:
			label_margin_container.theme_type_variation = label_margin_container_theme_type_variation
@export_subgroup("Label Panel", "label_container")
@export var label_container_color: Color:
	set(label_container_color_):
		label_container_color = label_container_color_
		if style_box_label_container != null:
			style_box_label_container.bg_color = label_container_color

var shader_material: ShaderMaterial
var style_box: StyleBoxFlat
var style_box_label_container: StyleBoxFlat
var button: BaseButton
var label_container: PanelContainer
var label_margin_container: MarginContainer
var label: Label


func _enter_tree() -> void:
	shader_material = ShaderMaterial.new()
	shader_material.shader = SHADER
	shader_material.set_shader_parameter("tex", background_texture)
	material = shader_material
	
	style_box = StyleBoxFlat.new()
	add_theme_stylebox_override("panel", style_box)
	style_box.corner_radius_top_left = corner_radius
	style_box.corner_radius_top_right = corner_radius
	style_box.corner_radius_bottom_right = corner_radius
	style_box.corner_radius_bottom_left = corner_radius
	
	button = BaseButton.new()
	add_child(button)
	button.pressed.connect(func _on_button_pressed(): pressed.emit())
	
	label_container = PanelContainer.new()
	add_child(label_container)
	label_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label_container.custom_minimum_size = Vector2(0, corner_radius)
	label_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	style_box_label_container = StyleBoxFlat.new()
	label_container.add_theme_stylebox_override("panel", style_box_label_container)
	style_box_label_container.bg_color = label_container_color
	# Avoid texture background borders being visible around label_container
	style_box_label_container.expand_margin_top = 0.7
	style_box_label_container.expand_margin_bottom = 0.7
	style_box_label_container.expand_margin_left = 0.7
	style_box_label_container.expand_margin_right = 0.7
	
	if label_postion == BOTTOM:
		label_container.size_flags_vertical = Control.SIZE_SHRINK_END
		style_box_label_container.corner_radius_bottom_right = corner_radius
		style_box_label_container.corner_radius_bottom_left = corner_radius
	else:
		label_container.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		style_box_label_container.corner_radius_top_left = corner_radius
		style_box_label_container.corner_radius_top_right = corner_radius
	
	label_margin_container = MarginContainer.new()
	label_container.add_child(label_margin_container)
	label_margin_container.theme_type_variation = label_margin_container_theme_type_variation
	
	label = Label.new()
	label_margin_container.add_child(label)
	label.theme_type_variation = label_theme_type_variation
	label.text = label_text
	label.horizontal_alignment = label_horizontal_alignment
