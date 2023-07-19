section .data
    file    db "./myfile.txt"
    msg     db "hello world", 0Ah
    len     EQU $-msg

section .bss
    read resb 32

section .text
    global _start

;%define DESCRIPTOR [esp+4]
_start:
    ; create file
    mov eax, 8
    mov ebx, file
    mov ecx, 0o777
    int 0x80

    mov ebx, eax

    ; write
    mov eax, 4
    mov ecx, msg
    mov edx, len
    int 0x80 

    ; close file
    mov eax, 6
    int 0x80

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

