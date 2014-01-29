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

# create executable
install/test/body-test.x: install/include/body-test.o \
					      install/lib/libnbody.a
	$(CXX) -o $@ $^ $(LDFLAGS)
	# $@ is the current target
	# $^ is all the prerequisites

# create archive
install/lib/libnbody.a: install/include/body.o 
	ar rcs $@ $^

# create object files
install/include/body.o: src/body.cpp
	$(CXX) -c -o $@ $^ $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)
install/include/body-test.o: test/body-test.cpp
	$(CXX) -c -o $@ $^ $(INCLUDEFLAGS) $(CXXFLAGS) $(DEBUGFLAGS)

# compiling targets
all: install/test/body-test.x

body: install/test/body-test.x

body-test: install/test/body-test.x
	install/test/body-test.x

clean:
	rm -f install/test/*.x install/lib/*.a install/include/*.o
