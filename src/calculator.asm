section .data
    nl              db  "", 0Dh, 0Ah
    nl_size         EQU $-nl
    ; interacao com usuario
    msg1            db  "Bem-vindo. Digite seu nome: ", 0
    msg1_size       EQU $-msg1
    msg2            db  "Hola, ", 0
    msg2_size       EQU $-msg2
    msg3            db  ", bem-vindo ao programa de CALC IA-32", 0Dh, 0Ah
    msg3_size       EQU $-msg3
    msg4            db  "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ", 0
    msg4_size       EQU $-msg4
    ; menu
    menu_msg        db "ESCOLHA UMA OPÇÃO:", 0Dh, 0Ah
                    db "- 1: SOMA", 0Dh, 0Ah
                    db "- 2: SUBTRACAO", 0Dh, 0Ah
                    db "- 3: MULTIPLICACAO", 0Dh, 0Ah
                    db  "- 4: DIVISAO", 0Dh, 0Ah
                    db  "- 5: EXPONENCIACAO", 0Dh, 0Ah
                    db  "- 6: MOD", 0Dh, 0Ah
                    db  "- 7: SAIR", 0Dh, 0Ah
    menu_msg_size   EQU $-menu_msg
    ; overflow
    msg_OF          db "OCORREU OVERFLOW!", 0Dh, 0Ah
    len_OF          EQU $-msg_OF
    ;adiós
    adios           db  "Adiós...", 0Dh, 0Ah
    adios_size      EQU $-adios

section .bss
    username        resb 30
    precision       resb 2
    operation       resb 2
    opera1          resb 11
    opera2          resb 11
    response        resb 11


section .text
    extern soma16
    extern soma32
    extern sub16
    extern sub32
    extern mul16
    extern mul32
    extern div16
    extern div32
    extern expo16
    extern expo32
    extern mod16
    extern mod32

    global _start
    global check_overflow


_start:
    ; obtem o nome
    push msg1_size
    push msg1
    call print
    add esp, 8

    push 32
    push username
    call input
    add esp, 8

    ; printa a menssagem de bemvindo com o nome
    push msg2_size
    push msg2
    call print
    add esp, 8

    push eax ; retorno do input
    push username
    call print
    add esp, 8

    push msg3_size
    push msg3
    call print
    add esp, 8

    ; obtem a precisão
    push msg4_size
    push msg4
    call print
    add esp, 8

    push 2
    push precision
    call input_num
    add esp, 8

    mov [precision], eax

.menu:
    ; args: operation var

    ; print menu
    push menu_msg_size
    push menu_msg
    call print
    add esp, 8

    push 2
    push operation
    call input_num
    add esp, 8
    
    push eax
    call menu_logic
    add esp, 4

    ; enter para continuar
    push 2
    push operation
    call input_num
    add esp, 8

    jmp .menu

exit:
    push adios_size
    push adios
    call print
    add esp, 8

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
    ret

input:
    ; args: len_var, var

    mov eax, 3         ; read
	mov ebx, 0         ; out
	mov ecx, [esp + 4] ; msg
	mov edx, [esp + 8] ; len
	int 80h

    ; retone a poisção do enter
    mov eax, 0
.nl_search:
    cmp byte[ecx], 0ah ; enter code
    je .return_input
	inc eax
    inc ecx
    jmp .nl_search

.return_input:
    ret

input_num:
    ; Ler uma entrada de dados e converte para valor numérico
    enter 0,0
    push ebx

    mov eax, 3         ; read
	mov ebx, 0         ; std_out
	mov ecx, [ebp+8]   ; msg
	mov edx, 11        ; len
	int 80h

    ; converte para numero
    push ecx
    call tonum
    add esp, 4

    pop ebx
    leave
    ret

