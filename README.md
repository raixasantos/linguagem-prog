# Analisador Léxico

Este é o analisador léxico desenvolvido para disciplina Engenharia de Linguagens. Ele é capaz de identificar diferentes tipos de elementos léxicos, como palavras-chave, identificadores, números, operadores e símbolos.

## Como executar

Siga as instruções abaixo para executar o analisador léxico:

1. Certifique-se de ter o [Flex](https://github.com/westes/flex) e o [GCC](https://gcc.gnu.org/) instalados em seu sistema.

2. Faça o download do arquivo `lexer.l`, que contém as regras para o analisador léxico.

3. No terminal, navegue até o diretório onde o arquivo `lexer.l` está localizado.

4. Execute os seguintes comandos:

Abaixo estão os comandos que devem ser executados:

```bash
$ flex lexer.l
$ gcc lex.yy.c
$ ./a.out < nomedocasodeteste.txt
```

O primeiro comando (`flex lexer.l`) irá gerar o arquivo `lex.yy.c` a partir das regras definidas no arquivo `lexer.l`.

O segundo comando (`gcc lex.yy.c`) irá compilar o arquivo `lex.yy.c` e gerar o executável `a.out`.

O terceiro comando (`./a.out < nomedocasodeteste.txt`) irá executar o analisador léxico, fornecendo como entrada o arquivo de teste `nomedocasodeteste.txt`. Certifique-se de substituir `nomedocasodeteste.txt` pelo nome do arquivo que você deseja analisar.

Após a execução, o analisador léxico irá imprimir os tokens encontrados no arquivo de teste.

**Observação:** Certifique-se de que você esteja na pasta 'Casos de teste' para executar o caso de teste: ```quicksort.txt```
