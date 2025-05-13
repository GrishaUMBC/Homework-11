# Homework-11

AUTHORING: Grisha Goldberg CMSC 313 Professor Kidd MonWed 2:30 - 3:45 4/18/2025

PURPOSE OF SOFTWARE: To take a series of binary bytes stored in memory, convert each byte into its corresponding two-character ASCII hexadecimal representation using a reusable subroutine, and then output the entire formatted hexadecimal string to the terminal with spaces separating each converted byte.

FILES: README.md homework11.asm

BUILD INSTRUCTIONS:
nasm -f elf32 -o homework11.o homework11.asm
ld -m elf_i386 -o homework11 homework11.o
./homework11

ADDITIONAL INFORMATION: Good luck grading! I hope I did everything right.
