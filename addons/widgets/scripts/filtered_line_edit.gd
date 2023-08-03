@tool
class_name FilteredLineEdit
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
@export_enum("none", "no-num", "+0i", "i", "+0f", "f") var filter_mode: int = 0
## Maximun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var max_value: float = +INF
## Minimun numeric value of the [param text]. Only used in numeric [param filter_mode].
@export var min_value: float = -INF

## [code]RegEx[/code] to filter text.
var reg: RegEx = RegEx.new()
## Text before inserting a new character.
var old_text: String
## Length of [param old_text].
var old_text_length: int = 0
## Lenght of [param new_text] in [code]_on_text_changed[/code].
var new_text_length: int = 0
## Character to be added
var new_char: String = ""
## Index of [param new_char] in [param new_text] in [code]_on_text_changed[/code].
var new_char_index: int
## Function called for filtering.
var filter: Callable


func _ready():
	old_text = text
	old_text_length = old_text.length()
	set_filter_mode(filter_mode)
	text_changed.connect(_on_text_changed)
	text_submitted.connect(_on_text_submitted)


func set_filter_mode(new_filter_mode: int) -> void:
	filter_mode = new_filter_mode
	# none
	if filter_mode == 0:
		filter = func filter_none(new_char_: String) -> String:
			return new_char_
	# text
	elif filter_mode == 1:
		reg.compile("\\d")
		filter = func filter_no_num(new_char_: String) -> String:
			if reg.search(new_char_) == null: return new_char_
			return ""
	# +0i
	elif filter_mode == 2:
		reg.compile("\\d")
		filter = func filter_p0_i(new_char_: String) -> String:
			if reg.search(new_char_) == null: return ""
			elif text == "0" and get_caret_column() != 0:
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_text("")
				else: return ""
			return new_char_
	# i
	elif filter_mode == 3:
		reg.compile("[\\d-]")
		filter = func filter_i(new_char_: String) -> String:
			if reg.search(new_char_) == null: return ""
			elif new_char_ == "-":
				if text.contains("-"):
					set_text(text.erase(0))
					set_caret_column(text.length())
					# Do this change to avoid passing new_text_length < old_text_length
					new_text_length = old_text_length
					return ""
				elif text.length() == 0:
					insert_text_at_caret("-0")
					return ""
				else:
					set_caret_column(0)
					insert_text_at_caret("-")
					set_caret_column(text.length())
					return ""
			elif text == "0" and get_caret_column() != 0:
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_text("")
				else: return ""
			elif text == "-0" and get_caret_column() != 0:
				if new_char_ != "0":
					set_text("-")
					set_caret_column(text.length())
				else: return ""
			return new_char_
	# +0f
	elif filter_mode == 4:
		reg.compile("[\\d.]")
		filter = func filter_p0_f(new_char_: String) -> String:
			if reg.search(new_char_) == null: return ""
			elif new_char_ == ".":
				if text.contains("."): return ""
				elif text.length() == 0: insert_text_at_caret("0")
			elif text == "0" and get_caret_column() != 0:
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_text("")
				else: return ""
			return new_char_
	# f
	elif filter_mode == 5:
		reg.compile("[\\d.-]")
		filter = func filter_f(new_char_: String) -> String:
			if reg.search(new_char_) == null: return ""
			elif new_char_ == ".":
				if text.contains("."): return ""
				elif text.length() == 0: insert_text_at_caret("0")
			elif new_char_ == "-":
				if text.contains("-"):
					set_text(text.erase(0))
					set_caret_column(text.length())
					# Do this change to avoid passing new_text_length < old_text_length
					new_text_length = old_text_length
					return ""
				elif text.length() == 0:
					insert_text_at_caret("-0")
					return ""
				else:
					set_caret_column(0)
					insert_text_at_caret("-")
					set_caret_column(text.length())
					return ""
			elif text == "0" and get_caret_column() != 0:
				if new_char_ != "0":
					# delete_char_at_caret() cannot be placed here due to length checks
					set_text("")
				else: return ""
			elif text == "-0" and get_caret_column() != 0:
				if new_char_ != "0":
					set_text("-")
					set_caret_column(text.length())
				else: return ""
			return new_char_


func get_filter_mode() -> int:
	return filter_mode


## Manages text input and filtering.
func _on_text_changed(new_text: String) -> void:
	# Update new length
	new_text_length = text.length()
	# If deleting text, pass
	if new_text_length < old_text_length:
		old_text_length = new_text_length
		return
	# Else, need to determine the new character and the old text
	# New character
	new_char_index = get_caret_column() - 1
	new_char = text[new_char_index]
	# Old text
	var left_text = new_text.substr(0, new_char_index)
	var right_text = new_text.substr(new_char_index+1, -1)
	old_text = left_text + right_text
	# Go back to the old text to decide insertion
	text = old_text
	# Set the caret at the right position for insertion
	set_caret_column(new_char_index)
	# Filtering
	new_char = filter.call(new_char)
	# Insert new text at the right position
	insert_text_at_caret(new_char)
	# Update old length
	old_text_length = new_text_length


## Clamps the numeric representation of the text if [param filter_mode] is a
## numeric mode.
func _on_text_submitted(new_text: String) -> void:
	if filter_mode < 2: return
	var value: float = float(new_text)
	value = clamp(value, min_value, max_value)
	if filter_mode == 2: value = int(value)
	text = str(value)
	set_caret_column(text.length())
