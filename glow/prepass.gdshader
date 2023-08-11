shader_type canvas_item;

uniform sampler2D tex;

void fragment() {
	COLOR.xyz = texture(TEXTURE, UV).xyz;
	if (COLOR.xyz != vec3(0)) {
		COLOR.xyz = vec3(1,0,0);
	}
}
