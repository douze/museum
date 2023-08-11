shader_type canvas_item;

uniform sampler2D view_prepass;
uniform sampler2D view_blure;
uniform sampler2D view_scene;
uniform float intensity : hint_range(0, 5) = 3;

void fragment() {
	vec3 prepass = texture(view_prepass, UV).xyz; // prepass
	vec3 blure = texture(view_blure, UV).xyz; // blurred
	vec3 col = texture(view_scene, UV).xyz; // col
	vec3 glow = min(vec3(1,1,1), max(vec3(0,0,0), blure - prepass)*intensity);
	float luminance = glow.r * 0.299 + glow.g * 0.587 + glow.b * 0.114;
	vec3 glow_inv = vec3(1.0,1.0,1.0) - vec3(luminance,luminance,luminance);
	COLOR.xyz = col*glow_inv + glow;
	
	//COLOR.xyz = vec3(1.0)-glow ; //col +  vec3(1.0,1.0,1.0) - (blure-prepass)*3.0;//*vec3(1,0,0);
	//COLOR.xyz = col;
}