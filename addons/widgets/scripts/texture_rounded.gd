@tool
class_name TextureRounded
extends TextureRect
## Like [code]TextureRect[/code] but with rounded corners.
##
## Known issues:
## 1) If 'strecth_mode = keep_aspect_covered', texture borders might be not
## visible, since they are outside the node rectangle (although they are rounded).
## 2) It is recommended to reload the scene if you changed the node properties
## and you get weird results in the Editor. It seems that they are not updated
## correctly.


const SHADER: Shader = preload("res://addons/widgets/shaders/rounded_corners.gdshader")

## The calculated radius will be multiplied by [param radius_scale]. The initial
## radius is calculated as [code]min(size.x, size.y)[/code].
@export_range(0, 1, 0.1) var radius_scale: float = 0.1:
	set(radius_scale_):
		radius_scale = radius_scale_
		material.set_shader_parameter("radius_scale", radius_scale)
## Enable/disable rounded top left corner.
@export var rounded_top_left_corner: bool = true:
	set(rounded_top_left_corner_):
		rounded_top_left_corner = rounded_top_left_corner_
		material.set_shader_parameter(
			"rounded_top_left_corner",
			rounded_top_left_corner
		)
## Enable/disable rounded top right corner.
@export var rounded_top_right_corner: bool = true:
	set(rounded_top_right_corner_):
		rounded_top_right_corner = rounded_top_right_corner_
		material.set_shader_parameter(
			"rounded_top_right_corner",
			rounded_top_right_corner
		)
## Enable/disable rounded bottom left corner.
@export var rounded_bottom_left_corner: bool = true:
	set(rounded_bottom_left_corner_):
		rounded_bottom_left_corner = rounded_bottom_left_corner_
		material.set_shader_parameter(
			"rounded_bottom_left_corner",
			rounded_bottom_left_corner
		)
## Enable/disable rounded bottom left corner.
@export var rounded_bottom_right_corner: bool = true:
	set(rounded_bottom_right_corner_):
		rounded_bottom_right_corner = rounded_bottom_right_corner_
		material.set_shader_parameter(
			"rounded_bottom_right_corner",
			rounded_bottom_right_corner
		)

var shader_material: ShaderMaterial


func _enter_tree() -> void:
	shader_material = ShaderMaterial.new()
	shader_material.shader = SHADER
	material = shader_material
	material.set_shader_parameter("radius_scale", radius_scale)
	material.set_shader_parameter(
		"rounded_top_left_corner",
		rounded_top_left_corner
	)
	material.set_shader_parameter(
		"rounded_top_right_corner",
		rounded_top_right_corner
	)
	material.set_shader_parameter(
		"rounded_bottom_left_corner",
		rounded_bottom_left_corner
	)
	material.set_shader_parameter(
		"rounded_bottom_right_corner",
		rounded_bottom_right_corner
	)


func _ready() -> void:
	item_rect_changed.connect(
		func _on_item_rect_changed():
		shader_material.set_shader_parameter("width", size.x)
		shader_material.set_shader_parameter("height", size.y)
	)
	item_rect_changed.emit()
