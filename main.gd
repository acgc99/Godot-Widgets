extends Control

@onready var popup_b1: WPopupB1 = $WPopupB1
@onready var popup_b2: WPopupB2 = $WPopupB2
@onready var fline_edit: WFilteredLineEdit = $WPageContainer/Contents/MarginContainer/VBoxContainer/WFilteredLineEdit
@onready var ftext_edit: WFilteredTextEdit = $WPageContainer/Contents/MarginContainer/VBoxContainer/WFilteredTextEdit

@onready var popup: WPopup = $WPopup


func _ready() -> void:
	fline_edit.clamp_text()
	ftext_edit.clamp_lines()


func _on_button_one_pressed() -> void:
	popup_b1.popup()


func _on_button_two_pressed() -> void:
	popup_b2.popup()


func _dismiss_popup_b1() -> void:
	popup_b1.dismiss()


func _dismiss_popup_b2() -> void:
	popup_b2.dismiss()


func _on_w_card_pressed() -> void:
	popup.popup()


func _dismiss_popup() -> void:
	popup.dismiss()


func _on_w_page_container_navbar_left_button_pressed() -> void:
	print("WNavBar Left")


func _on_w_page_container_navbar_right_button_pressed() -> void:
	print("WNavBar Right")
