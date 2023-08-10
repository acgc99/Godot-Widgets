@tool
class_name FilteredTextEdit
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
@export var max_value: float = INF
## Minimun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var min_value: float = -INF
## [code]RegEx[/code] to filter text.
var reg: RegEx = RegEx.new()
## Current caret line.
var current_caret_line: int = 0
## Text before inserting a new character.
var old_text: String
## Length of [param old_text].
var old_text_length: int = 0
## Previous number of lines before.
var old_line_count: int = 0
## Lenght of [param new_text] in [code]_on_text_changed[/code].
var new_text_length: int = 0
## Character to be added
var new_char: String = ""
## Index of [param new_char] in [param new_text] in [code]_on_text_changed[/code].
## It is the right column for the caret ([code]new_char_index = caret_column - 1[/code])
## since when [code]insert_text_at_caret[/code] is called, caret is moved forward.
var new_char_index: int
## Function called for filtering.
var filter: Callable =  func filter_none(new_char_: String) -> String:
	return new_char_
## Control variable. If not used, when clamping values, [code]_on_text_changed[/code]
## is called at the end of all clampings, creating a bug if first line is clamped.
## This is the easiest way to solve this issue.
var _clamping: bool = false


func _ready():
	current_caret_line = get_caret_line()
	old_text = get_line(current_caret_line)
	old_text_length = old_text.length()
	old_line_count = get_line_count()
	text_changed.connect(_on_text_changed)


## Called when [param filter_mode] is set.
func _update_filter_mode() -> void:
	# none
	if filter_mode == 0:
		filter = func filter_none(new_char_: String) -> String:
			return new_char_
	# no-num
	elif filter_mode == 1:
		reg.compile("\\d")
		filter = func filter_no_num(new_char_: String) -> String:
			if reg.search(new_char_) == null:
				return new_char_
			return ""
	# +0i
	elif filter_mode == 2:
		reg.compile("\\d")
		filter = func filter_p0_i(new_char_: String) -> String:
			if reg.search(new_char_) == null:
				return ""
			# 0 replacement
			elif old_text == "0":
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(current_caret_line, "")
				else:
					return ""
			return new_char_
	# i
	elif filter_mode == 3:
		reg.compile("[\\d-]")
		filter = func filter_i(new_char_: String) -> String:
			if reg.search(new_char_) == null:
				return ""
			elif new_char_ == "-":
				if old_text.contains("-"):
					# When inserting new text, via insert_text_at_caret, caret is moved 1
					new_char_index -= 1
					set_line(current_caret_line, old_text.erase(0))
					# Do this change to avoid passing new_text_length < old_text_length
					new_text_length = old_text_length
					return ""
				elif old_text_length == 0:
					set_line(current_caret_line, "-0")
					new_char_index = get_line(current_caret_line).length()
					return ""
				else:
					set_line(current_caret_line, old_text.insert(0, "-"))
					new_char_index += 1
					return ""
			# 0 replacement
			elif old_text == "0":
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(current_caret_line, "")
				else:
					return ""
			# 0 replacement
			elif old_text == "-0":
				if new_char_ != "0":
					if new_char_index == 2:
						set_line(current_caret_line, "-%s" % new_char_)
						new_char_index = get_line(current_caret_line).length()
						return ""
				else:
					return ""
			# Avoid things like '1-2'
			elif old_text.contains("-") and new_char_index == 0:
				return ""
			return new_char_
	# +0f
	elif filter_mode == 4:
		reg.compile("[\\d.]")
		filter = func filter_p0_f(new_char_: String) -> String:
			if reg.search(new_char_) == null:
				return ""
			elif new_char_ == ".":
				if old_text.contains("."):
					return ""
				elif old_text_length == 0:
					set_line(current_caret_line, "0.")
					new_char_index = get_line(current_caret_line).length()
					return ""
			# 0 replacement
			elif old_text == "0":
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(current_caret_line, "")
				else:
					return ""
			# 0 replacement
			elif old_text == "0.":
				if new_char_ != "0":
					if new_char_index == 1:
						set_line(current_caret_line, "%s." % new_char_)
						new_char_index = get_line(current_caret_line).length() - 1
						return ""
			return new_char_
	# f
	elif filter_mode == 5:
		reg.compile("[\\d.-]")
		filter = func filter_f(new_char_: String) -> String:
			if reg.search(new_char_) == null:
				return ""
			elif new_char_ == ".":
				if old_text.contains("."):
					return ""
				elif old_text_length == 0:
					set_line(current_caret_line, "0.")
					new_char_index = get_line(current_caret_line).length()
					return ""
				# Avoid things like '-.0'
				elif old_text.contains("-") and new_char_index == 1:
					return ""
				# Avoid things like '.0'
				elif new_char_index == 0:
					return ""
			elif new_char_ == "-":
				if old_text.contains("-"):
					set_line(current_caret_line, get_line(current_caret_line).erase(0))
					new_char_index = old_text_length
					# Do this change to avoid passing new_text_length < old_text_length
					new_text_length = old_text_length
					return ""
				elif old_text_length == 0:
					set_line(current_caret_line, "-0")
					new_char_index = get_line(current_caret_line).length()
					return ""
				else:
					set_line(current_caret_line, old_text.insert(0, "-"))
					new_char_index += 1
					return ""
			# 0 replacement
			elif old_text == "0":
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_line(current_caret_line, "")
				else:
					return ""
			# 0 replacement
			elif old_text == "-0":
				# Avoid things like '1-0'
				if old_text.contains("-") and new_char_index == 0:
					return ""
				if new_char_ != "0":
					if new_char_index == 2:
						set_line(current_caret_line, "-%s" % new_char_)
						new_char_index = get_line(current_caret_line).length()
						return ""
			# 0 replacement
			elif old_text == "0.":
				if new_char_ != "0":
					if new_char_index == 1:
						set_line(current_caret_line, "%s." % new_char_)
						new_char_index = get_line(current_caret_line).length() - 1
						return ""
			# 0 replacement
			elif old_text == "-0.":
				# Avoid things like '1-0.'
				if old_text.contains("-") and new_char_index == 0:
					return ""
				if new_char_ != "0":
					if new_char_index == 2:
						set_line(current_caret_line, "-%s." % new_char_)
						new_char_index = get_line(current_caret_line).length()
						return ""
			# Avoid things like '1-2' (see '0 replacement's to avoid '1-0', '1-0.')
			elif old_text.contains("-") and new_char_index == 0:
				return ""
			return new_char_


