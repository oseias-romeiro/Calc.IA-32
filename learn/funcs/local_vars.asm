section .data
    x dw '5'
    y dw '3'
    msg db  "sum of x and y is "
    len equ $ - msg

section .bss
    sum resb 1


section .text

global _start

_start:

    push word[x]
    push word[y]
    call somador
    add esp, 4

    mov     [sum], eax

    mov     ecx, msg
    mov     edx, len
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     ecx, sum
    mov     edx, 1
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     eax, 1
    int     0x80
    
%define var_x [ebp+10]
%define var_y [ebp+8]
somador:
    enter 2,0
    
    mov     bx, var_x
    mov     cx, var_y
    
    ;sub     ax, '0'
    push    bx
    call    sub_z
    add     esp, 2
    mov     bx, ax
    
    ;sub     bx, '0'
    push    cx
    call    sub_z
    add     esp, 2
    mov     cx, ax
    
    add     bx, cx
    add     bx, '0'
    movzx   eax, bx
    
    leave
    ret 

sub_z:
    enter 0,0 
    
    mov     ax, [ebp+8]
    sub     ax, '0'
    
    leave
    ret
