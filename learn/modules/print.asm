section .text
    global print

print:
    ; Args: len, msg

    mov eax, 4       ; write
    mov ebx, 1       ; out
    mov ecx, [esp+4]; ptr msg
    mov edx, [esp+8]; ptr len
    int 80h

    ret 2