## Manages text input and filtering.
func _on_text_changed() -> void:
	# Avoid problems when clamping at first line
	if _clamping:
		return
	current_caret_line = get_caret_line()
	var new_text: String = get_line(current_caret_line)
	var new_line_count: int = get_line_count()
	# Update new length
	new_text_length = get_line(current_caret_line).length()
	# If inserting/deleting new line, pass. This check has to be at the top
	if new_line_count != old_line_count:
		old_line_count = new_line_count
		old_text = get_line(current_caret_line)
		old_text_length = get_line(current_caret_line).length()
		return
	# If you select all text and press `-`/`.` it would break because of a
	## `new_text = ""`.
	if new_text == "":
		set_line(current_caret_line, "")
		old_text = ""
		old_text_length = 0
		return
	# If deleting text, pass
	if new_text_length < old_text_length:
		old_text_length = new_text_length
		# Avoid deleting only '0' from '0.'/'0-', delete all
		if new_text == "-" or new_text == ".":
			set_line(current_caret_line, "")
			old_text = ""
			old_text_length = 0
		return
	# Else, need to determine the new character and the old text
	# New character
	new_char_index = get_caret_column() - 1
	new_char = get_line(current_caret_line)[new_char_index]
	# Old text
	var left_text: String = new_text.substr(0, new_char_index)
	var right_text: String = new_text.substr(new_char_index+1, -1)
	old_text = left_text + right_text
	# Go back to the old text to decide insertion
	set_line(current_caret_line, old_text)
	# Filtering
	new_char = filter.call(new_char)
	# Set the caret at the right position for insertion
	set_caret_column(new_char_index)
	# Insert new text at the right position
	insert_text_at_caret(new_char)
	# Update old length
	old_text_length = get_line(current_caret_line).length()


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since float("x.") = float("-x.") = 0 and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_line(i: int) -> void:
	if filter_mode < 2:
		return
	_clamping = true
	var value: float = float(get_line(i))
	value = clamp(value, min_value, max_value)
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
		value = clamp(value, min_value, max_value)
		set_line(i, str(value))
