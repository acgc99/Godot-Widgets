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
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 10, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		if _stylebox != null:
			_stylebox.corner_radius_bottom_left = corner_radius_bottom_left

# [Panelcontainer] containing the texture. It will clip the texture based on its
# panel stylebox.
var _panel_container: PanelContainer
# [TextureRect] holding the texture.
var _texture_rect: TextureRect
# [param _panel_container] [StyleBoxFlat].
var _stylebox: StyleBoxFlat


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	# _panel_container #########################################################
	_panel_container = PanelContainer.new()
	add_child(_panel_container, false, Node.INTERNAL_MODE_BACK)
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


func _resize_children() -> void:
	_panel_container.custom_minimum_size = size
