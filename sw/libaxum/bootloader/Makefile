PREFIX=riscv64-unknown-elf

RV_ROOT ?= /opt/riscv

CC=$(PREFIX)-gcc
AS=$(PREFIX)-as
LD=$(PREFIX)-ld
OBJCOPY=$(PREFIX)-objcopy
OBJDUMP=$(PREFIX)-objdump

INCLUDE=-I$(LIBAXUM_ROOT)
ARCH=rv32imac

O ?= s

CFLAGS=-O$(O) $(INCLUDE) -g -Wall -Wno-unused-function -nostdlib -nostartfiles -ffreestanding -march=$(ARCH) -mabi=ilp32 -std=gnu99 -mcmodel=medany
ASFLAGS=-march=$(ARCH) -mabi=ilp32
LDFLAGS=-T $(LIBAXUM_ROOT)/bootloader/memmap.ld -L$(RV_ROOT)/$(PREFIX)/lib/$(ARCH)/ilp32 -L$(RV_ROOT)/lib/gcc/$(PREFIX)/11.1.0/$(ARCH)/ilp32 -melf32lriscv
LDLIBS=-lgcc

CSRC=$(wildcard $(LIBAXUM_ROOT)/bootloader/*.c) $(LIBAXUM_ROOT)/uart.c $(wildcard $(LIBAXUM_ROOT)/libc/*.c)
SSRC=$(wildcard $(LIBAXUM_ROOT)/bootloader/*.s)
OBJ=$(CSRC:.c=.o) $(SSRC:.s=.o)

PROG=bootloader

all: $(PROG).hex

install: $(PROG).bin
	bin2hex $< > $(LIBAXUM_ROOT)/../../mem/$(PROG).vmem

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -c -o $@

$(PROG).elf: $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) $(LDLIBS) -o $@

%.bin: %.elf
	$(OBJCOPY) $< -O binary $@

%.hex: %.elf
	$(OBJCOPY) $< -O ihex $@

%.list: %.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -f *.o *.elf *.hex *.bin *.list

.PHONY: all install clean
