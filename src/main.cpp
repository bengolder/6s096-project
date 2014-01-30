//
//  main.cpp
//  OpenGL_Test
//
//  Created by j_duro on 1/28/14.
//  Copyright (c) 2014 j_duro. All rights reserved.
//

#include <iostream>
#include <GLUT/GLUT.h>
#include <vector>
#include "Body.h"

using namespace std;

int width  = 500;
int height = 500;
float fov  = 65;
float near = 1.0f;
float far  = 500.0f;
float rotx  = 0;
float roty = 0;

const int nBodySize = 100;
Body bodies[nBodySize];

void mouse( int button, int state, int x, int y )
{
    
}

void keyboard( unsigned char c, int x, int y )
{
    switch( c )
    {
        //case 'f':
            //std::cout << "f pressed " << "\n";
            //rot++;
        //    break;
        //case GLUT_KEY_UP:
        //    rotx++;
        default:
            break;
    }
}

void special( int i, int x, int y )
{
    switch( i )
    {
        case GLUT_KEY_UP:
            rotx++;
            break;
        case GLUT_KEY_DOWN:
            rotx--;
            break;
        case GLUT_KEY_LEFT:
            roty++;
            break;
        case GLUT_KEY_RIGHT:
            roty--;
            break;

        case 27:
            //mExit();
            break;
        default:
            break;
    }
}


void reshape( int w, int h )
{
    glViewport( 0, 0, w, h );
}

void scene()
{
    ///*
    glEnable( GL_POINT_SPRITE ); // GL_POINT_SPRITE_ARB if you're
    // using the functionality as an extension.
    
    glEnable( GL_POINT_SMOOTH );
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    glPointSize( 6.0 );
    
    
    //glActiveTexture(GL_TEXTURE0);
    //glEnable( GL_TEXTURE_2D );
    //glTexEnvi(GL_POINT_SPRITE, GL_COORD_REPLACE, GL_TRUE);
    //glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
    //glBindTexture(GL_TEXTURE_2D, texture_name);
    
	glPushMatrix();
    //glTranslatef(rot,0,0);
    glRotatef(roty, 0, 1, 0);
    glRotatef(rotx, 1, 0, 0);
    
    glBegin( GL_POINTS );
    glColor4f( 0.95f, 0.207, 0.031f, 1.0f );
    for ( int i = 0; i < nBodySize; ++i )
    {
        glVertex3f( bodies[i].x(), bodies[i].y(), bodies[i].z());
    }
    glEnd();
    glPopMatrix();
}

void display( void )
{
    // Clear Screen and Depth Buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(0.0f,0.0f,-3.0f);
    
    scene();
    
	glutSwapBuffers();
    glutPostRedisplay();
}

void initialize()
{
    // select projection matrix
    glMatrixMode(GL_PROJECTION);
    // set the viewport
    glViewport(0, 0, width, height);
    // set matrix mode
    glMatrixMode(GL_PROJECTION);
    // reset projection matrix
    glLoadIdentity();															
    GLfloat aspect = (GLfloat) width / height;
    // set up a perspective projection matrix
	gluPerspective(fov, aspect, near, far);
	// specify which matrix is the current matrix
    glMatrixMode(GL_MODELVIEW);													
    glShadeModel( GL_SMOOTH );
    // specify the clear value for the depth buffer
    glClearDepth( 1.0f );														
    glEnable( GL_DEPTH_TEST );
    glDepthFunc( GL_LEQUAL );
    // specify implementation-specific hints
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );
	glClearColor(0.0, 0.0, 0.0, 1.0);
}

void setBodies()
{
    for ( int i = 0; i < nBodySize; ++i )
    {
        int sigx = rand() % 100; if (sigx<50) sigx = -1; else sigx = 1;
        int sigy = rand() % 100; if (sigy<50) sigy = -1; else sigy = 1;
        int sigz = rand() % 100; if (sigz<50) sigz = -1; else sigz = 1;
        //
        bodies[i] = {0, sigx * 0.01 * (rand() % 100), sigy * 0.01 * (rand() % 100), sigz * 0.01 * (rand() % 100) };
    }
   
}

int main(int argc, char **argv)
{
    // initialize window
    glutInit( &argc, (char**)&argv );
    glutInitWindowSize( width, height );
    glutInitDisplayMode( GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH );
    glutCreateWindow( "Nbody" );
    // specify callbacks
    glutDisplayFunc ( display  );
    glutReshapeFunc ( reshape  );
    glutKeyboardFunc( keyboard );
    glutSpecialFunc ( special  );
    glutMouseFunc   ( mouse    );
    
    initialize();
    
    setBodies();
    
    glutMainLoop();
    return 0;
}
