AS = nasm
EMU = qemu-system-x86_64

TOPIC ?= stack

SRC_DIR = boot/$(TOPIC)
BUILD_DIR = build

SRC = $(SRC_DIR)/boot.asm
BIN = $(BUILD_DIR)/boot.bin

.PHONY: all
all: $(BIN)

$(BIN): $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(AS) -f bin $< -o $@

.PHONY: run
run: $(BIN)
	$(EMU) $<

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
