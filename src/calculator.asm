section .data
    nl          db  "", 0Dh, 0Ah
    nl_size     EQU $-nl
    ; user massages
    msg1        db  "Bem-vindo. Digite seu nome: ", 0
    msg1_size   EQU $-msg1
    msg2        db  "Hola, ", 0
    msg2_size   EQU $-msg2
    msg3        db  ", bem-vindo ao programa de CALC IA-32", 0
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
    username    resb 32
    precision   resb 1
    operation   resb 1


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

    ; printa o nome entre strings
    push msg2_size
    push msg2
    call print
    push 32
    push username
    call print
    push msg3_size
    push msg3
    call print
    ; new line
    push nl_size
    push nl
    call print

    ; obtem a precisão
    push msg4_size
    push msg4
    call print
    push 1
    push precision
    call input

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

    call input
    push 1
    push operation
    call input
    
    push operation
    call menu_logic

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
    mov eax, 4          ; write
    mov ebx, 1          ; out
    mov ecx, [esp + 4]  ; msg
    mov edx, [esp + 8]  ; len
    int 80h

    ret 4

input:
    ; args: len_var, var
    ; TODO: remover quebra de linha da entrada

    mov eax, 3         ; read
	mov ebx, 0         ; out
	mov ecx, [esp + 4] ; msg
	mov edx, [esp + 8] ; len
	int 80h

    ret 4

input_num:
    ; args: len_var, var
    mov eax, 3         ; read
	mov ebx, 0         ; out
	mov ecx, [esp + 4] ; msg
	mov edx, [esp + 8] ; len
	int 80h

    ret 4

menu_logic:
    mov eax, [esp+4]


    ; 1: soma
    cmp byte [eax], 31h
    je op_soma
    ; 7 : exit
    cmp byte [eax], 37h
    je exit

    ret 2

# TODO: funcs operations
op_soma:
    ; pede 2 numeros para o usuario
    ; armazena em variáveis locais
    ; chama a operação
    
# TODO: convert string to int
str2int:
