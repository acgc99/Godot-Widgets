shader_type canvas_item;
// Shader to round corners of a canvas. The 'radius_scale' is multiplied by
// minimum(width, height)/2.0 to calculate the radius of the corners.
// Panel length is calculated by multiplying 'radius' and 'panel_scale'.
// If 'panel_pos' is true, the panel will be on bottom, else on top.
//
// Instructions:
// 1) The node that uses this shader must have signals 'tree_entered' and
// 'item_rect_changed' connected to a callable with the next code:
// material.set_shader_parameter("width", size.x)
// material.set_shader_parameter("height", size.y)
//
// Known issues:
// 1) If used on 'TextureRect', take care of 'expand_mode' and 'stretch_mode',
// because image corners might be outside node rectangle and therefore clipped.
// Corners are rounded, but they are outside node's rectangle.


uniform float radius_scale: hint_range(0.0, 1.0, 0.1) = 0.1;
uniform bool rounded_corner_top_left = true;
uniform bool rounded_corner_top_right = true;
uniform bool rounded_corner_bottom_left = true;
uniform bool rounded_corner_bottom_right = true;
uniform vec4 panel_color: source_color = vec4(0.0);
uniform float panel_scale: hint_range(1.0, 4.0, 0.1) = 2.0;
uniform bool panel_pos = true;
uniform float width = 1.0;
uniform float height = 1.0;


void fragment() {
	vec4 image = texture(TEXTURE, UV);
	vec2 pos = vec2(UV.x*width, UV.y*height);
	float radius = min(width, height)*radius_scale/2.0;
	float dist;
	// Top left corner
	if (rounded_corner_top_left) {
		dist = length(pos - vec2(radius));
		if (dist > radius && pos.x < radius && pos.y < radius) {
			image.a = 0.0;
		}
		// debugging only
//		if (dist < radius){image.r = 1.0;}
	}
	// Top right corner
	if (rounded_corner_top_right) {
		dist = length(pos - vec2(width-radius, radius));
		if (dist > radius && pos.x > width-radius && pos.y < radius) {
			image.a = 0.0;
		}
		// debugging only
//		if (dist < radius){image.r = 1.0;}
	}
	// Bottom left corner
	if (rounded_corner_bottom_left) {
		dist = length(pos - vec2(radius, height-radius));
		if (dist > radius && pos.x < radius && pos.y > height-radius) {
			image.a = 0.0;
		}
		// debugging only
//		if (dist < radius){image.r = 1.0;}
	}
	// Bottom right corner
	if (rounded_corner_bottom_right) {
		dist = length(pos - vec2(width-radius, height-radius));
		if (dist > radius && pos.x > width-radius && pos.y > height-radius) {
			image.a = 0.0;
		}
		// debugging only
//		if (dist < radius){image.r = 1.0;}
	}
	// Panel
	float panel_length = radius*panel_scale;
	bool inside_panel;
	if (panel_pos) {
		inside_panel = height - pos.y <= panel_length;
	}
	else{
		inside_panel = pos.y <= panel_length;
	}
	if (inside_panel && image.a > 0.0){
		image = mix(image, panel_color, panel_color.a);
	}
	COLOR = image;
}
