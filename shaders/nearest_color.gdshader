shader_type canvas_item;

uniform int num_colors;
uniform vec4 colors[256];

void fragment() {
	if (num_colors > 0) {
		// Apply colors
		int n = min(num_colors, 256);
		float cur_distance = 2.0;
		vec4 color = COLOR;
		float dist = 0.0;
		for (int i = 0; i < n; i++) {
			dist = distance(COLOR, colors[i]);
			if (dist < cur_distance) {
				color = colors[i];
				cur_distance = dist;
			}
		}
		COLOR = color;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
