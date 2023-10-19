@tool
class_name WFilteredTextEdit
extends TextEdit
## Widget like [code]TextEdit[/code] but with filters.
## It can clamp [param text] numeric value (single line or all lines).


## Enum correspoding to [param filter_mode].
enum {
	FILTER_NONE,
	FILTER_DIGITLESS,
	FILTER_INTEGER_POSITIVE,
	FILTER_INTEGER,
	FILTER_FLOAT_POSITIVE,
	FILTER_FLOAT
}

@export_enum(
	"None",
	"Digitless",
	"Positive Integer",
	"Integer",
	"Positive Float",
	"Float"
)
## Filter modes:
## [param None]. No filter.
## [br]
## [br]
## [param Digitless]. No digits, 0-9.
## [br]
## [br]
## [param Positive Integer]. Positive or zero integer.
## [br]
## [br]
## [param Integer]. Integer.
## [br]
## [br]
## [param Positive float]. Positive float.
## [br]
## [br]
## [param Float]. Float.
var filter_mode: int:
	set(filter_mode_):
		filter_mode = filter_mode_
		_reg = RegEx.new()
		# None.
		if filter_mode == FILTER_NONE:
			_filter = _filter_none
		# Digitless.
		elif filter_mode == FILTER_DIGITLESS:
			_reg.compile("\\d")
			_filter = _filter_digitless
		# Positive integer.
		elif filter_mode == FILTER_INTEGER_POSITIVE:
			_reg.compile("\\d")
			_filter = _filter_integer_positive
		# Integer.
		elif filter_mode == FILTER_INTEGER:
			_reg.compile("[\\d-]")
			_filter = _filter_integer
		# Positive float.
		elif filter_mode == FILTER_FLOAT_POSITIVE:
			_reg.compile("[\\d.]")
			_filter = _filter_float_positive
		# Float
		else:
			_reg.compile("[\\d.-]")
			_filter = _filter_float
## Maximun numeric value of the [member WFilteredTextEdit.text] when
## [method WFilteredTextEdit.clamp_text] is called. Only used in a
## numeric [member filter_mode].
@export var max: float = INF
## Maximun numeric value of the [member WFilteredTextEdit.text] when
## [method WFilteredTextEdit.clamp_text] is called. Only used in a
## numeric [member filter_mode].
@export var min: float = -INF

# [RegEx] to filter text.
var _reg: RegEx
# Current caret line.
var _caret_line_curr: int
# Text before inserting modifications.
var _text_old: String
# Length of [member _text_old].
var _text_length_old: int
# Previous number of lines before modification.
var _line_count_old: int
# New text.
var _text_new: String
# Lenght of [member _text_new] in [method _on_text_changed].
var _text_length_new: int
# Character to be added.
var _char_new: String
# New line count.
var _line_count_new: int
# Index of [param _char_new] in [param _text_new] in [method _on_text_changed].
# It is the right column for the caret ([code]_char_index_new = caret_column - 1[/code])
# since when [method insert_text_at_caret] is called, caret is moved forward.
var _char_index_new: int
# Function called for filtering.
var _filter: Callable
# Control variable. Avoid modifications while clamping.
var _clamping: bool


func _init() -> void:
	_caret_line_curr = get_caret_line()
	_text_old = get_line(_caret_line_curr)
	_text_length_old = _text_old.length()
	_line_count_old = get_line_count()
	text_changed.connect(_on_text_changed)
	_filter = _filter_none


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since [code]float("x.") = x[/code] and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_line(i: int) -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float = float(get_line(i))
	value = clamp(value, min, max)
	set_line(i, str(value))
	_clamping = false


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since [code]float("x.") = x[/code] and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_lines() -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float
	for i in range(get_line_count()):
		value = float(get_line(i))
		value = clamp(value, min, max)
		set_line(i, str(value))
	_clamping = false


## Manages text input and filtering.
func _on_text_changed() -> void:
	# Avoid modifications while clamping.
	if _clamping:
		return
	_caret_line_curr = get_caret_line()
	_text_new = get_line(_caret_line_curr)
	_line_count_new = get_line_count()
	# Update new length.
	_text_length_new = get_line(_caret_line_curr).length()
	# If inserting/deleting new line, pass. This check has to be at the top.
	if _line_count_new != _line_count_old:
		_line_count_old = _line_count_new
		_text_old = get_line(_caret_line_curr)
		_text_length_old = get_line(_caret_line_curr).length()
		return
	# If you select all text and press `-`/`.` it would break because of a
	## [code]text_new = ""[/code].
	if _text_new == "":
		set_line(_caret_line_curr, "")
		_text_old = ""
		_text_length_old = 0
		return
	# If deleting text, pass.
	if _text_length_new < _text_length_old:
		_text_length_old = _text_length_new
		# Avoid deleting only '0' from '0.'/'0-', delete all.
		if _text_new == "-" or _text_new == ".":
			set_line(_caret_line_curr, "")
			_text_old = ""
			_text_length_old = 0
		return
	# Else, need to determine the new character and the old text.
	# New character.
	_char_index_new = get_caret_column() - 1
	_char_new = get_line(_caret_line_curr)[_char_index_new]
	# Old text.
	var left_text: String = _text_new.substr(0, _char_index_new)
	var right_text: String = _text_new.substr(_char_index_new+1, -1)
	_text_old = left_text + right_text
	# Go back to the old text to decide insertion.
	set_line(_caret_line_curr, _text_old)
	# Filtering.
	_char_new = _filter.call(_char_new)
	# Set the caret at the right position for insertion.
	set_caret_column(_char_index_new)
	# Insert new text at the right position.
	insert_text_at_caret(_char_new)
	# Update old length.
	_text_length_old = get_line(_caret_line_curr).length()


