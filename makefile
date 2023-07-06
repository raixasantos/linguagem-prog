all: compilador

compilador: lex.yy.c y.tab.c 
	gcc lex.yy.c y.tab.c ./lib/record.c -o compiler

lex.yy.c: lexer.l
	lex lexer.l

y.tab.c: parser.y  
	yacc parser.y -d -v

clean:
	rm -rf lex.yy.c y.tab.* compiler output.txt y.output

compile:
	./compiler teste/attrInputTest.txt teste.c

generatec:
	gcc -o test teste.c
	./test

recompile: clean all compile
	