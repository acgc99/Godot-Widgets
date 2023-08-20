extends VBoxContainer


@onready var one_button_popup: OneButtonPopup = $OneButtonPopup
@onready var two_buttons_popup: TwoButtonsPopup = $TwoButtonsPopup


# Popup singals ################################################################


func _on_one_button_popup_popup_button_pressed() -> void:
	one_button_popup.dismiss()


func _on_one_button_popup_outside_button_pressed() -> void:
	one_button_popup.dismiss()


func _on_two_buttons_popup_outside_button_pressed() -> void:
	two_buttons_popup.dismiss()


func _on_two_buttons_popup_popup_left_button_pressed() -> void:
	two_buttons_popup.dismiss()


func _on_two_buttons_popup_popup_right_button_pressed() -> void:
	two_buttons_popup.dismiss()


# Other signals ################################################################


func _on_one_button_popup_button_pressed() -> void:
	one_button_popup.popup()


func _on_two_button_popup_button_pressed() -> void:
	two_buttons_popup.popup()
