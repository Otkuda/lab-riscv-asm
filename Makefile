COMPILER := riscv64-unknown-elf-
GCC      := $(COMPILER)gcc
DUMP     := $(COMPILER)objdump

CC_FLAGS := -march=rv32i -mabi=ilp32
DUMP_FLAGS := -D
TARGET   := program
DEPS     := program.c

all: $(TARGET).dump x86

x86: $(TARGET).out

$(TARGET).dump: $(TARGET).elf
	$(DUMP) -D $< > $@

$(TARGET).elf: $(DEPS)
	$(GCC) $(CC_FLAGS) $^ -o $@

$(TARGET).out: $(DEPS)
	gcc $^ -o $@

clean:
	rm -f *.elf *.dump *.out
	
.phony: all clean