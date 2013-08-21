CC=gcc
CFLAGS=-Wall -Wextra
LDFLAGS=

SRCDIR=.
SRC=$(wildcard $(SRCDIR)/*.c)
BIN=$(SRC:.c=)

.PHONY: all clean

all: $(BIN)

%.o: %.c

clean:
	@ rm -f $(BIN) *~
