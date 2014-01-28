
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

	# Virtual path directive - find all 
	vpath %.cpp $(DEV_DIR)/src

	PROJ_NAME := nbody

	## The actual result of building this project:
	## a static library named 'librational.a'.
	TARGET_PROJ := $(INSTALL_DIR)/lib/lib$(PROJ_NAME).a
	#$(TARGET_PROJ) : | $(INSTALL_DIR)/include/$(PROJ_NAME)

	## Where to put all of the compiled object files
	BUILD_DIR_PROJ := $(BUILD_DIR)/$(PROJ_NAME)

	## List of object files to produce (from the similarly
	## named .cpp files). Add any extra files you want to have
	## compiled here.
	OBJECTS_PROJ := \
		$(BUILD_DIR_PROJ)/gcd.o \
		$(BUILD_DIR_PROJ)/rational.o \
		#$(BUILD_DIR_PROJ)/add.o \
		#$(BUILD_DIR_PROJ)/any.o \
		#$(BUILD_DIR_PROJ)/other.o \
		#$(BUILD_DIR_PROJ)/files.o \
		#$(BUILD_DIR_PROJ)/here.o \
	## Add more object files above as you write them!
	$(OBJECTS_PROJ) : | $(INSTALL_DIR)/include/$(PROJ_NAME)

	## Copies over the public header files to install/include
	## See http://www.gnu.org/software/make/manual/html_node/Double_002dColon.html
	$(INSTALL_DIR)/include/$(PROJ_NAME) ::
		$(MKDIR) $@
		$(RSYNC) $(DEV_DIR)/include/$(PROJ_NAME)/ $@/

	## Add the public include files to the list of artifacts
	## to be cleaned up on a 'make clean'
	ARTIFACTS += $(INSTALL_DIR)/include/$(PROJ_NAME)

	## Here we set up the directories that all of the 
	## object files will be ending up in.

	BUILD_DIRS := $(sort $(BUILD_DIR_PROJ) $(BUILD_DIR_PROJ_TEST))
	TARGETS := $(sort $(TARGET_PROJ) $(TARGET_PROJ_TEST))

	## UPPER LEVEL (PHONY) TARGETS

	all : $(TARGETS)
	nbody : $(TARGET_PROJ)
	nbody-test : $(TARGET_PROJ_TEST)

	## Set compile flags for debug mode by default
	COMPILE_CXX = $(CXX) -c -o $@ $< $(INCLUDE_FLAGS) $(CXXFLAGS) $(DEBUG_FLAGS) 

	## Running 'make release' will set compile flags to release mode
	release : COMPILE_CXX = $(CXX) -c -o $@ $< $(INCLUDE_FLAGS) $(CXXFLAGS) $(RELEASE_FLAGS)
	release : all

	## Rule for making gtest executables:
	## First we link %-test.x, then we execute it to run the unit tests.
	%-test.x : | $(INSTALL_DIR)/test
		$(LD) -o $@ $^ $(LDFLAGS)
		$@

	## Rule for making any static libraries. If you want to find out
	## more, see http://linux.die.net/man/1/ar
	%.a : | $(INSTALL_DIR)/lib $(INSTALL_DIR)/include
		$(AR) rcs $@ $^

	## Rule for making any regular executables - link the object files.
	%.x : | $(INSTALL_DIR)/bin
		$(LD) -o $@ $^ $(LDFLAGS)

	## The targets depend on each of their objects. If any object
	## files are newer, we'll rebuild the target.
	$(TARGET_PROJ) : $(OBJECTS_PROJ)
	$(TARGET_PROJ_TEST) : $(OBJECTS_PROJ_TEST)

	## We need BUILD_DIR_PROJ around before we try to generate the object
	## files or dependency files. See the link:
	## http://www.gnu.org/software/make/manual/make.html#Prerequisite-Types
	$(OBJECTS_PROJ) $(patsubst %.o,%.d, $(OBJECTS_PROJ)) : | $(BUILD_DIR_PROJ)
	$(OBJECTS_PROJ_TEST) $(patsubst %.o,%.d, $(OBJECTS_PROJ_TEST)) : | $(BUILD_DIR_PROJ_TEST)
	## patsubst = "pattern substitution". For this and addsuffix below, see
	## http://www.gnu.org/software/make/manual/make.html#Text-Functions

	OBJECTS := $(sort $(OBJECTS_PROJ) $(OBJECTS_PROJ_TEST))
	$(OBJECTS) : %.o : %.d

	## For each required dependency file in BUILD_DIRS, we use sed and
	## g++ -MM to generate a list of the included headers (dependencies)
	$(addsuffix /%.d, $(BUILD_DIRS)) : %.cpp
		$(SHELL) -ec "$(CXX) -std=c++11 $(INCLUDE_FLAGS) -I$(DEV_DIR)/include -MM $< \
		| sed 's|$(notdir $*)\.o[ ]*:|$*\.o $@ :|g' > $@; \
		[ -s $@ ] || $(RM) $@"

	## You should name all of your files so they end in .cpp, but gtest
	## gtest will have some files that end in .cc we need to take care of.
	$(addsuffix /%.d, $(BUILD_DIRS)) : %.cc
		$(SHELL) -ec "$(CXX) -std=c++11 $(INCLUDE_FLAGS) -I$(DEV_DIR)/include -MM $< \
		| sed 's|$(notdir $*)\.o[ ]*:|$*\.o $@ :|g' > $@; \
		[ -s $@ ] || $(RM) $@"


	## Build all of the objects from our source files and do it
	## in our build/projectname directory.
	$(BUILD_DIR_PROJ)/%.o : %.cpp ; $(COMPILE_CXX)
	$(BUILD_DIR_PROJ_TEST)/%.o : %.cpp ; $(COMPILE_CXX)
	$(BUILD_DIR_PROJ_TEST)/%.o : %.cc ; $(COMPILE_CXX)

	## Command to remove all of the contents of the build/ directory
	## related to our project and all of the generated executables
	## and copied header files found in install/
	clean:
		$(RM) -r $(TARGETS) $(BUILD_DIRS) $(ARTIFACTS)

	## Include the '.d' (dependencies) files; the leading '-' dash
	## indicates that we don't want make to warn us if the files
	## don't already exist.
	-include $(patsubst %.o,%.d,$(OBJECTS))

	## Make all of the build and install directories if they do not already exist
	$(BUILD_DIRS) $(INSTALL_DIR)/bin \
							  $(INSTALL_DIR)/include \
								$(INSTALL_DIR)/lib \
								$(INSTALL_DIR)/test :
		$(MKDIR) $@

	# These names don't represent real targets
	.PHONY : all clean release nbody nbody-test

	# Don't delete our unit test executable even if make is killed or 
	# interrupted while it's being run.
	.PRECIOUS : %-test.x
