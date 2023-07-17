section .text
    extern check_overflow

    global expo16
    global expo32

expo16:
    ; args: base, expoente
    mov ax, 1           ; resultado
    mov cx, word[esp+4] ; base
    mov bx, word[esp+6] ; expoente

    ; repete multiplicações
    expo16_loop:
        cmp bx, 0       ; Verifica se o expoente é zero
        jle expo16_end    ; Se for zero, sai do laço

        imul ax, cx     ; Multiplica o resultado atual pela base
        call check_overflow
        dec bx          ; Decrementa o expoente
        jmp expo16_loop   ; Volta para o início do laço

    expo16_end:
    movsx eax, ax
    ret

expo32:
    ; args: base, expoente
    mov eax, 1            ; resultado
    mov ecx, dword[esp+4] ; base
    mov ebx, dword[esp+8] ; expoente

    ; repete multiplicações
    expo32_loop:
        cmp ebx, 0         ; Verifica se o expoente é zero
        jle expo32_end       ; Se for zero, sai do laço

        imul eax, ecx     ; Multiplica o resultado atual pela base
        call check_overflow
        dec ebx           ; Decrementa o expoente
        jmp expo32_loop     ; Volta para o início do laço

    expo32_end:
    ret
    