extends Control


@onready var popup_button_one: WPopupButtonOne = $WPopupButtonOne
@onready var popup_button_two: WPopupButtonTwo = $WPopupButtonTwo

func _ready():
	$Page/Contents/MarginContainer/VBoxContainer/WFilteredLineEdit.clamp_text()
	$Page/Contents/MarginContainer/VBoxContainer/WFilteredTextEdit.clamp_lines()


func _on_button_one_pressed() -> void:
	popup_button_one.popup()


func _on_button_two_pressed() -> void:
	popup_button_two.popup()


## WPopupButtonOne #############################################################


func _on_w_popup_button_one_button_outside_pressed() -> void:
	popup_button_one.dismiss()


func _on_w_popup_button_one_button_popup_pressed() -> void:
	popup_button_one.dismiss()


## WPopupButtonTwo #############################################################


func _on_w_popup_button_two_button_left_popup_pressed() -> void:
	popup_button_two.dismiss()


func _on_w_popup_button_two_button_outside_pressed() -> void:
	popup_button_two.dismiss()


func _on_w_popup_button_two_button_right_popup_pressed() -> void:
	popup_button_two.dismiss()
