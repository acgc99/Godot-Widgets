extends Control

@onready var popup_b1: WPopupB1 = $WPopupB1
@onready var popup_b2: WPopupB2 = $WPopupB2
@onready var fline_edit: WFilteredLineEdit = $Page/Contents/MarginContainer/VBoxContainer/WFilteredLineEdit
@onready var ftext_edit: WFilteredTextEdit = $Page/Contents/MarginContainer/VBoxContainer/WFilteredTextEdit


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
