## `WIcon` <a name="w_icon"></a>

Widget to hold an icon. Essentially is a `TextureRect` with `expand_mode = TextureRect.EXPAND_IGNORE_SIZE` and
`stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED`.

### Properties

| Type      | Property | Basic Description                                | Default Value |
|-----------|----------|--------------------------------------------------|---------------|
| Texture2D | texture  | Icon texture                                     |               |
| bool      | flip_h   | If `true`, icon texture is flipped horizontally. | false         |
| bool      | flip_v   | If `true`, icon texture is flipped vertically.   | false         |
