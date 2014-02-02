// test/viz-test.cpp
#include <GL/glew.h>
#include <SDL.h>
#include <SDL_opengl.h>
#include <viz/visualizer.hpp>
#include <string>
#include <iostream>

int main() {
  std::string path = "/Users/bgolder/projects/s096/nbody/src/shaders/vertex001.glsl";
  viz::Visualizer vi = viz::Visualizer();
  std::cout << "Built Visualizer\n";
  GLuint shaderId = vi.shaderFromFile( path, GL_VERTEX_SHADER );
  if( shaderId ) {
    std::cout << "Built shader " << shaderId << " from " << path << "\n";
  }
  return 0;
}

