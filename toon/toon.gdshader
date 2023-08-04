shader_type spatial;
render_mode ambient_light_disabled;

uniform vec4 base_color : source_color;

const float specular_glossiness = 16.0;
const float rim_amount = 0.7;

void fragment() {
	ALBEDO = base_color.xyz;
}

void light() {
	// Diffuse
	float n_dot_l = dot(NORMAL, LIGHT);
	float diffuse = smoothstep(0, 0.01, n_dot_l);
	// Specular
	vec3 half_vector = normalize(VIEW + LIGHT);
	float n_dot_hv = dot(NORMAL, half_vector);
	float specular = smoothstep(0.005, 0.01, pow(n_dot_hv * diffuse, specular_glossiness * specular_glossiness));
	// Rim
	float n_dot_v = dot(NORMAL, VIEW);
	float rim = (1.0 - n_dot_v) * pow(n_dot_l, 0.1);
	rim = smoothstep(rim_amount - 0.01, rim_amount + 0.01, rim);
	
	DIFFUSE_LIGHT = ALBEDO * ATTENUATION *  ((diffuse + specular + rim) * LIGHT_COLOR);
}