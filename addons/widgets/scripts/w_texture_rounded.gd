@tool
class_name WTextureRounded
extends TextureRect
## Like [code]TextureRect[/code] but with rounded corners.
##
## Known issues:
## 1) Take care of 'expand_mode' and 'stretch_mode', because image corners
## might be outside node rectangle and therefore clipped. Corners are rounded,
## but they are outside node's rectangle.


const SHADER: Shader = preload("res://addons/widgets/shaders/rounded_corners.gdshader")

## The calculated radius will be multiplied by [param radius_scale]. The initial
## radius is calculated as [code]min(size.x, size.y)[/code].
@export_range(0, 1, 0.1) var radius_scale: float = 0.1:
	set(radius_scale_):
		radius_scale = radius_scale_
		material.set_shader_parameter("radius_scale", radius_scale)
## Enable/disable rounded top left corner.
@export var rounded_corner_top_left: bool = true:
	set(rounded_corner_top_left_):
		rounded_corner_top_left = rounded_corner_top_left_
		material.set_shader_parameter(
			"rounded_corner_top_left",
			rounded_corner_top_left
		)
## Enable/disable rounded top right corner.
@export var rounded_corner_top_right: bool = true:
	set(rounded_corner_top_right_):
		rounded_corner_top_right = rounded_corner_top_right_
		material.set_shader_parameter(
			"rounded_corner_top_right",
			rounded_corner_top_right
		)
## Enable/disable rounded bottom left corner.
@export var rounded_corner_bottom_left: bool = true:
	set(rounded_corner_bottom_left_):
		rounded_corner_bottom_left = rounded_corner_bottom_left_
		material.set_shader_parameter(
			"rounded_corner_bottom_left",
			rounded_corner_bottom_left
		)
## Enable/disable rounded bottom left corner.
@export var rounded_corner_bottom_right: bool = true:
	set(rounded_corner_bottom_right_):
		rounded_corner_bottom_right = rounded_corner_bottom_right_
		material.set_shader_parameter(
			"rounded_corner_bottom_right",
			rounded_corner_bottom_right
		)

var _shader_material: ShaderMaterial


func _enter_tree() -> void:
	item_rect_changed.connect(_reset_shader_params)
	tree_entered.connect(_reset_shader_params)
	# _shader_material #########################################################
	_shader_material = ShaderMaterial.new()
	_shader_material.shader = SHADER
	material = _shader_material
	material.set_shader_parameter("radius_scale", radius_scale)
	material.set_shader_parameter(
		"rounded_corner_top_left",
		rounded_corner_top_left
	)
	material.set_shader_parameter(
		"rounded_corner_top_right",
		rounded_corner_top_right
	)
	material.set_shader_parameter(
		"rounded_corner_bottom_left",
		rounded_corner_bottom_left
	)
	material.set_shader_parameter(
		"rounded_corner_bottom_right",
		rounded_corner_bottom_right
	)


# Signal callables #############################################################


func _reset_shader_params() -> void:
	_shader_material.set_shader_parameter("width", size.x)
	_shader_material.set_shader_parameter("height", size.y)
