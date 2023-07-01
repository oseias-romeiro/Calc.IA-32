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
    mov ebx, 0
    int 80h

print:
    ; Args: len, msg

    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret
