@tool
class_name WCard
extends BaseButton
## Similar to [WTextureRounded] but it is a button and contains a panel for
## a title.

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
## [param title] horizontal alignment.
var horizontal_alignment: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(horizontal_alignment_):
		horizontal_alignment = horizontal_alignment_
		if _label != null:
			_label.horizontal_alignment = horizontal_alignment
			_set_margins()
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
## The top-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_top_left: int:
	set(corner_radius_top_left_):
		corner_radius_top_left = corner_radius_top_left_
		if _stylebox != null:
			_stylebox.corner_radius_top_left = corner_radius_top_left
## The top-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_top_right: int:
	set(corner_radius_top_right_):
		corner_radius_top_right = corner_radius_top_right_
		if _stylebox != null:
			_stylebox.corner_radius_top_right = corner_radius_top_right
## The bottom-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_right: int:
	set(corner_radius_bottom_right_):
		corner_radius_bottom_right = corner_radius_bottom_right_
		if _stylebox != null:
			_stylebox.corner_radius_bottom_right = corner_radius_bottom_right
			_set_margins()
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		if _stylebox != null:
			_stylebox.corner_radius_bottom_left = corner_radius_bottom_left
			_set_margins()

# [Panelcontainer] containing the texture. It will clip the texture based on its
# panel stylebox.
var _panel_container: PanelContainer
# [TextureRect] holding the texture.
var _texture_rect: TextureRect
# [param _panel_container] [StyleBoxFlat].
var _stylebox: StyleBoxFlat
# [PanelContainer] for the [Label].
var _panel_container_label: PanelContainer
# [MarginContainer] for the [Label]. Adds margin when corners are rounded and
# [param _label] horizontal alignment makes text invisible due to
# [_panel_container] clipping its children.
var _margin_container: MarginContainer
# [Label] for the text.
var _label: Label


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _panel_container #########################################################
	_panel_container = PanelContainer.new()
	add_child(_panel_container)
	_panel_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_panel_container.clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	_stylebox = StyleBoxFlat.new()
	_panel_container.add_theme_stylebox_override("panel", _stylebox)
	_stylebox.corner_radius_top_left = corner_radius_top_left
	_stylebox.corner_radius_top_right = corner_radius_top_right
	_stylebox.corner_radius_bottom_right = corner_radius_bottom_right
	_stylebox.corner_radius_bottom_left = corner_radius_bottom_left
	# _texture_rect ############################################################
	_texture_rect = TextureRect.new()
	_panel_container.add_child(_texture_rect)
	_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_texture_rect.texture = texture
	_texture_rect.stretch_mode = stretch_mode
	# _panel_container_label ###################################################
	_panel_container_label = PanelContainer.new()
	_panel_container.add_child(_panel_container_label)
	_panel_container_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_panel_container_label.size_flags_vertical = Control.SIZE_SHRINK_END
	# _margin_container ########################################################
	_margin_container = MarginContainer.new()
	_panel_container_label.add_child(_margin_container)
	_margin_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# _label ###################################################################
	_label = Label.new()
	_margin_container.add_child(_label)
	_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label.horizontal_alignment = horizontal_alignment
	_label.text = title
	
	_set_margins()
#	_margin_container.add_theme_constant_override("margin_left", corner_radius_bottom_left)
#	_margin_container.add_theme_constant_override("margin_right", corner_radius_bottom_right)


func _resize_children() -> void:
	_panel_container.custom_minimum_size = size


func _set_margins() -> void:
	if _margin_container == null:
		return
	if horizontal_alignment == HORIZONTAL_ALIGNMENT_LEFT:
		_margin_container.add_theme_constant_override(
			"margin_left",
			corner_radius_bottom_left
		)
		_margin_container.add_theme_constant_override("margin_right", 0)
	elif horizontal_alignment == HORIZONTAL_ALIGNMENT_CENTER:
		_margin_container.add_theme_constant_override("margin_left", 0)
		_margin_container.add_theme_constant_override("margin_right", 0)
	elif horizontal_alignment == HORIZONTAL_ALIGNMENT_RIGHT:
		_margin_container.add_theme_constant_override("margin_left", 0)
		_margin_container.add_theme_constant_override(
			"margin_right",
			corner_radius_bottom_right
		)
