section .data
    num     db "-9"
    neg_val db "negativo!", 0Ah, 0Dh
    neg_len EQU $-neg_val

section .bss
    response resb 11

section .text
    global _start
    
_start:
    push num
    call atoi

    push eax
    push 11
    call itoa

    push 32
    push response
    call print

    mov eax, 1
    mov ebx, 0
    int 80h


atoi:
    ; # converte string para valor numerico

    xor eax, eax ; eax armazena o resultado parcial
    mov edx, [esp+4]

    movzx ecx, byte [edx] ; pega o primeiro caractere
    cmp ecx, '-' ; verifica se é negativo
    jne .top ; se não, pula direto para a conversão

    ; Se for negativo
    mov ebx, 1 ; flag de aviso 
    inc edx ; incrementa para o próximo caractere

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
    cmp ebx, 1 ; se for negativo
    je .atoi_neg ; nega o valor
.back_atoi:
    ret 2
.atoi_neg:
    neg eax
    jmp .back_atoi

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
	mov	ebx,response+10	; EBX - Digito menos significativo do numero
    mov	ecx,[esp+4]	; ECX - O tanto de algarismos que o numero contem
	mov	edi,10

    ; negativo
    cmp eax, 0
    jge .itoa_loop

	mov byte [response], '-' ; Coloca o sinal negativo no início da string
	neg eax ; Transforma o número em negativo (complemento de dois)
	inc edx ; Ajusta o índice do início do buffer
	dec ecx ; Decrementa o contador de caracteres


.itoa_loop:
	mov	edx,0
	div	edi
	add	edx,48
	mov	[ebx],dl
	dec	ebx
	dec ecx
	jnz .itoa_loop

    ret 4
