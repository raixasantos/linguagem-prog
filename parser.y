%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s);
extern int yylineno;
extern char * yytext;

%}

%union {
	int    iValue; 	/* integer value */
	char   cValue; 	/* char value */
	char * sValue;  /* string value */
};

%token <sValue> ID
%token <sValue> TYPE
%token <iValue> NUMBER
%token FUNCTION PROCEDURE BEGIN_BLOCK END_BLOCK WHILE DO IF THEN ELSE ASSIGN 

%type <sValue> corpo
%type <sValue> procedimento
%type <sValue> funcao
%type <sValue> subp
%type <sValue> subps args args_aux ids ids_aux

%start programa

%%
programa : subps corpo
	     ;

subps :
      | subp subps 
      ;

subp : funcao   
     | procedimento 
     ;

funcao : FUNCTION ID '(' args ')' ':' TYPE corpo
       ;

procedimento : PROCEDURE ID '(' args ')' corpo
             ;

args : 
     | args_aux
     ;

args_aux : TYPE ids 
         | TYPE ids ';' args_aux 
         ;                  

ids :
    | ids_aux 
    ;

ids_aux : ID 
        | ID ',' ids_aux
        ;            

corpo : BEGIN_TOKEN END_TOKEN

%%

int main (void) {
	return yyparse ( );
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", yylineno, msg, yytext);
	return 0;
}