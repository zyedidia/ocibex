OUTPUT_ARCH("riscv")

ENTRY(_start)

SECTIONS
{
    .vectors 0x100000 : {
        . = ALIGN(4);
        KEEP(*(.vectors))
    }
    . = ALIGN(4);
    .text : {
        __code_start__ = .;
        KEEP(*(.text.boot))
        *(.text*)
        __code_end__ = .;
    }
    . = ALIGN(4);
    .rodata : {
        *(.rodata*)
        *(.srodata*)
    }
    . = ALIGN(4);
    .data : { 
            __data_start__ = .;
            *(.data*) 
            *(.sdata*)
            *(.data*)
            __data_end__ = .;
    } 
    . = ALIGN(4);
    .bss : {
        __bss_start__ = .;
        *(.bss*)
        *(.sbss*)
        *(COMMON)
        __bss_end__ = .;
        . = ALIGN(8);
        __heap_start__ = .;
    }

    /DISCARD/ : {
        *(.comment)
        *(.riscv.attributes)
    }
}
