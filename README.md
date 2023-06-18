# PRANS

PRANS é uma linguagem desenvolvida para disciplina Engenharia de Linguagens.

## Como executar

Siga as instruções abaixo para executar o analisador léxico e o analisador sintático:

1. Certifique-se de ter o [Flex](https://github.com/westes/flex), o YACC e o [GCC](https://gcc.gnu.org/) instalados em seu sistema.

2. Faça o download dos arquivos `lexer.l` e `parser.y`, que contém as regras para o analisador léxico e analisador sintático, respectivamente.

3. No terminal, navegue até o diretório onde os arquivos `lexer.l` e `parser.y` estão localizados.

4. Execute os seguintes comandos:

Abaixo estão os comandos que devem ser executados:

```bash
$ flex lexer.l
$ yacc parser.y -d -v
$ gcc lex.yy.c y.tab.c -o a.out
$ cd "Casos de teste"
$ ./a.out < nomedocasodeteste.txt
```

O primeiro comando (`flex lexer.l`) irá gerar o arquivo `lex.yy.c` a partir das regras definidas no arquivo `lexer.l`.

O terceiro comando (`gcc lex.yy.c y.tab.c -o a.out`) irá compilar os arquivos e gerar o executável `a.out`.

O quarto comando (`./a.out < nomedocasodeteste.txt`) irá executar o analisador léxico e sintático, fornecendo como entrada o arquivo de teste `nomedocasodeteste.txt`. Certifique-se de substituir `nomedocasodeteste.txt` pelo nome do arquivo que você deseja analisar.

Após a execução, o analisador sintático irá imprimir apenas os erros encontrados no arquivo de teste.
