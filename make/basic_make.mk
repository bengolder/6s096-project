PROG := nbody
SHELL := /bin/sh
CC := gcc
CXX := g++

COMPILER_OPTIONS := -m64 -Wall -Wextra -Wshadow -Werror -pedantic -Iinclude
CFLAGS := -std=c99 $(COMPILER_OPTIONS)
CXXFLAGS := -std=c++0x -Weffc++ $(COMPILER_OPTIONS)
DEBUGFLAGS := -g -O0 -D _DEBUG
RELEASEFLAGS := -O2 -D NDEBUG

LDFLAGS := -Linstall/lib \
	-lm -lpthread

INCLUDEFLAGS := -I include/$(PROG) \
				 -I install/lib \
				 -I third_party/gtest \
				 -I third_party/gtest/include

# $@ is the current target
# $^ is all the prerequisites
# $< is the first prerequisite

# executables and archives
install/test/body-test.x: install/include/body-test.o \
						  install/include/body.o
	ar rcs install/lib/libnbody.a install/include/body.o
	$(CXX) -o $@ $< $(LDFLAGS) -lnbody

install/test/system-test.x: install/include/system-test.o \
							install/include/system.o \
							install/include/body.o
	ar rcs install/lib/libnbody.a install/include/body.o install/include/system.o
	$(CXX) -o $@ $< $(LDFLAGS) -lnbody

# object files
install/include/body.o: src/body.cpp
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)
install/include/body-test.o: test/body-test.cpp
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)

install/include/system.o: src/system.cpp
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)
install/include/system-test.o: test/system-test.cpp
	$(CXX) -c -o $@ $< $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)


# compiling targets
.PHONY : all body body-test system system-test clean

all: install/test/body-test.x

body: install/test/body-test.x

body-test: install/test/body-test.x
	install/test/body-test.x

system: install/test/system-test.x

system-test: install/test/system-test.x
	install/test/body-test.x
	install/test/system-test.x

clean:
	rm -f install/test/*.x install/lib/*.a install/include/*.o

