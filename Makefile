CC=nasm
LK=ld

CFLAGS = -f elf32
LFLAGS = -m elf_i386

SRC_DIR = ./src
OBJ_DIR = ./obj
BIN_DIR = ./bin

TARGET=calculator.out

SOURCES := $(wildcard $(SRC_DIR)/*.asm)
OBJECTS := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SOURCES))

PROGRAM := $(BIN_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(CC) $(CFLAGS) -o $@ $<

$(PROGRAM): $(OBJECTS)
	$(LK) $(LFLAGS) -o $@ $^

all: $(PROGRAM)

clean:
	rm -f $(OBJ_DIR)/*.o $(PROGRAM)
