#include <SDL.h>
#include <SDL_opengl.h>

int main() {
  SDL_Init(SDL_INIT_VIDEO);
  SDL_Window* window = SDL_CreateWindow("OpenGL", 100, 100, 800, 600, SDL_WINDOW_OPENGL);
  SDL_GLContext context = SDL_GL_CreateContext(window);
  SDL_Event windowEvent;
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
