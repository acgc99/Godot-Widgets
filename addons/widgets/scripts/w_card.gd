@tool
class_name WCard
extends TextureRect
## Like [code]TextureRect[/code] but with rounded corners and a panel for text
## and acts like a button.
##
## 1) If 'strecth_mode = keep_aspect_covered', texture borders might be not
## visible, since they are outside the node rectangle (although they are rounded).
## 2) It is recommended to reload the scene if you changed the node properties
## and you get weird results in the Editor. It seems that they are not updated
## correctly.

## Emitted when the card is pressed.
signal pressed

## Panel positions.
enum{TOP, BOTTOM}
## Label positions.
enum {LEFT, CENTER, RIGHT}

const SHADER: Shader = preload("res://addons/widgets/shaders/rounded_corners_panel.gdshader")

@export_group("Card Image")
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
@export_group("Card Panel")
@export_subgroup("Panel", "panel")
## Panel color.
@export var panel_color: Color = Color.BLACK:
	set(panel_color_):
		panel_color = panel_color_
		material.set_shader_parameter(
			"panel_color",
			panel_color
		)
## Panel length is calculated by multiplying 'radius' and 'panel_scale'.
@export_range(1.0, 3.0, 0.1) var panel_scale: float = 1.0:
	set(panel_scale_):
		panel_scale = panel_scale_
		material.set_shader_parameter(
			"panel_scale",
			panel_scale
		)
@export_enum(
	"Top",
	"Bottom"
)
## Panel position.
var panel_pos: int = BOTTOM:
	set(panel_pos_):
		panel_pos = panel_pos_
		material.set_shader_parameter(
			"panel_pos",
			panel_pos
		)
		if label != null:
			_set_label_position()
@export_subgroup("Label", "label")
## Label text.
@export var label_text: String:
	set(label_text_):
		label_text = label_text_
		if label != null:
			label.text == label_text
@export_enum(
	"Left",
	"Center",
	"Right",
)
## Label position.
var label_pos: int = LEFT:
	set(label_pos_):
		label_pos = label_pos_
		if label != null:
			_set_label_position()

var shader_material: ShaderMaterial
var button: BaseButton
var radius: float
var panel_length: float
var label: Label


func _enter_tree() -> void:
	shader_material = ShaderMaterial.new()
	shader_material.shader = SHADER
	material = shader_material
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
	material.set_shader_parameter(
		"panel_color",
		panel_color
	)
	material.set_shader_parameter(
		"panel_scale",
		panel_scale
	)
	material.set_shader_parameter(
		"panel_pos",
		panel_pos
	)
	
	button = BaseButton.new()
	add_child(button)
	button.pressed.connect(
		func _on_pressed():
			pressed.emit()
	)
	
	label = Label.new()
	add_child(label)
	label.text = label_text
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER


func _ready() -> void:
	item_rect_changed.connect(
		func _on_item_rect_changed():
		shader_material.set_shader_parameter("width", size.x)
		shader_material.set_shader_parameter("height", size.y)
		radius = min(size.x, size.y)*radius_scale
		panel_length = radius*panel_scale
		button.size = size
		_set_label_position()
	)
	item_rect_changed.emit()


## Sets label position.
func _set_label_position() -> void:
	# position.y
	var vertical_offset: float = (panel_length - label.size.y)/2.0
	if panel_pos == TOP:
		label.position.y = vertical_offset
	else:
		label.position.y = vertical_offset + (size.y - panel_length)
	# position.x
	if label_pos == LEFT:
		label.position.x = radius
	elif label_pos == CENTER:
		label.position.x = (size.x - label.size.x)/2.0
	else:
		label.position.x = size.x - radius - label.size.x
