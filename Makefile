# Compiler
CC = gcc
LDFLAGS = -o $(BIN) $(LIBPATH) $(LIBS)
CFDEBUG = $(CFLAGS) -g -DDEBUG $(LDFLAGS)
RM = /bin/rm -f

BIN = employee-manager
BUILD_DIR = bin
POSTGRES = /usr/include/postgresql

LIBS = -lncurses -lpq -lform
INCLUDES_DIR = /usr/include
INCLUDES = -I$(INCLUDES_DIR) -I$(POSTGRES)
CFLAGS = -std=c18 -Wall

# All .c source files
SRC = main.c $(wildcard src/*.c)

all: $(BIN)

$(BIN):
	$(CC) $(SRC) $(CFLAGS) $(INCLUDES) $(LIBS) -o $(BUILD_DIR)/$(BIN) 

# prevent confusion with any files named "clean"
.PHONY: clean
clean:
	$(RM) *.o *~ $(BUILD_DIR)/$(BIN)

depend: $(SRC)
	makedepend $(INCLUDES) $^

debug_code:
	$(RM) debug/debug
	$(CC) -g -o debug/debug $(SRC) $(CFLAGS) $(INCLUDES) $(LIBS)

debug_mode:
	tmux splitw -h -p 50 "gdbserver localhost:12345 debug/debug"; tmux select -t 0; gdb -x debug/debug_conf.gdb;


