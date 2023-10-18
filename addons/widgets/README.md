# Godot-Widgets

![](https://github.com/acgc99/Godot-Widgets/blob/main/assets/widgets.png?raw=true)

This Godot plugin implement multiple `Node`s designed for mobile GUIs.

It is inspired by [Material Design](https://m3.material.io/), but I am doing it to fit my needs while trying to generalize a bit for other users and learning more about Godot. If you have new ideas, feel free to share them.

| About      | Current Release                     |
|------------|-------------------------------------|
| Version    | 3.0.0 **(under development)**       |
| Date       | yyyy/mm/dd                          |
| Godot      | Godot 4.1.2                         |
| License    | [MIT License](../../LICENSE.md)     |
| Author     | [acgc99](https://github.com/acgc99) |

**Widgets Index**:
- [`WIcon`](#w_icon)
- [`WRoundClippingContainer`](#w_round_clipping_container)
- [`WFilteredLineEdit`](#w_filtered_line_edit)
- [`WFilteredTextEdit`](#w_filtered_text_edit)
- [`WHSizingContainer`](#w_h_sizing_container)
- [`WIconButton`](#w_icon_button)
- [`WIconLabelIcon`](#w_icon_label_icon)
- [`WTextureRounded`](#w_texture_rounded)
- [`WNavBar`](#w_nav_bar)
- [`WNumericInput`](#w_numeric_input)
- [`WPopup`](#w_popup_b1)
- [`WCard`](#w_card)
- [`WPopupB1`](#w_popup_b1)
- [`WPopupB2`](#w_popup_b2)

## `WIcon` <a name="w_icon"></a>

Widget to hold an icon. Essentially is a `TextureRect` with `expand_mode = TextureRect.EXPAND_IGNORE_SIZE` and
`stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED`.

### Properties

| Type      | Property | Basic Description                                | Default Value |
|-----------|----------|--------------------------------------------------|---------------|
| Texture2D | texture  | Icon texture                                     |               |
| bool      | flip_h   | If `true`, icon texture is flipped horizontally. | false         |
| bool      | flip_v   | If `true`, icon texture is flipped vertically.   | false         |

## `WRoundClippingContainer` <a name="w_round_clipping_container"></a>

## `WFilteredLineEdit` <a name="w_filtered_line_edit"></a>

## `WFilteredTextEdit` <a name="w_filtered_text_edit"></a>

## `WHSizingContainer` <a name="w_h_sizing_container"></a>

## `WIconButton` <a name="w_icon_button"></a>

## `WIconLabelIcon` <a name="w_icon_label_icon"></a>

## `WTextureRounded` <a name="w_texture_rounded"></a>

## `WNavBar` <a name="w_nav_bar"></a>

## `WNumericInput` <a name="w_numeric_input"></a>

## `WPopup` <a name="w_popup"></a>

## `WCard` <a name="w_card"></a>

## `WPopupB1` <a name="w_popup_b1"></a>

## `WPopupB2` <a name="w_popup_b2"></a>
