section .data
    age db "your age: ", 0
    age_size EQU $-age

section .bss
    username resb 32

section .text
    global _start

_start:
    ; call to input
    push 32
    push username
    push age_size
    push age
    call input
    add esp, 16

    ; call to print
    push 32
    push username
    call print
    add esp, 8

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

input:
    ; Args: len, msg

    mov eax, [esp + 4]
    mov ebx, [esp + 8]
    push ebx
    push eax
    call print
    add esp, 8

    mov eax, 3
	mov ebx, 0
	mov ecx, [esp + 12]
	mov edx, [esp + 16]
	int 80h

    ret

print:
    ; Args: len, msg

    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret
