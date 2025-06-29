shader_type canvas_item;

uniform float epsilon = 0.0001;
uniform sampler2D colors;
uniform vec4 target_colors[16] : source_color;

void fragment() {
	float data = texture(TEXTURE, UV).r;
	for (int i = 0; i < target_colors.length(); i++) {
	    if (length(COLOR - target_colors[i]) < epsilon){
			COLOR = texture(colors, vec2(data, 0.0));
			COLOR = vec4(COLOR.r,COLOR.g, COLOR.b, texture(TEXTURE, UV).a);
			break;
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
