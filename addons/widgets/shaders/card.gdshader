// Source: https://stackoverflow.com/questions/76856614/is-there-any-way-in-godot-3-5-x-to-round-corners-of-images
// Theraot answer
// Consulted on 20/08/2023 at 14.00 GTM
shader_type canvas_item;
uniform sampler2D tex;

void fragment() {
    COLOR = texture(tex, UV);
}