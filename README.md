# 6.S096 Final Project

6.S096 - IAP 2014 - Effective Programming in C and C++ Final Project

A particle simulator in C++ that constitutes the final assignment for 6.S096
taught by Andre Kessler.

* [class website](http://web.mit.edu/6.s096/www/)
* [class grader](6.s096.scripts.mit.edu/grader/)
* [class Stellar site](https://stellar.mit.edu/S/course/6/ia14/6.S096)
* [class piazza site](https://piazza.com/class/hod1lhxsdfz6yc)
* [class coding standards](http://web.mit.edu/6.s096/www/standards.html)


Project Structure:

    .
    ├── Makefile
    ├── README.md
    ├── build
    │   └── myproject
    │       └── something.o
    ├── include
    │   └── myproject
    │       └── someheader.h
    ├── install
    │   ├── bin
    │   │   └── something
    │   ├── include
    │   │   └── whatever.h
    │   ├── lib
    │   │   └── sure.o
    │   └── test
    │       └── something-test.cpp
    ├── make
    │   ├── all_head.mk
    │   └── all_tail.mk
    ├── src
    │   ├── someclass.cpp
    │   └── something.cpp
    └── test
        └── somethign-test.cpp

12 directories, 13 files


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

* Monday 1/29 midnight: code review (30-100 lines, comments in code)
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

OPENGL BRANCH



