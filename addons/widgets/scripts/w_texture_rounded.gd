@tool
class_name WTextureRounded
extends Control
## Widget like [TextureRect] but with rounded corners. Inner child
## [member TextureRect.expand_mode] is fixed to
## [member TextureRect.EXPAND_IGNORE_SIZE].


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
@export_category("WRoundClippingContainer")
@export_group("Theme Type Variation WRoundClippingContainer", "ttv")
## [param theme_type_variation] of panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_container_clipping.theme_type_variation = ttv_panel

# Main widget container. Mask for round clipping.
var _container_clipping: WRoundClippingContainer
# [TextureRect] holding the texture.
var _texture: TextureRect


func _init() -> void:
	item_rect_changed.connect(_resize_children)
	tree_entered.connect(_resize_children)
	
	_container_clipping = WRoundClippingContainer.new()
	add_child(_container_clipping, false, Node.INTERNAL_MODE_BACK)
	
	_texture = TextureRect.new()
	_container_clipping.add_child(_texture)
	_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE


func _resize_children() -> void:
	_container_clipping.size = size
