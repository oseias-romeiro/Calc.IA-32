section .data
    hello db 'Hello, world!', 0Ah
    len equ $-hello

section .text
    global _start



_start:
    ; call to function print
    push len
    push hello
    call print
    add esp, 8

    ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

print:
    ; Argumentos:
    ; [ebp+8]: msg address
    ; [ebp+12]: msg size
    push ebp
    mov ebp, esp

    mov eax, 4
    mov ebx, 1
    mov edx, [ebp+12]
    mov ecx, [ebp+8]
    int 0x80

    pop ebp
    ret
