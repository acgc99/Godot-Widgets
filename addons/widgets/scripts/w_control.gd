@tool
class_name WControl
extends Control
## Widget class from which widgets must inherit instead of [Control].
## Override methods on inherited classes, but take care to keep functionalities.


func _ready() -> void:
	_set_custom_minimum_size(get_combined_minimum_size())


func _resize_children() -> void:
	pass


func _set(property: StringName, value: Variant) -> bool:
	if property == "custom_minimum_size":
		_set_custom_minimum_size(value)
		return true
	
	return false


func _set_custom_minimum_size(value: Vector2) -> void:
	var widget_minimum_size: Vector2 = _calculate_widget_minimum_size()
	custom_minimum_size.x = max(value.x, widget_minimum_size.x)
	custom_minimum_size.y = max(value.y, widget_minimum_size.y)


func _calculate_widget_minimum_size() -> Vector2:
	var widget_minimum_size: Vector2
	return widget_minimum_size


func force_minimum_size() -> void:
	custom_minimum_size = _calculate_widget_minimum_size()
