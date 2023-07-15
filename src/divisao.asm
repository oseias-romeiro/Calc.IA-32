
section .text
    global div16
    global div32

div16:
    mov ax, [esp+4]
    cdq
    mov bx, [esp+6]
    idiv bx
    movzx eax, ax

    ret

div32:
    mov eax, [esp+4]
    cdq
    mov ebx, [esp+8]
    idiv ebx

    ret

