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
@export var left_icon: Texture2D:
	set(left_icon_):
		left_icon = left_icon_
		_navbar.left_icon = left_icon
## If [code]true[/code], left [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var left_disabled: bool:
	set(left_disabled_):
		left_disabled = left_disabled_
		_navbar.left_disabled = left_disabled
@export_group("Right button", "right")
## Right [WIconButton] texture.
@export var right_icon: Texture2D:
	set(right_icon_):
		right_icon = right_icon_
		_navbar.right_icon = right_icon
## If [code]true[/code], right [WIconButton] is in disabled state and
## can't be clicked or toggled.
@export var right_disabled: bool:
	set(right_disabled_):
		right_disabled = right_disabled_
		_navbar.right_disabled = right_disabled
@export_group("Theme Type Variation WNavBar", "ttv")
## [param theme_type_variation] of background panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		_navbar.ttv_panel = ttv_panel
## [param theme_type_variation] of buttons and label container.
## Base type: [HBoxContainer].
@export var ttv_separation: String:
	set(ttv_separation_):
		ttv_separation = ttv_separation_
		_navbar.ttv_separation = ttv_separation
## [param theme_type_variation] of the label.
## Base type: [Label].
@export var ttv_label: String:
	set(ttv_label_):
		ttv_label = ttv_label_
		_navbar.ttv_label = ttv_label
## [param theme_type_variation] of the left button.
## Base type: [Button].
@export var ttv_left_button: String:
	set(ttv_left_button_):
		ttv_left_button = ttv_left_button_
		_navbar.ttv_left_button = ttv_left_button
## [param theme_type_variation] of the right button.
## Base type: [Button].
@export var ttv_right_button: String:
	set(ttv_right_button_):
		ttv_right_button = ttv_right_button_
		_navbar.ttv_right_button = ttv_right_button


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
