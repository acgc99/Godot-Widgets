@tool
class_name WPageContainer
extends VBoxContainer
## Widget to contain an app page. Add contents as children.
## [param VBoxContainer.alignment] is ignored.


## Emitted when the [WNavBar] left button is pressed.
signal navbar_left_button_pressed
## Emitted when the [WNavBar] right button is pressed.
signal navbar_right_button_pressed

## Height of the [WNavBar]. It is only applied if the minimum height of the
## [WNavBar] is smaller than this parameter.
@export var navbar_height: int:
	set(navbar_height_):
		navbar_height = navbar_height_
		_navbar.custom_minimum_size.y = navbar_height
@export_category("WNavBar")
## [WNavBar] text.
@export var text: String:
	set(text_):
		text = text_
		_navbar.text = text
@export_enum(
	"Left",
	"Center",
	"Right"
)
## [WNavBar] text horizontal alignment.
var navbar_alignment: int:
	set(navbar_alignment_):
		navbar_alignment = navbar_alignment_
		_navbar.alignment = navbar_alignment
@export_group("Left button", "left")
## Left [WIconButton] texture.
@export var left_texture: Texture2D:
	set(left_texture_):
		left_texture = left_texture_
		_navbar.left_texture = left_texture
## If [code]true[/code], left [WIconButton] texture is flipped horizontally.
@export var left_flip_h: bool:
	set(left_flip_h_):
		left_flip_h = left_flip_h_
		_navbar.left_flip_h = left_flip_h
## If [code]true[/code], left [WIconButton] texture is flipped vertically.
@export var left_flip_v: bool:
	set(left_flip_v_):
		left_flip_v = left_flip_v_
		_navbar.left_flip_v = left_flip_v
## If [code]true[/code], left [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var left_disabled: bool:
	set(left_disabled_):
		left_disabled = left_disabled_
		_navbar.left_disabled = left_disabled
@export_group("Right button", "right")
## Right [WIconButton] texture.
@export var right_texture: Texture2D:
	set(right_texture_):
		right_texture = right_texture_
		_navbar.right_texture = right_texture
## If [code]true[/code], right [WIconButton] texture is flipped horizontally.
@export var right_flip_h: bool:
	set(right_flip_h_):
		right_flip_h = right_flip_h_
		_navbar.right_flip_h = right_flip_h
## If [code]true[/code], right [WIconButton] texture is flipped vertically.
@export var right_flip_v: bool:
	set(right_flip_v_):
		right_flip_v = right_flip_v_
		_navbar.right_flip_v = right_flip_v
## If [code]true[/code], right [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var right_disabled: bool:
	set(right_disabled_):
		right_disabled = right_disabled_
		_navbar.right_disabled = right_disabled

## Page [WNavBar].
var _navbar: WNavBar


func _init() -> void:
	add_theme_constant_override("separation", 0)
	
	_navbar = WNavBar.new()
	add_child(_navbar)
	_navbar.left_button_pressed.connect(_on_button_left_pressed)
	_navbar.right_button_pressed.connect(_on_button_right_pressed)
	_navbar.size_flags_horizontal = SIZE_EXPAND_FILL


func _on_button_left_pressed() -> void:
	navbar_left_button_pressed.emit()


func _on_button_right_pressed() -> void:
	navbar_right_button_pressed.emit()
