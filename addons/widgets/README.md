## Godot-Widgets

A collection of widgets that are useful for GUIs. Inspired by [Material Design](https://m3.material.io/).

Inspired means "inspired", you won't find the exact same things here.

Widgets are highly customizable, check their properties in the Godot Editor. If you feel that something is missing or there is a bug, please, open a new issue.

If you download the full repository, you will get a small showcase project.

---

### FilteredEdits (v2.0.0)

The original addon [FilteredEdits](https://godotengine.org/asset-library/asset/1992) has been embedded into this plugin to avoid dependencies issues. There is no problem since I'm the same author. **Attention: this makes this plugin incompatible with FilteredEdits, disable or remove that plugin, you will find the same functions here.**

---

### `IconButton`

A button that consists on an icon. You might have to set its `custom_minimum_size` if used inside a `Container` or any of its variations.

It is used for other widgets, but you can also use it.

---

### `NavBar`

Widget to navigate through game scenes. It contains buttons and a label, you have to implement the logic for switching scenes.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/navbar.png" width="500"/>
</p>

---

### `NumericInput`

Widget so that the game user can only input numeric values (`float`). It also has two buttons to increase/decrease the value.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/numeric_input.png" width="500"/>
</p>

---

### `OneButtonPopup`

A popup with one button. Smooth appearing/disappearing.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/one_button_popup.png" height="300"/>
</p>

---

### `TwoButtonsPopup`

A popup with two buttons. Smooth appearing/disappearing.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/two_buttons_popup.png" height="300"/>
</p>

---

### `TextureRounded`

Like `TextureRect` but with rounded corners.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/texture_rounded.png" height="200"/>
</p>

Known issues:
- If 'strecth_mode = keep_aspect_covered', texture borders might be not visible, since they are outside the node rectangle (although they are rounded).
- It is recommended to reload the scene if you changed the node properties and you get weird results in the Editor. It seems that they are not updated correctly.

---

### `Card`

Like `TextureRect` but with rounded corners and a panel for text and acts like a button.

<p align="center">
  <img src="https://raw.githubusercontent.com/acgc99/Godot-Widgets/main/screenshots/card.png" height="200"/>
</p>

Known issues:
- If 'strecth_mode = keep_aspect_covered', texture borders might be not visible, since they are outside the node rectangle (although they are rounded).
- It is recommended to reload the scene if you changed the node properties and you get weird results in the Editor. It seems that they are not updated correctly.

---

### Assets

All non-Godot icons has been downloaded form [Pictogrammers](https://pictogrammers.com/docs/general/license/).
