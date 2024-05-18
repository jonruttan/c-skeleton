.POSIX:

CC ?= gcc
CFLAGS ?= -Iinclude -Wall -Wextra -Werror

INC_DIR = include
SRC_DIR = src
OBJ_DIR = src
TST_DIR = test
BIN_DIR = src

INC = $(wildcard $(INC_DIR)/*.h)
SRC = $(wildcard $(SRC_DIR)/*.c)
TST = $(wildcard $(TST_DIR)/*.test.c)
OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
TARGET = $(BIN_DIR)/c-skeleton

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)

lint:
	$(CC) -fsyntax-only $(CFLAGS) -g -Wall -pedantic $(SRC)
.PHONY: lint

valgrind:
	$(CC) $(CFLAGS) -g -Wall $(SRC) && valgrind -v --leak-check=full ./a.out && rm a.out
.PHONY: valgrind

test:
	CFLAGS="$(CFLAGS) -g -Og -I. -DTEST" sh test/test-runner/test-runner.sh $(TST)
.PHONY: test

test-quick:
	RUNNER=command CFLAGS="$(CFLAGS) -g -Og -I. -DTEST" sh test/test-runner/test-runner.sh $(TST)
.PHONY: test-quick

tests: test
.PHONY: tests

watch:
	while true; do \
		trap "exit;" SIGINT SIGTERM; \
		fswatch -o --event Created --event Updated --event MovedTo Makefile $(INC) $(SRC) $(TST) | \
		make && make test; \
	done
.PHONY: watch
