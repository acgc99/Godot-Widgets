@tool
class_name WCard
extends BaseButton
## Similar to [WTextureRounded] but it is a button and contains a panel for
## a title.


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
@export_category("WIconLabelIcon")
## [WCard] title.
@export var title: String:
	set(title_):
		title = title_
		_icon_label_icon.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
# Title horizontal alignment.
var alignment: int:
	set(alignment_):
		alignment = alignment_
		_align_title()
## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		_icon_label_icon.separation = separation
@export_group("Left icon", "icon_left")
## Left icon texture.
@export var icon_left_icon: Texture2D:
	set(icon_left_icon_):
		icon_left_icon = icon_left_icon_
		_icon_label_icon.icon_left_icon = icon_left_icon
## If [code]true[/code], left icon texture is flipped horizontally.
@export var icon_left_flip_h: bool:
	set(icon_left_flip_h_):
		icon_left_flip_h = icon_left_flip_h_
		_icon_label_icon.icon_left_flip_h = icon_left_flip_h
## If [code]true[/code], left icon texture is flipped vertically.
@export var icon_left_flip_v: bool:
	set(icon_left_flip_v_):
		icon_left_flip_v = icon_left_flip_v_
		_icon_label_icon.icon_left_flip_v = icon_left_flip_v
@export_group("Right Icon", "icon_right")
## Right icon texture.
@export var icon_right_icon: Texture2D:
	set(icon_right_icon_):
		icon_right_icon = icon_right_icon_
		_icon_label_icon.icon_right_icon = icon_right_icon
## If [code]true[/code], right icon texture is flipped horizontally.
@export var icon_right_flip_h: bool:
	set(icon_right_flip_h_):
		icon_right_flip_h = icon_right_flip_h_
		_icon_label_icon.icon_right_flip_h = icon_right_flip_h
## If [code]true[/code], right icon texture is flipped vertically.
@export var icon_right_flip_v: bool:
	set(icon_right_flip_v_):
		icon_right_flip_v = icon_right_flip_v_
		_icon_label_icon.icon_right_flip_v = icon_right_flip_v
@export_group("Margin", "margin")
## Top margin.
@export_range(0, 0, 1, "or_greater") var margin_top: int:
	set(margin_top_):
		margin_top = margin_top_
		_icon_label_icon.margin_top = margin_top
## Bottom margin.
@export_range(0, 0, 1, "or_greater") var margin_bottom: int:
	set(margin_bottom_):
		margin_bottom = margin_bottom_
		_icon_label_icon.margin_bottom = margin_bottom
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
@export_group("Corner Radius", "corner_radius")
## The top-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_left: int:
	set(corner_radius_top_left_):
		corner_radius_top_left = corner_radius_top_left_
		_round_clipping_container.corner_radius_top_left = corner_radius_top_left
## The top-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_right: int:
	set(corner_radius_top_right_):
		corner_radius_top_right = corner_radius_top_right_
		_round_clipping_container.corner_radius_top_right = corner_radius_top_right
## The bottom-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_right: int:
	set(corner_radius_bottom_right_):
		corner_radius_bottom_right = corner_radius_bottom_right_
		_round_clipping_container.corner_radius_bottom_right = corner_radius_bottom_right
		_align_title()
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		_round_clipping_container.corner_radius_bottom_left = corner_radius_bottom_left
		_align_title()

# Mask for round clipping.
var _round_clipping_container: WRoundClippingContainer
# [TextureRect] holding the texture.
var _texture_rect: TextureRect
# [WIConLabelIcon] for the label and icons.
var _icon_label_icon: WIconLabelIcon


func _init() -> void:
	item_rect_changed.connect(_resize)
	tree_entered.connect(_resize)
	
	_round_clipping_container = WRoundClippingContainer.new()
	add_child(_round_clipping_container, false, Node.INTERNAL_MODE_BACK)
	_round_clipping_container.mouse_filter = MOUSE_FILTER_IGNORE
	
	_texture_rect = TextureRect.new()
	_round_clipping_container.add_child(_texture_rect)
	_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	_icon_label_icon = WIconLabelIcon.new()
	_round_clipping_container.add_child(_icon_label_icon)
	_icon_label_icon.size_flags_vertical = Control.SIZE_SHRINK_END


func _resize() -> void:
	_round_clipping_container.custom_minimum_size = size


func _align_title() -> void:
	_icon_label_icon.alignment = alignment
	if alignment == ALIGNMENT_LEFT:
		_icon_label_icon.margin_left = corner_radius_bottom_left
		_icon_label_icon.margin_right = 0
	elif alignment == ALIGNMENT_CENTER:
		_icon_label_icon.margin_left = 0
		_icon_label_icon.margin_right = 0
	else:
		_icon_label_icon.margin_left = 0
		_icon_label_icon.margin_right = corner_radius_bottom_right
