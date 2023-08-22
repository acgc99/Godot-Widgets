@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type(
		"FilteredLineEdit",
		"LineEdit",
		preload("res://addons/widgets/scripts/filtered_line_edit.gd"),
		preload("res://addons/widgets/svg_icons/LineEdit.svg")
	)
	add_custom_type(
		"FilteredTextEdit",
		"TextEdit",
		preload("res://addons/widgets/scripts/filtered_text_edit.gd"),
		preload("res://addons/widgets/svg_icons/TextEdit.svg")
	)
	add_custom_type(
		"IconButton",
		"Button",
		preload("res://addons/widgets/scripts/icon_button.gd"),
		preload("res://addons/widgets/svg_icons/alpha-x-circle.svg")
	)
	add_custom_type(
		"NavBar",
		"PanelContainer",
		preload("res://addons/widgets/scripts/nav_bar.gd"),
		preload("res://addons/widgets/svg_icons/navigation-variant.svg")
	)
	add_custom_type(
		"NumericInput",
		"PanelContainer",
		preload("res://addons/widgets/scripts/numeric_input.gd"),
		preload("res://addons/widgets/svg_icons/arrow-expand-vertical.svg")
	)
	add_custom_type(
		"OneButtonPopup",
		"Button",
		preload("res://addons/widgets/scripts/one_button_popup.gd"),
		preload("res://addons/widgets/svg_icons/numeric-1-box-multiple.svg")
	)
	add_custom_type(
		"TwoButtonsPopup",
		"Button",
		preload("res://addons/widgets/scripts/two_buttons_popup.gd"),
		preload("res://addons/widgets/svg_icons/numeric-2-box-multiple.svg")
	)
	add_custom_type(
		"TextureRounded",
		"TextureRect",
		preload("res://addons/widgets/scripts/texture_rounded.gd"),
		preload("res://addons/widgets/svg_icons/image.svg")
	)
	add_custom_type(
		"Card",
		"TextureRect",
		preload("res://addons/widgets/scripts/card.gd"),
		preload("res://addons/widgets/svg_icons/file-presentation-box.svg")
	)


func _exit_tree() -> void:
	remove_custom_type("FilteredLineEdit")
	remove_custom_type("FilteredTextEdit")
	remove_custom_type("IconButton")
	remove_custom_type("NavBar")
	remove_custom_type("NumericInput")
	remove_custom_type("OneButtonPopup")
	remove_custom_type("TwoButtonsPopup")
	remove_custom_type("TextureRounded")
	remove_custom_type("Card")
