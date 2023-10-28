@tool
class_name WRoundClippingContainer
extends PanelContainer
## Widget that acts like a mask of a panel with rounded corners plus
## clipping childrens. Specify corner radii and detail on theme type.


@export_group("Theme Type Variation", "ttv")
## [param theme_type_variation] of panel.
## Base type: [PanelContainer].
@export var ttv_panel: String:
	set(ttv_panel_):
		ttv_panel = ttv_panel_
		theme_type_variation = ttv_panel


func _init() -> void:
	clip_children = CLIP_CHILDREN_ONLY
