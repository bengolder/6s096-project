#define GLEW_STATIC
#include <GL/glew.h>
#include <SDL.h>
#include <SDL_opengl.h>
#include <string>
#include <iterator>
#include <iostream>
#include <fstream>
#include <viz/visualizer.hpp>
 
GLuint viz::Visualizer::shaderFromFile( std::string filePath, GLenum shaderType ) {
  std::cout << "getting " << filePath << " with " << shaderType << "\n";
  GLuint shaderID = 0;
  return shaderID;
  // get file
  std::string fileString;
  std::ifstream sourceFile;
  sourceFile.open( filePath.c_str() );
  if( sourceFile ) {
    fileString.assign( 
        ( std::istreambuf_iterator<char>( sourceFile ) ), 
        std::istreambuf_iterator<char>() 
        );
    // create shader from resulting string
    shaderFromString( fileString, shaderType );
  }
}

GLuint viz::Visualizer::shaderFromString( std::string shaderString, GLenum shaderType ) {
  // create shader ID and sset shader source
  GLuint shaderID = 0;
  shaderID = glCreateShader( shaderType );
  const GLchar* shaderSource = shaderString.c_str();
  glShaderSource( shaderID, 1, (const GLchar**)&shaderSource, NULL );
  // compile shader source
  glCompileShader( shaderID );
  //Check shader for errors
  GLint shaderCompiled = GL_FALSE;
  glGetShaderiv( shaderID, GL_COMPILE_STATUS, &shaderCompiled );
  if( shaderCompiled != GL_TRUE ) {
      printf( "Unable to compile shader %d!\n\nSource:\n%s\n", shaderID, shaderSource );
      glDeleteShader( shaderID );
      shaderID = 0;
  }
  return shaderID;
}


