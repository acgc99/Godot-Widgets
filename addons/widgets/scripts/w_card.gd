@tool
class_name WCard
extends BaseButton
## Similar to [WTextureRounded] but it is a button and contains a panel for
## a title.

## Enum corresponding to [param title_position].
enum {
	LEFT,
	CENTER,
	RIGHT
}

@export_group("Title")
## [WCard] title.
@export var title: String:
	set(title_):
		title = title_
		if _label != null:
			_label.text = title
@export_enum(
	"Left",
	"Center",
	"Right"
)
# Title position
var title_position: int = CENTER:
	set(title_position_):
		title_position = title_position_
		_positionate_title()
@export_subgroup("Left icon", "icon_left")
## Left icon texture.
@export var icon_left_icon: Texture2D:
	set(icon_left_icon_):
		icon_left_icon = icon_left_icon_
		if _icon_left != null:
			_icon_left.icon = icon_left_icon
			_set_icons_custom_minimum_size()
## If [code]true[/code], left icon texture is flipped horizontally.
@export var icon_left_flip_h: bool:
	set(icon_left_flip_h_):
		icon_left_flip_h = icon_left_flip_h_
		if _icon_left != null:
			_icon_left.flip_h = icon_left_flip_h
## If [code]true[/code], left icon texture is flipped vertically.
@export var icon_left_flip_v: bool:
	set(icon_left_flip_v_):
		icon_left_flip_v = icon_left_flip_v_
		if _icon_left != null:
			_icon_left.flip_v = icon_left_flip_v
@export_subgroup("Right Icon", "icon_right")
## Right icon texture.
@export var icon_right_icon: Texture2D:
	set(icon_right_icon_):
		icon_right_icon = icon_right_icon_
		if _icon_right != null:
			_icon_right.icon = icon_right_icon
			_set_icons_custom_minimum_size()
## If [code]true[/code], right icon texture is flipped horizontally.
@export var icon_right_flip_h: bool:
	set(icon_right_flip_h_):
		icon_right_flip_h = icon_right_flip_h_
		if _icon_right != null:
			_icon_right.flip_h = icon_right_flip_h
## If [code]true[/code], right icon texture is flipped vertically.
@export var icon_right_flip_v: bool:
	set(icon_right_flip_v_):
		icon_right_flip_v = icon_right_flip_v_
		if _icon_right != null:
			_icon_right.flip_v = icon_right_flip_v
@export_group("Background Texture")
## The node's [Texture2D] resource.
@export var texture: Texture2D:
	set(texture_):
		texture = texture_
		if _texture_rect != null:
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
		if _texture_rect != null:
			_texture_rect.stretch_mode = stretch_mode
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
		_positionate_title()
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		_round_clipping_container.corner_radius_bottom_left = corner_radius_bottom_left
		_positionate_title()

# Mask for round clipping.
var _round_clipping_container: WRoundClippingContainer
# [TextureRect] holding the texture.
var _texture_rect: TextureRect
# [PanelContainer] for the [Label].
var _panel_container_label: PanelContainer
# [MarginContainer] for the [Label]. Adds margin when corners are rounded and
# [param _label] horizontal alignment makes text invisible due to
# [_panel_container] clipping its children.
var _margin_container: MarginContainer
# [HBoxContainer] for the title and icons.
var _container: HBoxContainer
# [Label] for the text.
var _label: Label
# [WIcon] for the left icon.
var _icon_left: WIcon
# [WIcon] for the right icon.
var _icon_right: WIcon


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _round_clipping_container ################################################
	_round_clipping_container = WRoundClippingContainer.new()
	add_child(_round_clipping_container, false, Node.INTERNAL_MODE_BACK)
	_round_clipping_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_round_clipping_container.corner_detail = corner_detail
	_round_clipping_container.corner_radius_top_left = corner_radius_top_left
	_round_clipping_container.corner_radius_top_right = corner_radius_top_right
	_round_clipping_container.corner_radius_bottom_right = corner_radius_bottom_right
	_round_clipping_container.corner_radius_bottom_left = corner_radius_bottom_left
	# _texture_rect ############################################################
	_texture_rect = TextureRect.new()
	_round_clipping_container.add_child(_texture_rect)
	_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture_rect.texture = texture
	_texture_rect.stretch_mode = stretch_mode
	# _panel_container_label ###################################################
	_panel_container_label = PanelContainer.new()
	_round_clipping_container.add_child(_panel_container_label)
	_panel_container_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_panel_container_label.size_flags_vertical = Control.SIZE_SHRINK_END
	# _margin_container ########################################################
	_margin_container = MarginContainer.new()
	_panel_container_label.add_child(_margin_container)
	_margin_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# _container ###############################################################
	_container = HBoxContainer.new()
	_margin_container.add_child(_container)
	_container.add_theme_constant_override("separation", 0)
	# _icon_left ###############################################################
	_icon_left = WIcon.new()
	_container.add_child(_icon_left)
	_icon_left.icon = icon_left_icon
	_icon_left.flip_h = icon_left_flip_h
	_icon_left.flip_v = icon_left_flip_v
	# _label ###################################################################
	_label = Label.new()
	_container.add_child(_label)
	_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label.text = title
	# _icon_right ##############################################################
	_icon_right = WIcon.new()
	_container.add_child(_icon_right)
	_icon_right.icon = icon_right_icon
	_icon_right.flip_h = icon_right_flip_h
	_icon_right.flip_v = icon_right_flip_v
	# Others ###################################################################
	_positionate_title()


func _resize_children() -> void:
	_round_clipping_container.custom_minimum_size = size
	_set_icons_custom_minimum_size()


func _set_icons_custom_minimum_size() -> void:
	# _icon_left
	if _icon_left.icon == null:
		_icon_left.custom_minimum_size.x = 0
	else:
		_icon_left.custom_minimum_size.x = _label.size.y
	# _icon_right
	if _icon_right.icon == null:
		_icon_right.custom_minimum_size.x = 0
	else:
		_icon_right.custom_minimum_size.x = _label.size.y


func _positionate_title() -> void:
	if _margin_container == null or _container == null:
		return
	if title_position == LEFT:
		_margin_container.add_theme_constant_override(
			"margin_left",
			corner_radius_bottom_left
		)
		_margin_container.add_theme_constant_override("margin_right", 0)
		_container.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	elif title_position == CENTER:
		_margin_container.add_theme_constant_override("margin_left", 0)
		_margin_container.add_theme_constant_override("margin_right", 0)
		_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	else:
		_margin_container.add_theme_constant_override("margin_left", 0)
		_margin_container.add_theme_constant_override(
			"margin_right",
			corner_radius_bottom_right
		)
		_container.size_flags_horizontal = Control.SIZE_SHRINK_END
