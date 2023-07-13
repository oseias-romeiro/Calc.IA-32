
section .text
    global soma16
    global soma32
    

soma16:
    mov ax, word[esp+4]
    add ax, word[esp+6]
    movzx eax, ax
    
    ret

soma32:

    mov eax, [esp+4]
    add eax, [esp+8]
    
    ret
