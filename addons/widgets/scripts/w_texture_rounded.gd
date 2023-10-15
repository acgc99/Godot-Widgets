@tool
class_name WTextureRounded
extends Control
## Like [TextureRect] but with rounded corners.
## Inner child [member TextureRect.expand_mode] is fixed to
## [member TextureRect.EXPAND_IGNORE_SIZE].


## The node's [Texture2D] resource.
@export var texture: Texture2D:
	set(texture_):
		texture = texture_
		_texture_rect.texture = texture
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
		_texture_rect.stretch_mode = stretch_mode
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
		_round_clipping_container.corner_detail = corner_detail
@export_subgroup("Corner Radius", "corner_radius")
## The top-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_top_left: int:
	set(corner_radius_top_left_):
		corner_radius_top_left = corner_radius_top_left_
		_round_clipping_container.corner_radius_top_left = corner_radius_top_left
## The top-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_top_right: int:
	set(corner_radius_top_right_):
		corner_radius_top_right = corner_radius_top_right_
		_round_clipping_container.corner_radius_top_right = corner_radius_top_right
## The bottom-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_right: int:
	set(corner_radius_bottom_right_):
		corner_radius_bottom_right = corner_radius_bottom_right_
		_round_clipping_container.corner_radius_bottom_right = corner_radius_bottom_right
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		_round_clipping_container.corner_radius_bottom_left = corner_radius_bottom_left

# Mask for round clipping.
var _round_clipping_container: WRoundClippingContainer
# [TextureRect] holding the texture.
var _texture_rect: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _round_clipping_container ################################################
	_round_clipping_container = WRoundClippingContainer.new()
	add_child(_round_clipping_container, false, Node.INTERNAL_MODE_BACK)
	# _texture_rect ############################################################
	_texture_rect = TextureRect.new()
	_round_clipping_container.add_child(_texture_rect)
	_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE


func _resize_children() -> void:
	_round_clipping_container.custom_minimum_size = size
