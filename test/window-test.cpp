#define GLEW_STATIC
#include <GL/glew.h>
#include <SDL.h>
#include <SDL_opengl.h>

int main() {
  SDL_Init(SDL_INIT_VIDEO);
  SDL_Window* window = SDL_CreateWindow("OpenGL", 100, 100, 1000, 400, SDL_WINDOW_OPENGL);
  SDL_GLContext context = SDL_GL_CreateContext(window);
  SDL_Event windowEvent;
  glewExperimental = GL_TRUE;
  glewInit();

  float vertices[] = {
      0.0f,  0.5f,
      0.5f, -0.5f,
     -0.5f, -0.5f,
  };

  // initialize obeject to hold buffer
  // this is actually just a number that points to the object
  // GLuint is just an unsigned integer that is cross-platform
  GLuint vertexBufferObject;
  // create the buffer, store the number key
  glGenBuffers(1, &vertexBufferObject );
  // activates the object
  glBindBuffer( GL_ARRAY_BUFFER, vertexBufferObject );
  glBufferData( GL_ARRAY_BUFFER, sizeof( vertices ), vertices, GL_STATIC_DRAW );
  // Drawing options for buffers
  // GL_STATIC_DRAW - oploaded once, drawn many times
  // GL_DYNAMIC_DRAW - changed from time to time, drawn many times
  // GL_STREAM_DRAW - change almost every time it is drawn (like a UI)

  while (true) {
    if (SDL_PollEvent(&windowEvent)) {
      if (windowEvent.type == SDL_QUIT) break;
      if (windowEvent.type == SDL_KEYUP &&
              windowEvent.key.keysym.sym == SDLK_ESCAPE) break;
    }
    SDL_GL_SwapWindow(window);
  }
  SDL_GL_DeleteContext(context);
  SDL_Quit();
  return 0;
}
