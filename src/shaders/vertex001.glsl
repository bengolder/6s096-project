#version 150

// glsl has built in vec* and mat* types
in vec2 position;

void main() {
  gl_Position = vec4( position.x, position.y, 0.0, 1.0 );
  // equal to 
  // gl_Position = vec4( position, 0.0, 1.0 );
  // can also use
  // gl_Position = vec4( position.r, position.g, 0.0, 1.0 );

}



