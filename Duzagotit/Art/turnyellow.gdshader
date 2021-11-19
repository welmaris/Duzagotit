shader_type canvas_item;

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel

    if (curr_color.w >= 0.8){
        COLOR = vec4(1,1,0,0.8);
    }else{
        COLOR = vec4(0,0,0,0);
    }
}