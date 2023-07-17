section .text
    global mod16
    global mod32

mod16:
    mov ax, word[esp+4] ; dividendo
    cdq
    mov bx, word[esp+6] ; divisor

    xor dx, dx
    idiv bx
    movzx eax, dx

    ret

mod32:
    mov eax, dword[esp+4] ; dividendo
    cdq
    mov ebx, dword[esp+8] ; divisor

    xor edx, edx
    idiv ebx
    mov eax, edx

    ret
