@tool
class_name WFilteredLineEdit
extends LineEdit
## [code]LineEdit[/code] with filters. It can clamp [member text] numeric value.

## Enum correspoding to [member filter_mode].
enum {
	NONE,
	DIGITLESS,
	INTEGER_POSITIVE,
	INTEGER,
	FLOAT_POSITIVE,
	FLOAT
}

@export_enum(
	"None",
	"Digitless",
	"Positive Integer",
	"Integer",
	"Positive Float",
	"Float"
) ## Filter modes:
## [param None] (no filter),
## [param Digitless] (no digits, 0-9),
## [param Positive Integer] (positive or zero integer),
## [param Integer] (integer),
## [param Positive float] (positive float) and
## [param Float] (float).
## Note that "." and "-" count as characters in [member max_length].
var filter_mode: int:
	set(filter_mode_):
		filter_mode = filter_mode_
		_reg = RegEx.new()
		# None.
		if filter_mode == NONE:
			_filter = _filter_none
		# Digitless.
		elif filter_mode == DIGITLESS:
			_reg.compile("\\d")
			_filter = _filter_digitless
		# Positive integer.
		elif filter_mode == INTEGER_POSITIVE:
			_reg.compile("\\d")
			_filter = _filter_integer_positive
		# Integer.
		elif filter_mode == INTEGER:
			_reg.compile("[\\d-]")
			_filter = _filter_integer
		# Positve float.
		elif filter_mode == FLOAT_POSITIVE:
			_reg.compile("[\\d.]")
			_filter = _filter_float_positive
		# Float
		else:
			_reg.compile("[\\d.-]")
			_filter = _filter_float
@export_group("Values", "value")
## Maximun numeric value of the [member WFilteredLineEdit.text] when
## [method WFilteredLineEdit.clamp_text] is called. Only used in a
## numeric [member filter_mode].
@export var value_max: float = INF
## Minimum numeric value of the [member WFilteredLineEdit.text] when
## [method WFilteredLineEdit.clamp_text] is called. Only used in a
## numeric [member filter_mode].
@export var value_min: float = -INF

## [RegEx] to filter text.
var _reg: RegEx
## Text before inserting modifications.
var _text_old: String
## Length of [member _text_old].
var _text_length_old: int
## Lenght of [param _text_new] in [method _on_text_changed].
var _text_length_new: int
## Character to be added.
var _char_new: String
## Index of [param _char_new] in [param _text_new] in [method _on_text_changed].
## It is the right column for the caret ([code]_char_index_new = caret_column - 1[/code])
## since when [method insert_text_at_caret] is called, caret is moved forward.
var _char_index_new: int
## Function called for filtering.
var _filter: Callable
## Control variable. Avoid modifications while clamping.
var _clamping: bool


func _init() -> void:
	_text_old = text
	_text_length_old = _text_old.length()
	text_changed.connect(_on_text_changed)


## Clamps the numeric value of the text if [member filter_mode] is a numeric mode.
## Note that since [code]float("x.") = x[/code] and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_text() -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float = float(text)
	value = clamp(value, value_min, value_max)
	text = str(value)
	_clamping = false


## Manages text input and filtering.
func _on_text_changed(_text_new: String) -> void:
	# Avoid modifications while clamping.
	if _clamping:
		return
	# Update new length.
	_text_length_new = text.length()
	# If you select all text and press `-`/`.` it would break because of a
	## [code] _text_new = ""[/code].
	if _text_new == "":
		text = ""
		_text_old = ""
		_text_length_old = 0
		return
	# If deleting text, pass
	if _text_length_new < _text_length_old:
		_text_length_old = _text_length_new
		_text_old = _text_new
		# Avoid deleting only '0' from '0.'/'0-', delete all.
		if _text_new == "-" or _text_new == ".":
			text = ""
			_text_old = ""
			_text_length_old = 0
		return
	# Else, need to determine the new character and the old text,
	# New character.
	_char_index_new = caret_column - 1
	_char_new = text[_char_index_new]
	# Old text.
	var left_text: String = _text_new.substr(0, _char_index_new)
	var right_text: String = _text_new.substr(_char_index_new+1, -1)
	_text_old = left_text + right_text
	# Go back to the old text to decide insertion
	text = _text_old
	# Filtering
	_char_new = _filter.call(_char_new)
	# Set the caret at the right position for insertion
	caret_column = _char_index_new
	# Insert new text at the right position
	insert_text_at_caret(_char_new)
	# Update old length
	_text_old = text
	_text_length_old = text.length()


