extends Control


@onready var popup_button_one: WPopupButtonOne = $WPopupButtonOne
@onready var popup_button_two: WPopupButtonTwo = $WPopupButtonTwo


func _on_button_one_pressed() -> void:
	popup_button_one.popup()


func _on_button_two_pressed() -> void:
	popup_button_two.popup()


## WPopupButtonOne #############################################################


func _on_w_popup_button_one_outside_button_pressed() -> void:
	popup_button_one.dismiss()


func _on_w_popup_button_one_popup_button_pressed() -> void:
	popup_button_one.dismiss()


## WPopupButtonTwo #############################################################


func _on_w_popup_button_two_outside_button_pressed():
	popup_button_two.dismiss()


func _on_w_popup_button_two_popup_left_button_pressed():
	popup_button_two.dismiss()


func _on_w_popup_button_two_popup_right_button_pressed():
	popup_button_two.dismiss()
