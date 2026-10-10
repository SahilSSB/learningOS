AS = nasm
EMU = qemu-system-x86_64

TOPIC ?= strings
ENTRY ?= main.asm
SRC_DIR = boot/$(TOPIC)
BUILD_DIR = build

SRC = $(SRC_DIR)/$(ENTRY)
BIN = $(BUILD_DIR)/boot.bin

.PHONY: all
all: $(BIN)

$(BIN): $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(AS) -i $(SRC_DIR)/ -f bin $< -o $@

.PHONY: run
run: $(BIN)
	$(EMU) $<

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
