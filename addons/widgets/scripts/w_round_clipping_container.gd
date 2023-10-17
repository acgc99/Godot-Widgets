@tool
class_name WRoundClippingContainer
extends PanelContainer
## Widget that acts like a mask of a [StyleBoxFlat] with rounded corners plus
## clipping childrens. Don't modificate its "theme_override_styles/panel".


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
		_stylebox.corner_detail = corner_detail
@export_group("Corner Radius", "corner_radius")
## The top-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_left: int:
	set(corner_radius_top_left_):
		corner_radius_top_left = corner_radius_top_left_
		_stylebox.corner_radius_top_left = corner_radius_top_left
## The top-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_top_right: int:
	set(corner_radius_top_right_):
		corner_radius_top_right = corner_radius_top_right_
		_stylebox.corner_radius_top_right = corner_radius_top_right
## The bottom-right corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_right: int:
	set(corner_radius_bottom_right_):
		corner_radius_bottom_right = corner_radius_bottom_right_
		_stylebox.corner_radius_bottom_right = corner_radius_bottom_right
## The bottom-left corner's radius. If [code]0[/code], the corner is not rounded.
@export_range(0, 0, 1, "or_greater") var corner_radius_bottom_left: int:
	set(corner_radius_bottom_left_):
		corner_radius_bottom_left = corner_radius_bottom_left_
		_stylebox.corner_radius_bottom_left = corner_radius_bottom_left

var _stylebox: StyleBoxFlat


func _init() -> void:
	clip_children = CLIP_CHILDREN_ONLY
	_stylebox = StyleBoxFlat.new()
	add_theme_stylebox_override("panel", _stylebox)
