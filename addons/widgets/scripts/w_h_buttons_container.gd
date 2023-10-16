@tool
class_name WHButtonsContainer
extends HBoxContainer
## A widget designed to contain [Button]s horizontally.
## [b]Do not modify [param alignment][b].


## Enum corresponding to [param sizing].
enum {
	SIZING_SHRINK_LEFT,
	SIZING_SHRINK_CENTER,
	SIZING_RIGHT,
	SIZING_FILL,
}

## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var buttons_separation: int = 4:
	set(buttons_separation_):
		buttons_separation = buttons_separation_
		add_theme_constant_override("separation", buttons_separation)
@export_enum(
	"Shrink Left",
	"Shrink Center",
	"Shrink Right",
	"Fill"
)
## Buttons' size and position mode.
var sizing: int:
	set(sizing_):
		sizing = sizing_
		if sizing == SIZING_SHRINK_LEFT:
			alignment = ALIGNMENT_BEGIN
			for button in get_children():
				button.size_flags_horizontal = SIZE_SHRINK_BEGIN
		elif sizing == SIZING_SHRINK_CENTER:
			alignment = ALIGNMENT_CENTER
			for button in get_children():
				button.size_flags_horizontal = SIZE_SHRINK_CENTER
		elif sizing == SIZING_RIGHT:
			alignment = ALIGNMENT_END
			for button in get_children():
				button.size_flags_horizontal = SIZE_SHRINK_END
		else:
			alignment = ALIGNMENT_CENTER
			for button in get_children():
				button.size_flags_horizontal = SIZE_EXPAND_FILL
