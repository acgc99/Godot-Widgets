@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type(
		"WFilteredLineEdit",
		"LineEdit",
		preload("res://addons/widgets/scripts/w_filtered_line_edit.gd"),
		preload("res://addons/widgets/svg_icons/LineEdit.svg")
	)
	add_custom_type(
		"WFilteredTextEdit",
		"TextEdit",
		preload("res://addons/widgets/scripts/w_filtered_text_edit.gd"),
		preload("res://addons/widgets/svg_icons/TextEdit.svg")
	)
	add_custom_type(
		"WIconButton",
		"Button",
		preload("res://addons/widgets/scripts/w_icon_button.gd"),
		preload("res://addons/widgets/svg_icons/alpha-x-circle.svg")
	)
	add_custom_type(
		"WNavBar",
		"Control",
		preload("res://addons/widgets/scripts/w_nav_bar.gd"),
		preload("res://addons/widgets/svg_icons/navigation-variant.svg")
	)
	add_custom_type(
		"WNumericInput",
		"Control",
		preload("res://addons/widgets/scripts/w_numeric_input.gd"),
		preload("res://addons/widgets/svg_icons/arrow-expand-vertical.svg")
	)
	add_custom_type(
		"WPopupB1",
		"Control",
		preload("res://addons/widgets/scripts/w_popup_b_1.gd"),
		preload("res://addons/widgets/svg_icons/numeric-1-box-multiple.svg")
	)
	add_custom_type(
		"WPopupB2",
		"Control",
		preload("res://addons/widgets/scripts/w_popup_b_2.gd"),
		preload("res://addons/widgets/svg_icons/numeric-2-box-multiple.svg")
	)
	add_custom_type(
		"WTextureRounded",
		"TextureRect",
		preload("res://addons/widgets/scripts/w_texture_rounded.gd"),
		preload("res://addons/widgets/svg_icons/image.svg")
	)
	add_custom_type(
		"WCard",
		"BaseButton",
		preload("res://addons/widgets/scripts/w_card.gd"),
		preload("res://addons/widgets/svg_icons/file-presentation-box.svg")
	)


func _exit_tree() -> void:
	remove_custom_type("WFilteredLineEdit")
	remove_custom_type("WFilteredTextEdit")
	remove_custom_type("WIconButton")
	remove_custom_type("WNavBar")
	remove_custom_type("WNumericInput")
	remove_custom_type("WPopupB1")
	remove_custom_type("WPopupB2")
	remove_custom_type("WTextureRounded")
	remove_custom_type("WCard")
