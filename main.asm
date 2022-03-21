; how to run: nasm -felf64 -F dwarf main.asm && ld main.o && ./a.out 

; also try with: nasm -felf32 main.asm && ld -m elf_i386 main.o && ./a.out

; Some debug reference:
; https://www.reddit.com/r/asm/comments/swglu9/how_to_debug_nasm_with_gdb_some_debug_info/
; https://stackoverflow.com/questions/13282176/using-gdb-to-check-registers-values

%include        'functions.asm'                             ; include our external file

SECTION .data
msg1 db  "tst", 0h
msg2 db  "zxz2", 0h

SECTION .text
global _start

_start:
    mov ecx, msg1
    call printLF

    mov ecx, msg2
    call printLF

    call _exit

