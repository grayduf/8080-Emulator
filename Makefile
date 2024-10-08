#Variable Def.
CC=gcc
CFLAGS=-g -std=c11 -Wall -Wshadow -Wvla -Werror -pedantic
CFLAGS_GCOV=$(CFLAGS) -fprofile-arcs -ftest-coverage -dumpbase ''

BASE_NAME=8080emu
ROM=invaders
EXECUTABLE=$(BASE_NAME)
EXECUTABLE_GCOV=$(EXECUTABLE)_gcov
OUTPUT_TXT=output.txt

SRC_C=$(BASE_NAME).c
#TEST_C=test_$(SRC_C)
#SRC_H=$(BASE_NAME).h

#SUBMIT_FILES=Makefile $(SRC_C) $(SRC_H) $(TEST_C)
#GIT_ADD= git add

SHELL=/bin/bash

#RULES
$(EXECUTABLE): $(SRC_C) #Compile the Executable
	$(CC) -o $(EXECUTABLE) $(SRC_C) $(CFLAGS)

test rom: $(EXECUTABLE) $(ROM) #run executable
	./$(EXECUTABLE) $(ROM) > $(OUTPUT_TXT)

test header: $(EXECUTABLE) $(ROM) #run executable
	./$(EXECUTABLE) $(ROM).h

gdb: $(EXECUTABLE) #run executable with valgrind
	gdb ./$(EXECUTABLE)

#coverage: $(SRC_C) $(TEST_C) $(SRC_H) #run executable to check code coverage
#	$(CC) -o $(EXECUTABLE_GCOV) $(SRC_C) $(TEST_C) $(CFLAGS_GCOV)
#	./$(EXECUTABLE_GCOV)
#	gcov -f $(SRC_C)

clean: #delete created output files
	rm -f $(EXECUTABLE) $(OUTPUT_TXT) $(EXECUTABLE_GCOV) *.gcda *.gcno *.gcov

#submit: #submit files
#	$(GIT_ADD) $(SUBMIT_FILES)

#Phony Call
.PHONY: test clean coverage