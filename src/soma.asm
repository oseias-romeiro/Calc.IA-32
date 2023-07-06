section .bss
    oper1   resb 4
    oper2   resb 4

section .text
    global soma

soma:
    mov eax, 0
    mov eax, [esp+4]
    mov eax, [esp+8]
    
    ret 4
