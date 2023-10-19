@tool
class_name WHSizingContainer
extends HBoxContainer
## Widget designed to contain children horizontally and size them easily.
## [b]Do not modify [param alignment][b].


## Enum corresponding to [param sizing].
enum {
	SIZING_SHRINK_LEFT,
	SIZING_SHRINK_CENTER,
	SIZING_RIGHT,
	SIZING_FILL,
}

## Relation between [param sizing] and [HBoxContainer.alignment].
const SIZING_TO_ALIGNMENT: Dictionary = {
	SIZING_SHRINK_LEFT: ALIGNMENT_BEGIN,
	SIZING_SHRINK_CENTER: ALIGNMENT_CENTER,
	SIZING_RIGHT: ALIGNMENT_END,
	SIZING_FILL: ALIGNMENT_CENTER,
}
## Relation between [param sizing] and [SizeFlags].
const SIZING_TO_FLAGS: Dictionary = {
	SIZING_SHRINK_LEFT: SIZE_SHRINK_BEGIN,
	SIZING_SHRINK_CENTER: SIZE_SHRINK_CENTER,
	SIZING_RIGHT: SIZE_SHRINK_END,
	SIZING_FILL: SIZE_EXPAND_FILL,
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
## Children's size and position mode.
## [br]
## [br]
## [b]Shrink Left[/b]: children start from left side and they take minimum space.
## [br]
## [br]
## [b]Shrink Center[/b]: children are centered and they take minimum space.
## [br]
## [br]
## [b]Shrink Right[/b]: children start from right side and they take minimum space.
## [br]
## [br]
## [b]Filll[/b]: children are centered and they take maximum space.
var sizing: int:
	set(sizing_):
		sizing = sizing_
		alignment = SIZING_TO_ALIGNMENT[sizing]
		var flags: int = SIZING_TO_FLAGS[sizing]
		for child in get_children():
			child.size_flags_horizontal = flags
