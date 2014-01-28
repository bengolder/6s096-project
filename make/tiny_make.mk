PROG := nbody
SHELL := /bin/sh
CC := gcc
CXX := g++

COMPILER_OPTIONS := -m64 -Wall -Wextra -Wshadow -Werror -pedantic -Iinclude
CFLAGS := -std=c99 $(COMPILER_OPTIONS)
CXXFLAGS := -std=c++0x -Weffc++ $(COMPILER_OPTIONS)
LDFLAGS := -Wl,--no-as-needed -I include/$(PROG)

DEBUGFLAGS := -g -O0 -D _DEBUG
RELEASEFLAGS := -O2 -D NDEBUG

DEV_DIR := .
SRC_DIR := $(DEV_DIR)/src
BUILD_DIR := $(DEV_DIR)/build
INSTALL_DIR := $(DEV_DIR)/install
GTEST_DIR := $(DEV_DIR)/third_party/gtest

# setup a target for testing body
TARGET_BODY_TEST := $(INSTALL_DIR)/test/body-test.x

# setup a target for testing system
TARGET_SYSTEM_TEST := $(INSTALL_DIR)/test/system-test.x

OBJECTS_BODY_TEST := \
	$(BUILD_DIR)/body.o \
	$(BUILD_DIR)/body-test.o \

OBJECTS_SYSTEM_TEST := \
	OBJECTS_BODY_TEST += \
	$(BUILD_DIR)/system.o \
	$(BUILD_DIR)/system-test.o \

SYSTEM_TEST_SOURCES :=
	OBJECTS_BODY_TEST += \
	src/system.cpp \
	tests/system-test.cpp \
	include/nbody/system.hpp \

BODY_TEST_SOURCES := \
	src/body.cpp \
	tests/body-test.cpp \
	include/nbody/body.hpp \

$(OBJECTS_BODY_TEST): $(BODY_TEST_SOURCES)

$(OBJECTS_SYSTEM_TEST): $(SYSTEM_TEST_SOURCES)

TARGET_ALL  := test.x
SOURCES := $(shell echo src/*.cpp)
HEADERS := $(shell echo include/$(PROG)/*.hpp)
COMMON  :=
OBJECTS := $(SOURCES:.cpp=.o)

all: $(TARGET)

body: $(TARGET_BODY_TEST)

system: $(TARGET_SYSTEM_TEST)

$(TARGET_BODY_TEST): $(OBJECTS_BODY_TEST) 
	$(CXX) $(FLAGS) $(CXXFLAGS) $(DEBUGFLAGS) -o $(TARGET_BODY_TEST) $(OBJECTS_BODY_TEST)

$(TARGET_SYSTEM_TEST): $(OBJECTS_SYSTEM_TEST) 
	$(CXX) $(FLAGS) $(CXXFLAGS) $(DEBUGFLAGS) -o $(TARGET_SYSTEM_TEST) $(OBJECTS_SYSTEM_TEST)

$(TARGET_ALL): $(OBJECTS) $(COMMON)
	$(CXX) $(FLAGS) $(CXXFLAGS) $(DEBUGFLAGS) -o $(TARGET) $(OBJECTS)

release: $(SOURCES) $(HEADERS) $(COMMON)
	$(CXX) $(FLAGS) $(CXXFLAGS) $(RELEASEFLAGS) -o $(TARGET) $(SOURCES)

zip:
	-zip $(PROG).zip $(HEADERS) $(SOURCES) Makefile GRADER_INFO.txt

clean:
	-rm -f $(TARGET) $(OBJECTS) $(PROG).zip

%.o: %.cpp $(HEADERS) $(COMMON)
	$(CXX) $(CXXFLAGS) $(DEBUGFLAGS) -c -o $@ $<

.PHONY : all release

