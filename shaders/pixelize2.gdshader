shader_type canvas_item;

uniform int pkernel_size;
uniform sampler2D image;

const int MAX_KERNEL_SIZE = 10;
const int MAX_COLORS = MAX_KERNEL_SIZE * MAX_KERNEL_SIZE;

void fragment() {
	int kernel_size = min(pkernel_size, MAX_KERNEL_SIZE);
	if (kernel_size > 0) {
		ivec2 isize = textureSize(image, 0);
		vec2 size = vec2(float(isize.x), float(isize.y));
		int k = kernel_size * kernel_size;
		vec2 corner = (floor((UV * size) / float(kernel_size)) * float(kernel_size)) / size;

		vec4 colors[MAX_COLORS];
		int color_count[MAX_COLORS];
		int num_color = 0;
		for(int y = 0; y < kernel_size; y++) {
			for(int x = 0; x < kernel_size; x++) {
				vec2 pos = corner + vec2(TEXTURE_PIXEL_SIZE.x * float(x), TEXTURE_PIXEL_SIZE.y * float(y));

				int i = 0;
				while(i < num_color) {
					if (texture(image, pos) == colors[i]) break;
					i++;
				}

				if (i == MAX_COLORS) break;

				if (i == num_color) {
					colors[i] = texture(image, pos);
					color_count[i] = 1;
					num_color += 1;
				} else {
					color_count[i] += 1;
				}
			}
		}

		int medium_color;
		int highest_count = 0;
		for (int i = 0; i < num_color; i++) {
			if (color_count[i] > highest_count) {
				medium_color = i;
				highest_count = color_count[i];
			}
		}

		COLOR = colors[medium_color];
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
