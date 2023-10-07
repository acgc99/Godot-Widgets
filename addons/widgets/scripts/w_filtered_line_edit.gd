@tool
class_name WFilteredLineEdit
extends LineEdit

## [code]LineEdit[/code] with filters. It [b]can[/b] clamp [param text] numeric value.

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
## To set [param filter_mode] on code.
enum {NONE, NONUM, P0I, I, P0F, F}
## Maximun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var value_max: float = INF
## Minimun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var value_min: float = -INF
## [code]RegEx[/code] to filter text.
var reg: RegEx = RegEx.new()
## Text before inserting a new character.
var text_old: String
## Length of [param text_old].
var text_old_length: int = 0
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


func _ready():
	text_old = text
	text_old_length = text_old.length()
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
					text = ""
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
					if char_new_index != 0:
						char_new_index -= 1
					text = text_old.erase(0)
					# Do this change to avoid passing text_new_length < text_old_length
					text_new_length = text_old_length
					return ""
				elif text_old_length == 0:
					text = "-0"
					char_new_index = text.length()
					return ""
				else:
					text = text_old.insert(0, "-")
					char_new_index += 1
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					text = ""
				else:
					return ""
			# 0 replacement
			elif text_old == "-0":
				if char_new_ != "0":
					if char_new_index == 2:
						text = "-%s" % char_new_
						char_new_index = text.length()
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
					text = "0."
					char_new_index = text.length()
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					text = ""
				else:
					return ""
			# 0 replacement
			elif text_old == "0.":
				if char_new_ != "0":
					if char_new_index == 1:
						text = "%s." % char_new_
						char_new_index = text.length() - 1
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
					text = "0."
					char_new_index = text.length()
					return ""
				# Avoid things like '-.0'
				elif text_old.contains("-") and char_new_index == 1:
					return ""
				# Avoid things like '.0'
				elif char_new_index == 0:
					return ""
			elif char_new_ == "-":
				if text_old.contains("-"):
					# When inserting new text, via insert_text_at_caret, caret is moved 1
					if char_new_index != 0:
						char_new_index -= 1
					text = text_old.erase(0)
					# Do this change to avoid passing text_new_length < text_old_length
					text_new_length = text_old_length
					return ""
				elif text_old_length == 0:
					text = "-0"
					char_new_index = text.length()
					return ""
				else:
					text = text_old.insert(0, "-")
					char_new_index += 1
					return ""
			# 0 replacement
			elif text_old == "0":
				if char_new_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					text = ""
				else:
					return ""
			# 0 replacement
			elif text_old == "-0":
				# Avoid things like '1-0'
				if text_old.contains("-") and char_new_index == 0:
					return ""
				if char_new_ != "0":
					if char_new_index == 2:
						text = "-%s" % char_new_
						char_new_index = text.length()
						return ""
			# 0 replacement
			elif text_old == "0.":
				if char_new_ != "0":
					if char_new_index == 1:
						text = "%s." % char_new_
						char_new_index = text.length() - 1
						return ""
			# 0 replacement
			elif text_old == "-0.":
				# Avoid things like '1-0.'
				if text_old.contains("-") and char_new_index == 0:
					return ""
				if char_new_ != "0":
					if char_new_index == 2:
						text = "-%s." % char_new_
						char_new_index = text.length()
						return ""
			# Avoid things like '1-2' (see '0 replacement's to avoid '1-0', '1-0.')
			elif text_old.contains("-") and char_new_index == 0:
				return ""
			return char_new_


## Manages text input and filtering.
func _on_text_changed(text_new: String) -> void:
	# Update new length
	text_new_length = text.length()
	# If you select all text and press `-`/`.` it would break because of a
	## `text_new = ""`.
	if text_new == "":
		text = ""
		text_old = ""
		text_old_length = 0
		return
	# If deleting text, pass
	if text_new_length < text_old_length:
		text_old_length = text_new_length
		text_old = text_new
		# Avoid deleting only '0' from '0.'/'0-', delete all
		if text_new == "-" or text_new == ".":
			text = ""
			text_old = ""
			text_old_length = 0
		return
	# Else, need to determine the new character and the old text
	# New character
	char_new_index = caret_column - 1
	char_new = text[char_new_index]
	# Old text
	var left_text: String = text_new.substr(0, char_new_index)
	var right_text: String = text_new.substr(char_new_index+1, -1)
	text_old = left_text + right_text
	# Go back to the old text to decide insertion
	text = text_old
	# Filtering
	char_new = filter.call(char_new)
	# Set the caret at the right position for insertion
	caret_column = char_new_index
	# Insert new text at the right position
	insert_text_at_caret(char_new)
	# Update old length
	text_old = text
	text_old_length = text.length()


## Clamps the numeric value of the text if [param filter_mode] is a numeric mode.
## Note that since float("x.") = float("-x.") = 0 and similars (x is a digit),
## information is lost if clamping is done while typing.
## Clamp only when typing is finished.
func clamp_text() -> void:
	if filter_mode < 2:
		return
	var value: float = float(text)
	value = clamp(value, value_min, value_max)
	text = str(value)
