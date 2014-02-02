/*
 * Class for setting up OpenGL Vizualizations
 */
#define GLEW_STATIC
#include <GL/glew.h>
#include <SDL.h>
#include <SDL_opengl.h>
#include <string>

namespace viz {
  class Visualizer {
    public:
      Visualizer( int width, int height );
      // rule of three
      Visualizer( const Visualizer& other );
      Visualizer& operator=( const Visualizer& other );
      ~Visualizer();
      GLuint shaderFromFile( std::string filePath, GLenum shaderType );
      GLuint shaderFromString( std::string shaderString, GLenum shaderType );
      void quit();
  };
}
