# Contributing

## New ideas

Open an issue so you can tell why it is important and how others could benefit from that idea.

## Code Contributions

Things to take care of:
- Order of calling: `_init > getters > setters > _enter_tree > _ready`.

Rules for new widgets (open issue if not applied to existing ones):
- When a widget uses another widget, export its properties (only customizable ones) with `@export_category`. In the case of widgets like `WNavBar`, this is not possible, because it uses two `WIconButton`... so in that cases, use `@export_group` specifying which widget is under that group.
- Naming conventions:
  - Variable naming convention. In general, use `<name>_<adjectives>`, e.g.: `button_left`. For variables exposed on the Inspector, use human readable names, e.g.: `left_texture` for `button_left` texture (in this case, since there is a "left", it would be required to use a `@export_group` or `@export_subgroup` with prefix `left`).
  - Method naming convention. Use actions in present simple, e.g.: `clamp_values`. If a variable name has to appear on the signature, keep it as it is.
  - Signal naming convention. Use actions in past simple, e.g.: `values_clamped`. Use human readable form.
- Take care of widgets minimum size.
- Document inner children use.
- Widgets must have an unique icon of format `.svg` and color `#8eef97`.

Recomended names:
- If the widget has a main container, put `# Main widget container.` above its declaration.
- `PanelContainer`: `_container_panel`.
- `TextureRect`: `_texture`.
- `WIcon`: `_icon`.
- `WRoundClippingContainer`: `_container_clipping`.
- `WIconLabelIcon`: `ili`.
- If there is a button-label-button, use `blb`.

## Documentation Contributions

- Format:
  - Separate markdown files for each widget at `docs/files`:
  - File has to have the same name as the corresponding GDScript file.
  - File has to start with "\#\# \`<widget name\>\`".
  - File has to end with an empty line.
- Widget description:
  - Give basic description.
  - Widget public properties have to be in a table (type-property-basic description-default value).
  - Widget public methods have to be in a table (return type-signature-basic descriotion).
  - Widget signals have to be in a table (signature-basic description).
  - Explain each public property, public method and signal.
- Integration:
  - Add reference to it on `files/source.md` at the right position: level 0 for widgets that doesn't depend on other widgets; level 1 for widgets that depend on another widget class; level 2 for widgets that depend on two widget classes... This file has to end with an empty line.
  - Add reference to it on `docs/files/main.md` widgets index.
  - Run `docs/docs_merger.py` to generate `README.md`

For table design and modifications, [Tables Generator](https://www.tablesgenerator.com/markdown_tables) is recommended.