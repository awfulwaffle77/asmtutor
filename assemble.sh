#!/bin/bash

# assemble the program in 32-bit, 'cause there's some weird "Instruction not supported
# in 64-bit mode" when I try to assemble with elf64
nasm -f elf -g main.asm
ld -m elf_i386 main.o
