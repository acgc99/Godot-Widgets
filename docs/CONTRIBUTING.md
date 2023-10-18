# Contributing

---

## Code Contributions

Work in Progress

---

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