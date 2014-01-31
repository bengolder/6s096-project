PROG := nbody
SHELL := /bin/sh
CC := gcc
CXX := g++
UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
	GLFLAG := -lGL
endif
ifeq ($(UNAME), Darwin)
	GLFLAG := -framework OpenGL
endif

COMPILER_OPTIONS := -m64 -Wall -Wextra -Wshadow -Werror -pedantic -Iinclude
CFLAGS := -std=c99 $(COMPILER_OPTIONS)
CXXFLAGS := -std=c++11 $(COMPILER_OPTIONS)
DEBUGFLAGS := -g -O0 -D _DEBUG
RELEASEFLAGS := -O2 -D NDEBUG

# these are for finding dynamic & static libraries
LDFLAGS := -L install/lib \
		   -L /usr/local/lib \
		   -l m -l pthread  \
		   $(GLFLAG)

# these are used to find .h header files, based on includes from .cpp files
INCLUDEFLAGS := -I include/$(PROG) \
				-I install/lib \
				-I third_party/gtest \
				-I third_party/gtest/include

# $@ is the current target
# $^ is all the prerequisites
# $< is the first prerequisite

# executables and archives
install/test/body-test.x: install/include/body-test.o \
						  install/include/body.o | install/test install/lib
	ar rcs install/lib/libnbody.a install/include/body.o
	$(CXX) -o $@ $< $(LDFLAGS) -lnbody

install/test/system-test.x: install/include/system-test.o \
							install/include/system.o \
							install/include/body.o | install/test install/lib
	ar rcs install/lib/libnbody.a install/include/body.o install/include/system.o
	$(CXX) -o $@ $< $(LDFLAGS) -lnbody

# vizualization library
install/test/window-test.x: test/window-test.cpp | install/test
	$(CXX) -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)

# object files

install/include/body.o: src/body.cpp | install/include
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)
install/include/body-test.o: test/body-test.cpp | install/include
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)

install/include/system.o: src/system.cpp | install/include
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)
install/include/system-test.o: test/system-test.cpp | install/include
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)

install:
	mkdir $@

install/include install/test install/lib: | install
	mkdir $@


# compiling targets
.PHONY : all body body-test system system-test clean test viz

all: install/test/body-test.x

body: install/test/body-test.x

body-test: install/test/body-test.x
	$< # run prereq

system: install/test/system-test.x

system-test: install/test/system-test.x
	install/test/body-test.x
	$< # run prereq

viz: install/test/window-test.x
	$<

test: system-test

clean:
	rm -f install/test/*.x install/lib/*.a install/include/*.o

again:
	make clean
	make body-test

