
section .text
    global subtracao

subtracao:

    mov eax, [esp+4]
    sub eax, [esp+8]
    
    ret 4

