# IA-32 Calculator
Projeto de Software Básico que consitem na implementação de um calculadora em Assembly Intel IA-32 de números de 2 precisões (16 e 32 bits).

## Ambiente
Foi utilizado um computador Linux com o compilador `nasm` e o ligador `ld` para desenvolvimento do projeto. Além da criação de um [Makfile](./Makefile) para facilitar o processo de compilação do programa.

## Descrição
Neste trabalho, tive como pricipal objeto colocar em prática os conhecimentos adquiridos ao decorrer do semestre. Criando um programa de forma modular e que usa estrutra de funções, manipulando a pilha de memória e registradores, e assim realizar algumas operações básicas, como: somar, subtrair, multiplicar, dividir, exponenciação e módulo. Além da deteção de overflow nas operações de multiplicação e exponenciação.

## Executando

```shell
make all
./bin/calculator.out
```

## Conclusão
Assim, como requerido para este projeto, foi implementado uma caluladora de duas precisões de forma modular e seguindo prorpiedades de funções com variaveis locais e manipulação da pilha de memória. Todas as operações, saída e entradas de dados exigidas foram implementadas.

