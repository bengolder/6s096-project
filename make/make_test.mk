
tiny :

	## Here we'll define the important build locations.
	DEV_DIR := .
	SRC_DIR := $(DEV_DIR)/src
	BUILD_DIR := $(DEV_DIR)/build
	INSTALL_DIR := $(DEV_DIR)/install
	GTEST_DIR := $(DEV_DIR)/third_party/gtest

	## The compilers and programs to use
	SHELL := /bin/sh
	CC := gcc
	# If you're a Mac user and only have clang,
	# you'll want to change CXX and LD to clang++.
	CXX := g++
	LD := g++
	CP := cp -r
	RSYNC := rsync -iCau --exclude='\.*' --delete
	AR := ar
	RM := rm -f
	ZIP := zip
	MKDIR := mkdir -p

	## Directories to include headers from
	INCLUDE_FLAGS := -I$(INSTALL_DIR)/include \
									 -I$(DEV_DIR)/include \
									 -I$(GTEST_DIR)/include \
									 -I$(GTEST_DIR)

	## Warning flags to use during compilation
	FLAGS := -m64 -Wall -Wextra -Wshadow -Werror -pedantic
	# Use the C99 standard
	CFLAGS := -std=c99 $(FLAGS)
	# Use the C++11 standard and warn on violations of Meyers' "Effective C++"
	CXXFLAGS := -std=c++11 -Weffc++ $(FLAGS)
	# Flags for the linker; link to math and pthread (required for gtest)
	LDFLAGS := -L$(INSTALL_DIR)/lib -L$(GTEST_DIR)/lib -lm -lpthread

	## Turn on debugging symbols and disable optimizations when running 'make'
	DEBUG_FLAGS := -g -O0 -D _DEBUG
	## Enable optimizations and turn off asserts when running 'make release'
	RELEASE_FLAGS := -O2 -D NDEBUG

	## We'll put any extra things that should be cleaned up
	## after running 'make clean' here (the copied include/
	## files, for example)
	ARTIFACTS := 

	## Look in test/ for the unit test source files
	vpath %.cpp $(DEV_DIR)/test

	## The result of our nbody compile: an executable
	## named list-test.x which will run all of our unit tests.
	TARGET_PROJ_TEST := $(INSTALL_DIR)/test/$(PROJ_NAME)-test.x
	BUILD_DIR_PROJ_TEST := $(BUILD_DIR)/$(PROJ_NAME)-test

	## nbody-test.x depends on libnbody.a having been created first
	$(TARGET_PROJ_TEST) : $(INSTALL_DIR)/lib/lib$(PROJ_NAME).a

	## Link our nbody-test.x executable with libnbody.a and gtest
	$(TARGET_PROJ_TEST) : LDFLAGS += -lgcov $(INSTALL_DIR)/lib/lib$(PROJ_NAME).a

	## Add lots more unit tests to this list!
	OBJECTS_PROJ_TEST := \
		$(BUILD_DIR_PROJ_TEST)/gtest-all.o \
		$(BUILD_DIR_PROJ_TEST)/$(PROJ_NAME)-test.o \
		$(BUILD_DIR_PROJ_TEST)/nbody.o \
		#$(BUILD_DIR_PROJ_TEST)/add-more.o \
		#$(BUILD_DIR_PROJ_TEST)/unit-tests.o \
		#$(BUILD_DIR_PROJ_TEST)/right-here!.o \
		#$(BUILD_DIR_PROJ_TEST)/you-should.o \
		#$(BUILD_DIR_PROJ_TEST)/fill-up.o \
		#$(BUILD_DIR_PROJ_TEST)/all-these.o \
		#$(BUILD_DIR_PROJ_TEST)/lines.o \
		#$(BUILD_DIR_PROJ_TEST)/at.o \
		#$(BUILD_DIR_PROJ_TEST)/least.o \
	## Add lots more unit tests to the list above!

	$(OBJECTS_PROJ_TEST) : CXXFLAGS += -fprofile-arcs -ftest-coverage

	## Look in GTEST_DIR/src for the gtest-all.cc file
	vpath %.cc $(GTEST_DIR)/src

	## Need to filter out -Weffc++ and -Wextra flags (or gtest won't compile)
	$(OBJECTS_PROJ_TEST) : CXXFLAGS := $(filter-out -Weffc++,$(CXXFLAGS))
	$(BUILD_DIR_PROJ_TEST)/gtest-all.o : CXXFLAGS := $(filter-out -Wextra,$(CXXFLAGS))

	## Needed so gtest will compile on Cygwin.
	$(OBJECTS_PROJ_TEST) : CXXFLAGS := $(filter-out -std=c++11,$(CXXFLAGS))
	$(OBJECTS_PROJ_TEST) : CXXFLAGS := -std=gnu++0x $(CXXFLAGS)

