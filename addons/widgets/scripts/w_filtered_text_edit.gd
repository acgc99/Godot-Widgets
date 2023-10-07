@tool
class_name WFilteredTextEdit
extends TextEdit

## [code]TextEdit[/code] with filters. It [b]cannot[/b] clamp [param text] numeric value.

## Filter modes:
## [param none] (no filter),
## [param no-num] (no 0-9 characters),
## [param +0i] (positive or zero integer),
## [param i] (integer),
## [param +0f] (positive float) or
## [param f] (float).
## Note that "." and "-" count as characters in max length.
@export_enum("none", "no-num", "+0i", "i", "+0f", "f") var filter_mode: int = 0:
	set(filter_mode_):
		filter_mode = filter_mode_
		_update_filter_mode()
## Maximun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var value_max: float = INF
## Minimun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var value_min: float = -INF
## [code]RegEx[/code] to filter text.
var reg: RegEx = RegEx.new()
## Current caret line.
var caret_line_curr: int = 0
## Text before inserting a new character.
var text_old: String
## Length of [param text_old].
var text_old_length: int = 0
## Previous number of lines before.
var line_count_old: int = 0
## Lenght of [param text_new] in [code]_on_text_changed[/code].
var text_new_length: int = 0
## Character to be added
var char_new: String = ""
## Index of [param char_new] in [param text_new] in [code]_on_text_changed[/code].
## It is the right column for the caret ([code]char_new_index = caret_column - 1[/code])
## since when [code]insert_text_at_caret[/code] is called, caret is moved forward.
var char_new_index: int
## Function called for filtering.
var filter: Callable =  func filter_none(char_new_: String) -> String:
	return char_new_
## Control variable. If not used, when clamping values, [code]_on_text_changed[/code]
## is called at the end of all clampings, creating a bug if first line is clamped.
## This is the easiest way to solve this issue.
var _clamping: bool = false


func _ready():
	caret_line_curr = get_caret_line()
	text_old = get_line(caret_line_curr)
	text_old_length = text_old.length()
	line_count_old = get_line_count()
	text_changed.connect(_on_text_changed)


## Called when [param filter_mode] is set.
func _update_filter_mode() -> void:
	# none
	if filter_mode == 0:
		filter = func filter_none(char_new_: String) -> String:
			return char_new_
	# no-num
	elif filter_mode == 1:
		reg.compile("\\d")
		filter = func filter_no_num(char_new_: String) -> String:
			if reg.search(char_new_) == null:
				return char_new_
			return ""
	# +0i
	elif filter_mode == 2:
		reg.compile("\\d")
		filter = func filter_p0_i(char_new_: String) -> String:
			if reg.search(char_new_) == null:
				return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(caret_line_curr, "")
				else:
					return ""
			return char_new_
	# i
	elif filter_mode == 3:
		reg.compile("[\\d-]")
		filter = func filter_i(char_new_: String) -> String:
			if reg.search(char_new_) == null:
				return ""
			elif char_new_ == "-":
				if text_old.contains("-"):
					# When inserting new text, via insert_text_at_caret, caret is moved 1
					char_new_index -= 1
					set_line(caret_line_curr, text_old.erase(0))
					# Do this change to avoid passing text_new_length < text_old_length
					text_new_length = text_old_length
					return ""
				elif text_old_length == 0:
					set_line(caret_line_curr, "-0")
					char_new_index = get_line(caret_line_curr).length()
					return ""
				else:
					set_line(caret_line_curr, text_old.insert(0, "-"))
					char_new_index += 1
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(caret_line_curr, "")
				else:
					return ""
			# 0 replacement
			elif text_old == "-0":
				if char_new_ != "0":
					if char_new_index == 2:
						set_line(caret_line_curr, "-%s" % char_new_)
						char_new_index = get_line(caret_line_curr).length()
						return ""
				else:
					return ""
			# Avoid things like '1-2'
			elif text_old.contains("-") and char_new_index == 0:
				return ""
			return char_new_
	# +0f
	elif filter_mode == 4:
		reg.compile("[\\d.]")
		filter = func filter_p0_f(char_new_: String) -> String:
			if reg.search(char_new_) == null:
				return ""
			elif char_new_ == ".":
				if text_old.contains("."):
					return ""
				elif text_old_length == 0:
					set_line(caret_line_curr, "0.")
					char_new_index = get_line(caret_line_curr).length()
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(caret_line_curr, "")
				else:
					return ""
			# 0 replacement
			elif text_old == "0.":
				if char_new_ != "0":
					if char_new_index == 1:
						set_line(caret_line_curr, "%s." % char_new_)
						char_new_index = get_line(caret_line_curr).length() - 1
						return ""
			return char_new_
	# f
	elif filter_mode == 5:
		reg.compile("[\\d.-]")
		filter = func filter_f(char_new_: String) -> String:
			if reg.search(char_new_) == null:
				return ""
			elif char_new_ == ".":
				if text_old.contains("."):
					return ""
				elif text_old_length == 0:
					set_line(caret_line_curr, "0.")
					char_new_index = get_line(caret_line_curr).length()
					return ""
				# Avoid things like '-.0'
				elif text_old.contains("-") and char_new_index == 1:
					return ""
				# Avoid things like '.0'
				elif char_new_index == 0:
					return ""
			elif char_new_ == "-":
				if text_old.contains("-"):
					set_line(caret_line_curr, get_line(caret_line_curr).erase(0))
					char_new_index = text_old_length
					# Do this change to avoid passing text_new_length < text_old_length
					text_new_length = text_old_length
					return ""
				elif text_old_length == 0:
					set_line(caret_line_curr, "-0")
					char_new_index = get_line(caret_line_curr).length()
					return ""
				else:
					set_line(caret_line_curr, text_old.insert(0, "-"))
					char_new_index += 1
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(caret_line_curr, "")
				else:
					return ""
			# 0 replacement
			elif text_old == "-0":
				# Avoid things like '1-0'
				if text_old.contains("-") and char_new_index == 0:
					return ""
				if char_new_ != "0":
					if char_new_index == 2:
						set_line(caret_line_curr, "-%s" % char_new_)
						char_new_index = get_line(caret_line_curr).length()
						return ""
			# 0 replacement
			elif text_old == "0.":
				if char_new_ != "0":
					if char_new_index == 1:
						set_line(caret_line_curr, "%s." % char_new_)
						char_new_index = get_line(caret_line_curr).length() - 1
						return ""
			# 0 replacement
			elif text_old == "-0.":
				# Avoid things like '1-0.'
				if text_old.contains("-") and char_new_index == 0:
					return ""
				if char_new_ != "0":
					if char_new_index == 2:
						set_line(caret_line_curr, "-%s." % char_new_)
						char_new_index = get_line(caret_line_curr).length()
						return ""
			# Avoid things like '1-2' (see '0 replacement's to avoid '1-0', '1-0.')
			elif text_old.contains("-") and char_new_index == 0:
				return ""
			return char_new_


