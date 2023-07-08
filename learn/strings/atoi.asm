section .data
    num  db "10", 0Ah

section .bss
    response resb 32

section .text
    global _start
    
_start:
    push num
    call atoi

    push eax
    push 2
    call itoa

    push 32
    push response
    call print

    mov eax, 1
    mov ebx, 0
    int 80h

atoi:
    mov edx, [esp+4]
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
    ret 2

print:
    ; Args: len, msg

    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret 4

itoa:
    
	mov eax,[esp+8]		; EAX - Valor a ser impresso na tela
	mov	ebx,response+31	; EBX - Digito menos significativo do numero
	
    ; TODO: negativo

	mov	ecx,[esp+4]	; ECX - O tanto de algarismos que o numero contem
	mov	edi,10

itoa_loop:
	mov	edx,0
	div	edi
	add	edx,48
	mov	[ebx],dl
	dec	ebx
	dec ecx
	jnz itoa_loop
	
	ret 4
