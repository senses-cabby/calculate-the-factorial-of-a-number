; factorial.asm
section .data
    msg db "Enter a number: ", 0
    result_msg db "Factorial is: ", 0
    newline db 0xA

section .bss
    number resb 5
    result resb 10

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 16
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, number
    mov edx, 5
    int 0x80

    ; Convert ASCII to integer
    mov eax, 0
    mov ecx, number
    mov ebx, 10
    xor edx, edx
convert_loop:
    movzx eax, byte [ecx]
    cmp eax, 0
    je convert_done
    sub eax, '0'
    imul edx, edx, 10
    add edx, eax
    inc ecx
    jmp convert_loop
convert_done:

    ; Calculate factorial
    mov eax, edx      ; Copy number to eax
    mov ebx, 1        ; Initialize result to 1
    factorial_loop:
        imul ebx, ebx, eax
        dec eax
        test eax, eax
        jnz factorial_loop

    ; Convert integer to ASCII
    mov eax, ebx
    mov ecx, result
    mov ebx, 10
    xor edx, edx
convert_to_ascii_loop:
    div ebx
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz convert_to_ascii_loop

    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 15
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [result]
    mov edx, 10
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