# Filters ######################################################################


## None.
func _filter_none(char_new: String) -> String:
	return char_new


## Digitless.
func _filter_digitless(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return char_new
	return ""


## Positive integer.
func _filter_integer_positive(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	# 0 replacement
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks
			text = ""
		else:
			return ""
	return char_new


## Integer.
func _filter_integer(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == "-":
		if _text_old.contains("-"):
			# When inserting new text, via [method insert_text_at_caret],
			# caret is moved.
			if _char_index_new != 0:
				_char_index_new -= 1
			text = _text_old.erase(0)
			# Do this change to avoid passing
			# [code]_text_length_new < _text_length_old[/code].
			_text_length_new = _text_length_old
			return ""
		elif _text_length_old == 0:
			text = "-0"
			_char_index_new = text.length()
			return ""
		else:
			text = _text_old.insert(0, "-")
			_char_index_new += 1
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			text = ""
		else:
			return ""
	# 0 replacement.
	elif _text_old == "-0":
		if char_new != "0":
			if _char_index_new == 2:
				text = "-%s" % char_new
				_char_index_new = text.length()
				return ""
		else:
			return ""
	# Avoid things like '1-2'.
	elif _text_old.contains("-") and _char_index_new == 0:
		return ""
	return char_new


## Positive float.
func _filter_float_positive(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == ".":
		if _text_old.contains("."):
			return ""
		elif _text_length_old == 0:
			text = "0."
			_char_index_new = text.length()
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			text = ""
		else:
			return ""
	# 0 replacement.
	elif _text_old == "0.":
		if char_new != "0":
			if _char_index_new == 1:
				text = "%s." % char_new
				_char_index_new = text.length() - 1
				return ""
	return char_new


## Float.
func _filter_float(char_new: String) -> String:
	if _reg.search(char_new) == null:
		return ""
	elif char_new == ".":
		if _text_old.contains("."):
			return ""
		elif _text_length_old == 0:
			text = "0."
			_char_index_new = text.length()
			return ""
		# Avoid things like '-.0'.
		elif _text_old.contains("-") and _char_index_new == 1:
			return ""
		# Avoid things like '.0'.
		elif _char_index_new == 0:
			return ""
	elif char_new == "-":
		if _text_old.contains("-"):
			# When inserting new text, via [method insert_text_at_caret],
			# caret is moved.
			if _char_index_new != 0:
				_char_index_new -= 1
			text = _text_old.erase(0)
			# Do this change to avoid passing
			# [code]_text_length_new < _text_length_old[/code].
			_text_length_new = _text_length_old
			return ""
		elif _text_length_old == 0:
			text = "-0"
			_char_index_new = text.length()
			return ""
		else:
			text = _text_old.insert(0, "-")
			_char_index_new += 1
			return ""
	# 0 replacement.
	elif _text_old == "0":
		if char_new != "0":
			# [method delete_char_at_caret] cannot be placed here
			# due to length checks.
			text = ""
		else:
			return ""
	# 0 replacement.
	elif _text_old == "-0":
		# Avoid things like '1-0'.
		if _text_old.contains("-") and _char_index_new == 0:
			return ""
		if char_new != "0":
			if _char_index_new == 2:
				text = "-%s" % char_new
				_char_index_new = text.length()
				return ""
	# 0 replacement.
	elif _text_old == "0.":
		if char_new != "0":
			if _char_index_new == 1:
				text = "%s." % char_new
				_char_index_new = text.length() - 1
				return ""
	# 0 replacement.
	elif _text_old == "-0.":
		# Avoid things like '1-0.'.
		if _text_old.contains("-") and _char_index_new == 0:
			return ""
		if char_new != "0":
			if _char_index_new == 2:
				text = "-%s." % char_new
				_char_index_new = text.length()
				return ""
	# Avoid things like '1-2' (see '0 replacement's to avoid '1-0', '1-0.').
	elif _text_old.contains("-") and _char_index_new == 0:
		return ""
	return char_new
