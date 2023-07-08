section .data
    hello db 'Hello, world!', 0Dh, 0Ah
    len equ $-hello

section .bss
    data_in resb 16

section .text
    global _start

_start:
    ; call to function print
    push 16
    push data_in
    push len
    push hello
    call input
    add esp, 16

    push 16
    push data_in
    call print

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

print:
    ; Args: len, msg
    enter 0,0
    push ebx


    mov eax, 4       ; write
    mov ebx, 1       ; out
    mov ecx, [ebp+8] ; ptr msg
    mov edx, [ebp+12]; ptr len
    int 80h

    pop ebx
    leave
    ret

input:
    
    push dword[esp+4]
    push dword[esp+8]
    call print
    add esp, 8

    mov eax, 3        ; read
    mov ebx, 0        ; in
    mov ecx, [esp+12] ; ptr msg
    mov edx, [esp+16] ; ptr len
    int 80h

    ret 