%define OP1 [ebp-8] ; operando 1
%define OP2 [ebp-4] ; operando 2
%assign P16 0       ; flag de precisao 16
%assign P32 1       ; flag de precisao 32
menu_logic:
    ; pede 2 numeros para o usuario
    ; armazena em variáveis locais
    ; salta para o controle da operação, que guia para a função de 16 bits ou para a função de 32

    enter 0,0
    mov ebx, [ebp+8]

    ; 7 - exit
    cmp ebx, 7
    je exit

    ; leitura dos operandos
    ; sempre são lido dois operandos (exceto na escolha de saída do programa - 7)

    ; operando 1
    push 11
    push opera1
    call input_num
    add esp, 8
    push eax

    ; operando 2
    push 11
    push opera2
    call input_num
    add esp, 8
    push eax

    ; escolha da operação
    ; 1- soma
    cmp ebx, 1
    je .op_soma
    ; 2- subtração
    cmp ebx, 2
    je .op_sub
    ; 3- multiplicação
    cmp ebx, 3
    je .op_mul
    ; 4- divisão
    cmp ebx, 4
    je .op_div
    ; 5- exponenciação
    cmp ebx, 5
    je .op_expo
    ; 6- módulo
    cmp ebx, 6
    je .op_mod
    ; caso não seja uma opção válida, faz o retorno
.menu_back:
    leave
    ret

.op_soma:
    cmp byte[precision], P16
    je .op_soma_16
    cmp byte[precision], P32
    je .op_soma_32

.back_op:
    ; converte a resposta para texto
    push eax
    push 11
    call tostr
    
    ; printa o resultado
    push 11
    push response
    call print
    add esp, 8
    push nl_size
    push nl
    call print
    add esp, 8

    ; volta para o menu
    jmp .menu_back
    
.op_soma_16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call soma16
    add esp, 4

    jmp .back_op

.op_soma_32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call soma32
    add esp, 8

    jmp .back_op

.op_sub:
    cmp byte[precision], P16
    je .op_sub_16
    cmp byte[precision], P32
    je .op_sub_32

.op_sub_16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call sub16
    add esp, 4

    jmp .back_op

.op_sub_32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call sub32
    add esp, 8

    jmp .back_op

.op_mul:
    cmp byte[precision], P16
    je .op_mul_16
    cmp byte[precision], P32
    je .op_mul_32

.op_mul_16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call mul16
    add esp, 4

    jmp .back_op

.op_mul_32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call mul32
    add esp, 8
    
    jmp .back_op


.op_div:
    cmp byte[precision], P16
    je .op_div_16
    cmp byte[precision], P32
    je .op_div_32

.op_div_16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call div16
    add esp, 4

    jmp .back_op

.op_div_32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call div32
    add esp, 8
    
    jmp .back_op


.op_expo:
    cmp byte[precision], P16
    je .op_expo16
    cmp byte[precision], P32
    je .op_expo32

.op_expo16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call expo16
    add esp, 4

    jmp .back_op

.op_expo32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call expo32
    add esp, 8
    
    jmp .back_op


.op_mod:
    cmp byte[precision], P16
    je .op_mod16
    cmp byte[precision], P32
    je .op_mod32

.op_mod16:
    mov ax, word OP1
    mov bx, word OP2
    push ax ; operando 1
    push bx ; operando 2
    call mod16
    add esp, 4

    jmp .back_op

.op_mod32:
    mov eax, OP1
    mov ebx, OP2
    push eax ; operando 1
    push ebx ; operando 2
    call mod32
    add esp, 8

    jmp .back_op


check_overflow:
    jo .OF_ocurred
    ret
.OF_ocurred:
    push len_OF
    push msg_OF
    call print
    add esp, 8
    jmp exit

tonum:
    ; converte string para valor numerico

    xor eax, eax ; eax armazena o resultado parcial
    mov edx, [esp+4]

    movzx ecx, byte[edx] ; pega o primeiro caractere
    cmp ecx, '-' ; verifica se é negativo
    jne .top ; se não, pula direto para a conversão

    ; Se for negativo
    mov ebx, 1 ; flag de negativo
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
    cmp ebx, 1
    je .neg_tonum
    ret
.neg_tonum:
    neg eax
    ret
    
tostr:
    ; Converte valor numerico para string
	mov eax,[esp+8]		; valor numerico
	mov	ebx,response+10	; digito menos significativo
	mov	ecx,[esp+4]	    ; tamanho do numero
	mov	edi,10

    ; verifica sinal
    cmp eax, 0
    jge .tostr_loop ; positivo

    ; negativo
	mov byte [response], '-' ; coloca o sinal negativo no inicio da string
	neg eax ; converte o numero para negativo
	inc edx ; incrementa o indice da string
	dec ecx ; decrementa o tamanho do numero

.tostr_loop:
	mov	edx,0
	div	edi
	add	edx,48
	mov	[ebx],dl
	dec	ebx
	dec ecx
	jnz .tostr_loop
	
	ret 4
