; factorial_functions.asm
section .data
    result_msg db "Factorial is: ", 0

section .bss
    result resb 10

section .text
    global calculate_factorial

calculate_factorial:
    mov eax, [ebp + 8]      ; Get the input parameter
    mov ebx, 1              ; Initialize result to 1
    factorial_loop:
        imul ebx, ebx, eax  ; Multiply result by the current number
        dec eax             ; Decrement the number
        test eax, eax       ; Check if the number is zero
        jnz factorial_loop  ; If not, continue the loop

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
    print_string result_msg, 15

    mov eax, 4
    mov ebx, 1
    lea ecx, [result]
    mov edx, 10
    int 0x80

    ret
