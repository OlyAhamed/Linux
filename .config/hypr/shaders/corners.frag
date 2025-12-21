#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec2 uv = v_texcoord;
    vec4 color = texture(tex, uv);

    // Settings
    float radius = 0.05; // Made larger to be very obvious
    vec4 cornerColor = vec4(0.0, 0.0, 0.0, 1.0); // Change to vec4(1.0, 0.0, 0.0, 1.0) for RED test

    // Distance logic for all 4 corners
    vec2 res = vec2(textureSize(tex, 0));
    float aspect = res.x / res.y;
    
    // Normalize coordinates to handle aspect ratio
    vec2 scaled_uv = uv;
    // If corners look like ovals, we would adjust 'scaled_uv.x * aspect' here.

    bool is_corner = false;

    // Top Left
    if (uv.x < radius && uv.y > (1.0 - radius)) {
        if (distance(uv, vec2(radius, 1.0 - radius)) > radius) is_corner = true;
    }
    // Top Right
    if (uv.x > (1.0 - radius) && uv.y > (1.0 - radius)) {
        if (distance(uv, vec2(1.0 - radius, 1.0 - radius)) > radius) is_corner = true;
    }
    // Bottom Left
    if (uv.x < radius && uv.y < radius) {
        if (distance(uv, vec2(radius, radius)) > radius) is_corner = true;
    }
    // Bottom Right
    if (uv.x > (1.0 - radius) && uv.y < radius) {
        if (distance(uv, vec2(1.0 - radius, radius)) > radius) is_corner = true;
    }

    if (is_corner) {
        fragColor = cornerColor;
    } else {
        fragColor = color;
    }
}
