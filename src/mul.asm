
section .text
    extern check_overflow
    global mul16
    global mul32

mul16:
    mov ax, [esp+4]
    mov bx, [esp+6]
    imul ax, bx
    call check_overflow
    movsx eax, ax

    ret

mul32:
    mov eax, [esp+4]
    mov ebx, [esp+8]
    imul eax, ebx
    call check_overflow

    ret
