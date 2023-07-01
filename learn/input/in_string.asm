
section .bss
    username resb 32

section .text
    global _start

_start:
    ; call to input
    push 32
    push username
    call input
    add esp, 8

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

    mov eax, 3
	mov ebx, 0
	mov ecx, [esp + 4]
	mov edx, [esp + 8]
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
