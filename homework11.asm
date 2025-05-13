; File: homework11.asm
; Author: Grisha Goldberg
; Class: CMSC 313. Professor Kidd
; Section: MonWed 2:30-3:45
; Description:
;   Prints bytes as ASCII hex.

section .data
    inputBuf: db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
    
    inputLen: equ 8

section .bss
    outputBuf: resb 80

section .text
    global _start

_start:
    ; Initializes registers: ECX is the index, EDI is the output buffer pointer.
    ; The loop I made will convert each byte in inputBuf to ASCII hex format and
    ; store the result in outputBuf. A space is added between each pair of hex digits.
    ; Once all bytes are processed, the loop will end and print the result.
    
    ; This is the index for inputBuf.
    mov ecx, 0

    ; Pointer for outputBuf.
    mov edi, outputBuf

next_byte:
    ; Let's check if it's done.
    cmp ecx, inputLen
    ; This exits the loop when all bytes are processed.
    je done

    ; For extra credit: This calls subroutine to convert each byte in inputBuf.
    ; Then, the subroutine will store the converted ascii value in outputBuf.
    mov al, [inputBuf + ecx]          
    call byte_to_ascii
    add edi, 2

    ; If it's not the last byte, add a space.
    inc ecx
    cmp ecx, inputLen
    je skip_space
    mov byte [edi], ' '
    inc edi


skip_space:
    jmp next_byte

done:
    ; This will add the newline.
    mov byte [edi], 0x0A
    inc edi

    ; edi - outputBuf = length of the output.
    mov edx, edi
    sub edx, outputBuf

    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    int 0x80

    ; Does syscall exit(0)
    mov eax, 1
    xor ebx, ebx
    int 0x80

; For extra credit:
; This subroutine handles both the upper and lower 4 bits of the byte.
; The subroutine does some the translating, like the extra credit asked.
; But I think there would be too much repetition to include all of it in byte_to_ascii.
byte_to_ascii:
    ; Save the original AL value (AL holds the byte we want to convert).
    push ax

    ; Do upper 4 bits by copying, shifting, and then moving into AL.
    mov ah, al
    shr ah, 4
    mov al, ah

    ; Convert AL's value into an ascii character.
    cmp al, 9
    jbe convert_high_digit
    add al, 'A' - 10
    jmp store_high

convert_high_digit:
    add al, '0'

store_high:
    mov [edi], al

    ; Converts lower 4 bits to ascii.
    pop ax
    and al, 0x0F

    ; Checks if the value in AL is between 0–9.
    ; If it is, convert it to the ascii digits '0'–'9'.
    ; If it’s between 10–15, convert it to the ascii letters 'A'–'F'.
    cmp al, 9
    jbe convert_low_digit
    add al, 'A' - 10
    jmp store_low

convert_low_digit:
    add al, '0'

store_low:
    mov [edi+1], al
    ret