## Manages text input and filtering.
func _on_text_changed() -> void:
	# Avoid problems when clamping at first line
	if _clamping:
		return
	caret_line_curr = get_caret_line()
	var text_new: String = get_line(caret_line_curr)
	var new_line_count: int = get_line_count()
	# Update new length
	text_new_length = get_line(caret_line_curr).length()
	# If inserting/deleting new line, pass. This check has to be at the top
	if new_line_count != line_count_old:
		line_count_old = new_line_count
		text_old = get_line(caret_line_curr)
		text_old_length = get_line(caret_line_curr).length()
		return
	# If you select all text and press `-`/`.` it would break because of a
	## `text_new = ""`.
	if text_new == "":
		set_line(caret_line_curr, "")
		text_old = ""
		text_old_length = 0
		return
	# If deleting text, pass
	if text_new_length < text_old_length:
		text_old_length = text_new_length
		# Avoid deleting only '0' from '0.'/'0-', delete all
		if text_new == "-" or text_new == ".":
			set_line(caret_line_curr, "")
			text_old = ""
			text_old_length = 0
		return
	# Else, need to determine the new character and the old text
	# New character
	char_new_index = get_caret_column() - 1
	char_new = get_line(caret_line_curr)[char_new_index]
	# Old text
	var left_text: String = text_new.substr(0, char_new_index)
	var right_text: String = text_new.substr(char_new_index+1, -1)
	text_old = left_text + right_text
	# Go back to the old text to decide insertion
	set_line(caret_line_curr, text_old)
	# Filtering
	char_new = filter.call(char_new)
	# Set the caret at the right position for insertion
	set_caret_column(char_new_index)
	# Insert new text at the right position
	insert_text_at_caret(char_new)
	# Update old length
	text_old_length = get_line(caret_line_curr).length()


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since float("x.") = float("-x.") = 0 and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_line(i: int) -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float = float(get_line(i))
	value = clamp(value, value_min, value_max)
	set_line(i, str(value))


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since float("x.") = float("-x.") = 0 and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_lines() -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float
	for i in range(get_line_count()):
		value = float(get_line(i))
		value = clamp(value, value_min, value_max)
		set_line(i, str(value))
