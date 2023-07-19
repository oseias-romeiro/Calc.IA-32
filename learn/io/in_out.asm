section .data
    age db "your name: ", 0
    age_size EQU $-age

section .bss
    username resb 32

section .text
    global _start

_start:
    ; call to input
    push age_size
    push age
    call print

    push 32
    push username
    call input

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

input:
    ; Args: len, msg

    mov eax, 3
	mov ebx, 0
	mov ecx, [esp + 4]
	mov edx, [esp + 8]
	int 80h

    ret 4

print:
    ; Args: len, msg

    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret 4
