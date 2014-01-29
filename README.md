# 6.S096 Final Project

6.S096 - IAP 2014 - Effective Programming in C and C++ Final Project

A particle simulator in C++ that constitutes the final assignment for 6.S096
taught by Andre Kessler.

* [class website](http://web.mit.edu/6.s096/www/)
* [class grader](http://6.s096.scripts.mit.edu/grader/)
* [class Stellar site](https://stellar.mit.edu/S/course/6/ia14/6.S096)
* [class piazza site](https://piazza.com/class/hod1lhxsdfz6yc)
* [class coding standards](http://web.mit.edu/6.s096/www/standards.html)


### Makefile targets

* `make` — this is currently set to build all files
* `make all` — the same as above
* `make body` — builds all the dependencies of `install/test/body-test.x`
* `make body-test` — runs `make body` and then immediately runs the test
* `make system` — builds all the dependencies of `install/test/system-test.x`
* `make system-test` — runs `make system` and then immediately runs the test
* `make clean` — removes all files created by compilation

###Project Structure

    .
    |-- Makefile
    |-- Makefile.old
    |-- README.md
    |-- build
    |   `-- nbody
    |       |-- body-test.o
    |       `-- body.o
    |-- include
    |   |-- nbody
    |   |   |-- body.hpp
    |   |   `-- system.hpp
    |   `-- viz
    |-- install
    |   |-- include
    |   |   |-- body-test.o
    |   |   `-- body.o
    |   |-- lib
    |   |   `-- libnbody.a
    |   `-- test
    |       `-- body-test.x
    |-- make
    |   |-- all_head.mk
    |   |-- all_tail.mk
    |   `-- basic_make.mk
    |-- src
    |   |-- body.cpp
    |   `-- system.cpp
    |-- test
    |   |-- body-test.cpp
    |   `-- system-test.cpp
    `-- third_party
        `-- gtest
    38 directories, 198 files


N-body problem
Each one has an initial position

### Grading Scheme

* 25% physics (libnbody.a) or DLL
* 25% visualization (OpenGL )
* 15% unit testing - setup reference trajectories and try to write software in a
      modular fashion
* 15% software development process
* 10% interactivity - mouse, keyboard
* 10% do something cool

### Deadlines

* Wednesday 1/29 midnight: code review (30-100 lines, comments in code)
* Saturday 2/1 6pm: final deadline


### Notes

* By Wednesday midnight he wants a code review 10-100 lines
* comments in the code
* openMP easy parallels calculation
* use OpenGL
* what setup g++
* What integration method? basic, Hermit, Runge=Kutta, etc.
* How do we plug and play integrators?
      Create an interface for calculation
* How will we test our projects?
* how will we test our physics?
* what other properties might we add?
* how does the interaction interact with the model?
* small list of requirements
* write unit tests
* write code to satisfy tests
* review & refactor --> REPEAT

###OpenGL Tutorials

* [Learning Modern 3D Graphics Programming](http://www.arcsynthesis.org/gltut/)
* [OpenGL Tutorial](http://www.opengl-tutorial.org/)
* [OpenGL Programming & Modern OpenGL](http://en.wikibooks.org/wiki/OpenGL_Programming/Modern_OpenGL_Introduction)
* [Unofficial OpenGL Software Development Kit](http://glsdk.sourceforge.net/docs/html/index.html)

