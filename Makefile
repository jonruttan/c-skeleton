.POSIX:

# Directories
INC_DIR = include
SRC_DIR = src
OBJ_DIR = src
TST_DIR = test
TMP_DIR = tmp
BIN_DIR = src

# Compiler and flags
CC ?= gcc
CFLAGS += -I$(INC_DIR) -Wall -Wextra -Werror

INC = $(wildcard $(INC_DIR)/*.h)
SRC = $(wildcard $(SRC_DIR)/*.c)
TST = $(wildcard $(TST_DIR)/*.test.c)
OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
TARGET = $(BIN_DIR)/c-skeleton
DEBUG_TARGET = $(TARGET)-debug

# Default target
all: $(TARGET) ## Build default target
.PHONY: all

# Strip symbols from target
strip: $(TARGET) ## Strip symbols from target
	strip $(TARGET)
.PHONY: strip

# Create obj directory if it doesn't exist
@$(OBJ_DIR) $(BIN_DIR) $(TMP_DIR):
	mkdir -p $@

# Rule to build the target executable
$(TARGET): $(OBJ) | $(BIN_DIR)
	$(CC) $(OBJ) -o $@ $(CFLAGS) $(LDFLAGS)

# Rule to build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Target
target: $(TARGET) ## Make target
.PHONY: target

# Debug target
debug: $(DEBUG_TARGET) ## Make debug target
.PHONY: debug

# Rules to build debug target
$(DEBUG_TARGET): CFLAGS += -g -Og -DDEBUG
$(DEBUG_TARGET): LDFLAGS += -g
$(DEBUG_TARGET): $(OBJ) | $(BIN_DIR)
	$(CC) $(OBJ) -o $@ $(CFLAGS) $(LDFLAGS)

# Clean target
clean: ## Clean target
	rm -f $(OBJ) $(TARGET)
.PHONY: clean

# Lint sources
lint: ## Lint sources
	$(CC) -fsyntax-only $(CFLAGS) -g -Wall -pedantic $(SRC)
.PHONY: lint

# Run valgrind on target
valgrind: ## Run Valgrind on target
	$(CC) $(CFLAGS) -g -Wall $(SRC) && valgrind -v --leak-check=full ./a.out && rm a.out
.PHONY: valgrind

# Run tests
test: ## Run tests
	CFLAGS="$(CFLAGS) -g -Og -I. -DTEST" sh test/test-runner/test-runner.sh $(TST)
.PHONY: test

# Run tests with fast runner (no valgrind)
test-quick: ## Run fast tests (no Valgrind)
	RUNNER=command CFLAGS="$(CFLAGS) -g -Og -I. -DTEST" sh test/test-runner/test-runner.sh $(TST)
.PHONY: test-quick

# Alias test
tests: test ## Run tests
.PHONY: tests

# Watch source for changes
watch: ## Watch source for changes
	while true; do \
		trap "exit;" SIGINT SIGTERM; \
		fswatch -o --event Created --event Updated --event MovedTo Makefile $(INC) $(SRC) $(TST) | \
		make && make test; \
	done
.PHONY: watch

# Display help
help: ## Display this help section
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[32m%-38s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.PHONY: help
