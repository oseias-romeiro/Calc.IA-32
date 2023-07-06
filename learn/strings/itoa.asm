
section .bss
    response resb 32

section .text
    global _start
    
_start:
    push 10
    push 2
    call itoa

    push 32
    push response
    call print
    
    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h

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

print:
    ; Args: len, msg

    mov eax, 4
    mov ebx, 1
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int 80h

    ret 4
