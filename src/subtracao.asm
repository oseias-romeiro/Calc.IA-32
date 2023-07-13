
section .text
    global sub16
    global sub32

sub16:

    mov ax, word[esp+4]
    sub ax, word[esp+8]
    movzx eax, ax
    
    ret

sub32:

    mov eax, [esp+4]
    sub eax, [esp+8]
    
    ret
