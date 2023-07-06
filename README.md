# PRANS

PRANS é uma linguagem desenvolvida para disciplina Engenharia de Linguagens.

## Como executar

Siga as instruções abaixo para executar o analisador léxico e o analisador sintático:

1. Certifique-se de ter o [Flex](https://github.com/westes/flex), o YACC e o [GCC](https://gcc.gnu.org/) instalados em seu sistema.

2. No terminal, navegue até o diretório linguagem-prog.

3. Execute os seguintes comandos:

Abaixo estão os comandos que devem ser executados:

```bash
$ make all
$ ./compiler teste/nomedoproblema.prans out/nomedoproblema.c
```

O primeiro comando irá compilar os arquivos.

O segundo comando (`./compiler teste/nomedoproblema.prans out/nomedoproblema.c`) irá gerar o problema passado em c, fornecendo como entrada o arquivo `nomedocasodeteste.txt`. Certifique-se de substituir `nomedoproblema.txt` pelo nome do arquivo que você deseja analisar.

