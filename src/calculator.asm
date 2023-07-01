section .data

section .text
    global _start


_start:
    
    ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
