section .bss

section .text
    global soma

soma:

    mov eax, [esp+4]
    add eax, [esp+8]
    
    ret 4

