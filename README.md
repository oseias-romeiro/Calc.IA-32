# IA-32 Calculator
Implementação de um calculadora em Assembly Intel IA-32 de números de 2 precisões

## Executando

```shell
nasm nasm -f elf32 calculator.asm
ld -m elf_i386 -o calculator calculator.o
./calculator
```