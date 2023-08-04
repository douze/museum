shader_type spatial;

uniform vec4 base_color : source_color = vec4(0.0);
uniform vec4 edge_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform sampler2D noise_texture: source_color;
uniform float noise_strength : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float cutoff_height : hint_range(-1.0, 1.0, 0.1) = 0.0;
uniform bool use_time = false;

varying vec3 local_position;

const float edge_width = 0.05;

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
	
	float time = sin(TIME * 0.5);

	// alpha: cutoff or time
	float alpha = step(local_position.y, mapped + cutoff_height);
	if (use_time) {
		alpha = step(local_position.y, mapped + time);
	}
	ALPHA = alpha; 
	
	// glow
	float edge = step(mapped + cutoff_height, local_position.y + edge_width);
	if (use_time) {
		edge = step(mapped + sin(TIME*0.5),local_position.y + edge_width);
	}
	EMISSION = edge_color.xyz * edge;
	
	METALLIC = 0.8;
	ROUGHNESS = 0.2;
}