## Filter: None.
func _filter_none(char_new_: String) -> String:
	return char_new_


## Filter: Digitless.
func _filter_digitless(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return char_new
	return ""


## Filter: Positive integer.
func _filter_integer_positive(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			set_line(_caret_line_curr, "")
		else:
			return ""
	return char_new


## Filter: Integer.
func _filter_integer(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == "-":
		if _text_old.contains("-"):
			# When inserting new text, via [method insert_text_at_caret],
			# caret is moved.
			_char_index_new -= 1
			set_line(_caret_line_curr, _text_old.erase(0))
			# Do this change to avoid passing
			# [code]_text_new_length < _text_old_length[/code].
			_text_length_new = _text_length_old
			return ""
		elif _text_length_old == 0:
			set_line(_caret_line_curr, "-0")
			_char_index_new = get_line(_caret_line_curr).length()
			return ""
		else:
			set_line(_caret_line_curr, _text_old.insert(0, "-"))
			_char_index_new += 1
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			set_line(_caret_line_curr, "")
		else:
			return ""
	# 0 replacement.
	elif _text_old == "-0":
		if char_new != "0":
			if _char_index_new == 2:
				set_line(_caret_line_curr, "-%s" % char_new)
				_char_index_new = get_line(_caret_line_curr).length()
				return ""
		else:
			return ""
	# Avoid things like '1-2'.
	elif _text_old.contains("-") and _char_index_new == 0:
		return ""
	return char_new


## Filter: Positive float.
func _filter_float_positive(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == ".":
		if _text_old.contains("."):
			return ""
		elif _text_length_old == 0:
			set_line(_caret_line_curr, "0.")
			_char_index_new = get_line(_caret_line_curr).length()
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here,
			# due to length checks.
			set_line(_caret_line_curr, "")
		else:
			return ""
	# 0 replacement.
	elif _text_old == "0.":
		if char_new != "0":
			if _char_index_new == 1:
				set_line(_caret_line_curr, "%s." % char_new)
				_char_index_new = get_line(_caret_line_curr).length() - 1
				return ""
	return char_new


## Filter: Float.
func _filter_float(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == ".":
		if _text_old.contains("."):
			return ""
		elif _text_length_old == 0:
			set_line(_caret_line_curr, "0.")
			_char_index_new = get_line(_caret_line_curr).length()
			return ""
		# Avoid things like '-.0'.
		elif _text_old.contains("-") and _char_index_new == 1:
			return ""
		# Avoid things like '.0'.
		elif _char_index_new == 0:
			return ""
	elif char_new == "-":
		if _text_old.contains("-"):
			set_line(_caret_line_curr, get_line(_caret_line_curr).erase(0))
			_char_index_new = _text_length_old
			# Do this change to avoid passing
			# [code]_text_new_length < _text_old_length[/code].
			_text_length_new = _text_length_old
			return ""
		elif _text_length_old == 0:
			set_line(_caret_line_curr, "-0")
			_char_index_new = get_line(_caret_line_curr).length()
			return ""
		else:
			set_line(_caret_line_curr, _text_old.insert(0, "-"))
			_char_index_new += 1
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			set_line(_caret_line_curr, "")
		else:
			return ""
	# 0 replacement.
	elif _text_old == "-0":
		# Avoid things like '1-0'.
		if _text_old.contains("-") and _char_index_new == 0:
			return ""
		if char_new != "0":
			if _char_index_new == 2:
				set_line(_caret_line_curr, "-%s" % char_new)
				_char_index_new = get_line(_caret_line_curr).length()
				return ""
	# 0 replacement.
	elif _text_old == "0.":
		if char_new != "0":
			if _char_index_new == 1:
				set_line(_caret_line_curr, "%s." % char_new)
				_char_index_new = get_line(_caret_line_curr).length() - 1
				return ""
	# 0 replacement.
	elif _text_old == "-0.":
		# Avoid things like '1-0.'.
		if _text_old.contains("-") and _char_index_new == 0:
			return ""
		if char_new != "0":
			if _char_index_new == 2:
				set_line(_caret_line_curr, "-%s." % char_new)
				_char_index_new = get_line(_caret_line_curr).length()
				return ""
	# Avoid things like '1-2' (see '0 replacement's to avoid '1-0', '1-0.').
	elif _text_old.contains("-") and _char_index_new == 0:
		return ""
	return char_new
