
section .text
    global mul16
    global mul32

mul16:
    mov ax, [esp+4]
    mov bx, [esp+6]
    imul ax, bx
    movzx eax, ax

    ret

mul32:
    mov eax, [esp+4]
    mov ebx, [esp+8]
    imul eax, ebx

    ret
