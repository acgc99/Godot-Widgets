@tool
extends EditorPlugin


func _enter_tree() -> void:
	# level 0
	add_custom_type(
		"WIcon",
		"Control",
		preload("res://addons/widgets/scripts/w_icon.gd"),
		preload("res://addons/widgets/svg_icons/circle.svg")
	)
	add_custom_type(
		"WRoundClippingContainer",
		"PanelContainer",
		preload("res://addons/widgets/scripts/w_round_clipping_container.gd"),
		preload("res://addons/widgets/svg_icons/border-radius.svg")
	)
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
		"WHSizingContainer",
		"HBoxContainer",
		preload("res://addons/widgets/scripts/w_h_sizing_container.gd"),
		preload("res://addons/widgets/svg_icons/dots-horizontal.svg")
	)
	# level 1
	add_custom_type(
		"WIconButton",
		"BaseButton",
		preload("res://addons/widgets/scripts/w_icon_button.gd"),
		preload("res://addons/widgets/svg_icons/circle-slice-8.svg")
	)
	add_custom_type(
		"WIconLabelIcon",
		"Control",
		preload("res://addons/widgets/scripts/w_icon_label_icon.gd"),
		preload("res://addons/widgets/svg_icons/align-horizontal-distribute.svg")
	)
	add_custom_type(
		"WTextureRounded",
		"Control",
		preload("res://addons/widgets/scripts/w_texture_rounded.gd"),
		preload("res://addons/widgets/svg_icons/image.svg")
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
		"WPopup",
		"Control",
		preload("res://addons/widgets/scripts/w_popup.gd"),
		preload("res://addons/widgets/svg_icons/message-text.svg")
	)
	# level 2
	add_custom_type(
		"WPageContainer",
		"VBoxContainer",
		preload("res://addons/widgets/scripts/w_page.gd"),
		preload("res://addons/widgets/svg_icons/page-layout-header.svg")
	)
	add_custom_type(
		"WCard",
		"BaseButton",
		preload("res://addons/widgets/scripts/w_card.gd"),
		preload("res://addons/widgets/svg_icons/file-presentation-box.svg")
	)
	add_custom_type(
		"WPopupB1",
		"Control",
		preload("res://addons/widgets/scripts/w_popup_b1.gd"),
		preload("res://addons/widgets/svg_icons/numeric-1-box-multiple.svg")
	)
	add_custom_type(
		"WPopupB2",
		"Control",
		preload("res://addons/widgets/scripts/w_popup_b2.gd"),
		preload("res://addons/widgets/svg_icons/numeric-2-box-multiple.svg")
	)


func _exit_tree() -> void:
	# level 2
	remove_custom_type("WPopupB2")
	remove_custom_type("WPopupB1")
	remove_custom_type("WCard")
	remove_custom_type("WPageContainer")
	# level 1
	remove_custom_type("WPopup")
	remove_custom_type("WNumericInput")
	remove_custom_type("WNavBar")
	remove_custom_type("WTextureRounded")
	remove_custom_type("WIconLabelIcon")
	remove_custom_type("WIconButton")
	# level 0
	remove_custom_type("WHSizingContainer")
	remove_custom_type("WFilteredTextEdit")
	remove_custom_type("WFilteredLineEdit")
	remove_custom_type("WRoundClippingContainer")
	remove_custom_type("WIcon")
