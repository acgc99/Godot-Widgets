@tool
class_name WHButtonsContainer
extends HBoxContainer
## Widget designed to contain [Button]s horizontally and size them.
## [b]Do not modify [param alignment][b].


## Enum corresponding to [param sizing].
enum {
	SIZING_SHRINK_LEFT,
	SIZING_SHRINK_CENTER,
	SIZING_RIGHT,
	SIZING_FILL,
}

## Separation between the text and the icons.
@export_range(0, 0, 1, "or_greater") var separation: int = 4:
	set(separation_):
		separation = separation_
		add_theme_constant_override("separation", separation)
@export_enum(
	"Shrink Left",
	"Shrink Center",
	"Shrink Right",
	"Fill"
)
## Buttons' size and position mode.
## [br]
## [br]
## [b]Shrink Left[/b]: buttons start from left side and they take minimum space.
## [br]
## [br]
## [b]Shrink Center[/b]: buttons are centered and they take minimum space.
## [br]
## [br]
## [b]Shrink Right[/b]: buttons start from right side and they take minimum space.
## [br]
## [br]
## [b]Filll[/b]: buttons are centered and they take maximum space.
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
