@tool
class_name WCard
extends "res://addons/widgets/scripts/w_base_button.gd"
## Widget button similar to [WTextureRounded] but with a [WIconLabelIcon] for
## text and icons.


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
## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		_ili.separation = separation
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
@export_group("Margin", "margin")
## Top margin.
@export_range(0, 0, 1, "or_greater") var margin_top: int:
	set(margin_top_):
		margin_top = margin_top_
		_ili.margin_top = margin_top
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
## Bottom margin.
@export_range(0, 0, 1, "or_greater") var margin_bottom: int:
	set(margin_bottom_):
		margin_bottom = margin_bottom_
		_ili.margin_bottom = margin_bottom
		_set_custom_minimum_size(get_combined_minimum_size())
		_ili.force_minimum_size()
@export_category("WRoundClippingContainer")
## This sets the number of vertices used for each corner. Higher values result
## in rounder corners but take more processing power to compute. When choosing
## a value, you should take the corner radius ([method set_corner_radius_all])
## into account.
## [br]
## [br]
## For corner radii less than 10, [code]4[/code] or [code]5[/code] should be
## enough. For corner radii less than 30, values between [code]8[/code] and
## [code]12[/code] should be enough.
## [br]
## [br]
## A corner detail of [code]1[/code] will result in chamfered corners instead
## of rounded corners, which is useful for some artistic effects.
@export_range(1, 20, 1) var corner_detail: int = 8:
	set(corner_detail_):
		corner_detail = corner_detail_
		_container_clipping.corner_detail = corner_detail
@export_group("Corner Radius", "corner_radius")
## The top-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_left: int:
	set(corner_radius_top_left_):
		corner_radius_top_left = corner_radius_top_left_
		_container_clipping.corner_radius_top_left = corner_radius_top_left
## The top-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_right: int:
	set(corner_radius_top_right_):
		corner_radius_top_right = corner_radius_top_right_
		_container_clipping.corner_radius_top_right = corner_radius_top_right
## The bottom-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_right: int:
	set(corner_radius_bottom_right_):
		corner_radius_bottom_right = corner_radius_bottom_right_
		_container_clipping.corner_radius_bottom_right = corner_radius_bottom_right
		_align_elements()
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		_container_clipping.corner_radius_bottom_left = corner_radius_bottom_left
		_align_elements()

# Main widget container. Mask for round clipping.
var _container_clipping: WRoundClippingContainer
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
	
	_texture = TextureRect.new()
	_container_clipping.add_child(_texture)
	_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	_ili = WIconLabelIcon.new()
	_container_clipping.add_child(_ili)
	_ili.size_flags_vertical = Control.SIZE_SHRINK_END


func _resize_children() -> void:
	_container_clipping.size = size


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2 = _ili.get_combined_minimum_size()
	return widget_minimum_size


func _align_elements() -> void:
	_ili.alignment = alignment
	if alignment == ALIGNMENT_LEFT:
		_ili.margin_left = corner_radius_bottom_left
		_ili.margin_right = 0
	elif alignment == ALIGNMENT_CENTER:
		_ili.margin_left = 0
		_ili.margin_right = 0
	else:
		_ili.margin_left = 0
		_ili.margin_right = corner_radius_bottom_right
