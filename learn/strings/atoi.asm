section .data
    num  db "10"

section .text
    global _start
    
_start:
    mov edx, num
atoi:
    xor eax, eax ; eax armazena o resultado parcial
.top:
    movzx ecx, byte [edx] ; pega um character
    inc edx ; incrementa para o proximo caractere
    cmp ecx, '0' ; fim da string
    jb .done
    cmp ecx, '9'
    ja .done
    sub ecx, '0' ; converte para numero
    imul eax, 10 ; multiplica o resultado por 10
    add eax, ecx ; adiciona o digito
    jmp .top
.done:
    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h
