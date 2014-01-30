#include <algorithm>
#include <string>
#include <vector>
#include <stdio.h>
#include <glload/gl_3_2_comp.h>
#include <GL/freeglut.h>

GLuint CreateShader( GLenum eShaderType, const std::string &strShaderFile ) {
  GLuint shader = glCreateShader( eShaderType );
  const char *strFileData = strShaderFile.c_str();
  glShaderSource( shader, 1, &strFileData, NULL );
  glCompileShader( shader );

  GLint status;

  glGetShaderiv( shader, GL_COMPILE_STATUS, &status );
  if( status == GL_FALSE ) {

  }

}




