section .data
    msg     db "Hello", 0Ah
    msg_len EQU $-msg

section .text
    extern print
    global _start

_start:
    ; call to function print
    push msg_len
    push msg
    call print

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

