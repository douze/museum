shader_type spatial;

render_mode cull_front;

const float outline_width = 6.0;

void vertex() {
	vec4 position = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	vec3 normal = normalize(mat3(PROJECTION_MATRIX) * MODELVIEW_NORMAL_MATRIX * NORMAL);
	position.xy += normal.xy * outline_width / VIEWPORT_SIZE ;
	POSITION = position;
}

void fragment() {
	ALBEDO = vec3(0);
}