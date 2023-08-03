## Godot-Widgets

---

### FilteredEdits

Extends base nodes `LineEdit` and `TextEdit` with `FilteredLineEdit` and `FilteredTextEdit`, respectively, to filter user input. `FilteredLineEdit` also allows numeric text value clamping.

Filter modes:
- `none`: no filter.
- `no-num`: no 0-9 characters.
- `+0i`: positive or zero integer.
- `i`: integer.
- `+0f` positive or zero float.
- `f` float.

Notes:
- "." and "-" count as characters in max length.
- `FilteredLineEdit` can clamp text numeric value when a numeric filter mode is selected, but `FilteredTextEdit` cannot (base class lacks of `text_submitted` signal).
- I [requested](https://github.com/godotengine/godot-proposals/issues/7193) these features to be implemented in base Godot, that would require changing base node signals. Meanwhile, I created this workaround.

#### Known issues

- If you type very quickly in a numeric filter mode mixing numbers and letters, letters may pass the filtering. I think this is a limitation by how `LineEdit` and `TextEdit` handle input.

---

### IconButton

A button that consists on an icon. You might have to set its `custom_minimum_size` if used inside a `Container` or any of its variations.

---

### NavBar

Navigation bar intended to be used to switch between game/app screens/pages.

---

### Assets

All non-Godot icons has been downloaded form [Pictogrammers](https://pictogrammers.com/docs/general/license/).