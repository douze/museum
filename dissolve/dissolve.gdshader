shader_type spatial;

//render_mode depth_draw_always;

uniform vec4 base_color : source_color = vec4(0.0);
uniform sampler2D noise_texture: source_color;
uniform float noise_strength : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float cutoff_height : hint_range(-1.0, 1.0, 0.1) = 0.0;
uniform bool use_time = false;

varying vec3 local_position;

float remap(float value, float inMin, float inMax, float outMin, float outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

void vertex() {
	local_position = VERTEX;
}

void fragment() {
	float value = texture(noise_texture, UV).r;
	float mapped = remap(value, 0, 1, -noise_strength, noise_strength);
	ALBEDO = base_color.rgb;

	// cutoff
	float alpha = step(local_position.y, mapped + cutoff_height);
	// time
	if (use_time) {
		alpha = step(local_position.y, mapped + sin(TIME*0.5));
	}
	
	ALPHA = alpha; 
	
	METALLIC = 0.8;
	ROUGHNESS = 0.2;
}
