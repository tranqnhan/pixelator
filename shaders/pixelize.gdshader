shader_type canvas_item;

uniform int pkernel_size;
uniform sampler2D image;

void fragment() {
	if (pkernel_size > 0) {
		vec4 tex_color = vec4(0.0, 0.0, 0.0, 0.0);
		ivec2 isize = textureSize(image, 0);
		vec2 size = vec2(float(isize.x), float(isize.y));
		int k = pkernel_size * pkernel_size;
		vec2 corner = (floor((UV * size) / float(pkernel_size)) * float(pkernel_size)) / size;
		for(int y = 0; y < pkernel_size; y++) {
			for(int x = 0; x < pkernel_size; x++) {

				vec2 pos = corner + vec2(TEXTURE_PIXEL_SIZE.x * float(x), TEXTURE_PIXEL_SIZE.y * float(y));
				//if (pos.y > size.y || pos.x > size.x) continue;

				tex_color += texture(image, pos);
			}
		}
		COLOR = tex_color / float(k);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
