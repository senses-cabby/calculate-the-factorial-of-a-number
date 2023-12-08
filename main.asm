; main.asm
section .data
    msg db "Enter a number: ", 0

section .bss
    number resb 5

section .text
    global _start
    extern read_string
    extern calculate_factorial
    extern print_newline

_start:
    ; Print the prompt
    print_string msg, 16

    ; Read user input
    lea eax, [number]
    lea ebx, [number_size]
    call read_string

    ; Call the factorial function
    lea eax, [number]
    call calculate_factorial

    ; Print a newline
    call print_newline

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    number_size equ 5
