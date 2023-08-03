@tool
class_name IconButton
extends Button
## Button that consists of an icon.


func _enter_tree() -> void:
	flat = true
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	expand_icon = true
	anchors_preset = PRESET_FULL_RECT
	focus_mode = Control.FOCUS_NONE
