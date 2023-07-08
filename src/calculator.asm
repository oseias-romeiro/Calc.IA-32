section .data
    nl          db  "", 0Dh, 0Ah
    nl_size     EQU $-nl
    ; user massages
    msg1        db  "Bem-vindo. Digite seu nome: ", 0
    msg1_size   EQU $-msg1
    msg2        db  "Hola, ", 0
    msg2_size   EQU $-msg2
    msg3        db  ", bem-vindo ao programa de CALC IA-32", 0Dh, 0Ah
    msg3_size   EQU $-msg3
    msg4        db  "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ", 0
    msg4_size   EQU $-msg4
    ; items menu
    menu_hd     db  "ESCOLHA UMA OPÇÃO:", 0Dh, 0Ah
    hd_size     EQU $-menu_hd
    menu_item1  db  "- 1: SOMA", 0Dh, 0Ah
    item1_size  EQU $-menu_item1
    menu_item2  db  "- 2: SUBTRACAO", 0Dh, 0Ah
    item2_size  EQU $-menu_item2
    menu_item3  db  "- 3: MULTIPLICACAO", 0Dh, 0Ah
    item3_size  EQU $-menu_item3
    menu_item4  db  "- 4: DIVISAO", 0Dh, 0Ah
    item4_size  EQU $-menu_item4
    menu_item5  db  "- 5: EXPONENCIACAO", 0Dh, 0Ah
    item5_size  EQU $-menu_item5
    menu_item6  db  "- 6: MOD", 0Dh, 0Ah
    item6_size  EQU $-menu_item6
    menu_item7  db  "- 7: SAIR", 0Dh, 0Ah
    item7_size  EQU $-menu_item7
    ;adiós
    adios       db  "Adiós...", 0Dh, 0Ah
    adios_size  EQU $-adios

section .bss
    username        resb 32
    precision       resb 2
    operation       resb 2
    opera1          resb 5
    opera2          resb 5
    response        resb 32


section .text
    extern soma
    extern subtracao
    extern mult
    extern divisao
    extern expo
    extern mod

    global _start


_start:
    ; obtem o nome
    push msg1_size
    push msg1
    call print
    push 32
    push username
    call input
    ; printa a menssagem de bemvindo com o nome
    push msg2_size
    push msg2
    call print
    push eax ; retorno do input
    push username
    call print
    push msg3_size
    push msg3
    call print

get_precision:
    ; obtem a precisão
    push msg4_size
    push msg4
    call print
    push 2
    push precision
    call input_num

    ; define a precisão
    cmp eax, 0
    je precision16
    cmp eax, 1
    je precision32
    jmp get_precision
precision16:
    mov word[precision], 16
    jmp menu
precision32:
    mov word[precision], 32
    jmp menu

menu:
    ; args: operation var
    push hd_size
    push menu_hd
    call print
    push item1_size
    push menu_item1
    call print
    push item2_size
    push menu_item2
    call print
    push item3_size
    push menu_item3
    call print
    push item4_size
    push menu_item4
    call print
    push item5_size
    push menu_item5
    call print
    push item6_size
    push menu_item6
    call print
    push item7_size
    push menu_item7
    call print

    push 2
    push operation
    call input_num
    
    push eax
    call menu_logic

    ; enter para continuar
    call input_num

    jmp menu
exit:
    push adios_size
    push adios
    call print

    mov eax, 1
    add ebx, 0
    int 0x80

print:
    ; args: len, msg
    push eax

    mov eax, 4          ; write
    mov ebx, 1          ; out
    mov ecx, [esp + 8]  ; msg
    mov edx, [esp + 12]  ; len
    int 80h

    pop eax
    ret 4

input:
    ; args: len_var, var

    mov eax, 3         ; read
	mov ebx, 0         ; out
	mov ecx, [esp + 4] ; msg
	mov edx, [esp + 8] ; len
	int 80h

    ; retone a poisção do enter
    mov eax, 0
nl_search:
    cmp byte[ecx], 0ah ; enter code
    je return_input
	inc eax
    inc ecx
    jmp nl_search

return_input:
    ret 4

input_num:
    ; args:
    ; return: valor numerico
    mov eax, 3         ; read
	mov ebx, 0         ; out
	mov ecx, [esp+4]   ; msg
	mov edx, 5         ; len
	int 80h

    ; converte para numero
    mov ebx, [esp]
    add esp, 4
    call atoi
    push ebx

    ret 4

menu_logic:
    mov eax, [esp+4]

    ; soma
    cmp eax, 1
    je op_soma
    ; 2
    ; 3
    ; 4
    ; 5
    ; 6
    ; exit
    cmp eax, 7
    je exit

    ret 2

; TODO: funcs operations

op_soma:
    ; pede 2 numeros para o usuario
    ; armazena em variáveis locais
    ; chama a operação
    
    ; operador 1
    push 5
    push opera1
    call input_num
    mov edi, eax
    ; operador 2
    push 5
    push opera2
    call input_num
    
    ; soma
    push edi
    push eax
    call soma

    push eax
    push precision
    call itoa

    push 32
    push response
    call print

    push nl_size
    push nl
    call print

    jmp menu


atoi:
    ; # converte string para valor numero

    xor eax, eax ; eax armazena o resultado parcial
    mov edx, [esp+4]
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
    
itoa:
    ; # converte valor numerico para string
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

