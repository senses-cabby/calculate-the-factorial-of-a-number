; io.asm
section .data
    newline db 0xA

section .text
    global print_newline
    global read_string

print_newline:
    print_string newline, 1
    ret

read_string:
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 0x80
    ret
