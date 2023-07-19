section .data
    msg db 'Hello, World!', 0Ah

section .text
    global _start

_start:
    ; write massage
    mov eax, 4           ; syscall write
    mov ebx, 1           ; file descriptor stdout
    mov ecx, msg         ; pointer to message
    mov edx, 14          ; message lenght
    int 80h              ; syscall

    ; exit
    mov eax, 1           ; syscall exit
    xor ebx, ebx         ; exit code 0
    int 80h              ; syscall

