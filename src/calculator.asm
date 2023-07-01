section .data
    msg1        db "Bem-vindo. Digite seu nome:", 0
    msg1_size   EQU $-msg1


section .text
    global _start


_start:
    push msg1_size
    push msg1
    call print
    add  esp, 8

    ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80


print:
    ; args: len, msg
    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret

