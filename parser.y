%{
#include <stdio.h> // precisa para chamar funcoes como printf()
#include <stdlib.h>
#include <string.h>

int yylex(void); // retorna o numero correspondente ao token lido
int yyerror(char *s); // chamada quando o parser encontra erro
extern int nolineo; // trackear o numero da linha
extern char * yytext;

%}

/* */
%union {
	int    iValue; 	/* integer value */
	char   cValue; 	/* char value */
	char * sValue;  /* string value */
};

%token <sValue> ID
%token <sValue> TYPE
%token CONCAT LENGHT AND OR NOT 
%token WHILE IN DO FOR SWITCH CASE BREAK CONTINUE RETURN PRINT INPUT
%token <iValue> NUMBER
%token FUNCTION PROCEDURE BEGIN_BLOCK END_BLOCK MAIN_BLOCK IF  THEN ELSE LPAREN RPAREN COLON
%token SEMICOLON COMMA
%token LESSTHENEQ MORETHENEQ LESSTHEN MORETHEN MOREISEQUAL LESSISEQUAL ISEQUAL INCREMENT DECREMENT 
%token ASSIGNMENT LBRACK RBRACK LBRACE RBRACE DOT PLUS MINUS MULTIP DIVIDE MOD QUOT

%start programa

%%
programa : BEGIN_BLOCK decl_vars subps main END_BLOCK                                              
	    ;

decl_vars : 
          | decl_var decl_vars
          ;

decl_var : TYPE ID ASSIGNMENT expressao SEMICOLON
         ;

subps :                                                              
      | subp subps                                                    
      ;

subp : decl_funcao                                                        
     | decl_procedimento                                                  
     ;

main : MAIN_BLOCK LBRACE block RBRACE
     ;

decl_funcao : FUNCTION TYPE ID LPAREN args RPAREN  LBRACE block RBRACE             
       ;

decl_procedimento : PROCEDURE ID LPAREN args RPAREN LBRACE block RBRACE                   
             ;

args :                                                               
     | args_aux                                                      
     ;

args_aux : TYPE ids                                                  
         | TYPE ids SEMICOLON args_aux                               
         ;

ids :                                                                
    | ids_aux                                                        
    ;

ids_aux : ID                                                         
        | ID COMMA ids_aux                                           
        ;            

block : 
      | decl_var block 
      | comando block                                     
      ;

comando : condicional
        | return
        | saida
        ;             

condicional : IF LPAREN expressao RPAREN LBRACE block RBRACE 
            | IF LPAREN expressao RPAREN LBRACE block RBRACE ELSE LBRACE block RBRACE
            ;

return : RETURN SEMICOLON
       | RETURN expressao SEMICOLON
       ;

saida : PRINT LPAREN expressao RPAREN SEMICOLON

params : expressao
       | expressao COMMA params
       ;

expressao : termo
          | chamada_funcao
          | ops
          | ops ISEQUAL ops
          | ops ISEQUAL termo
          | termo ISEQUAL termo
          ;

chamada_funcao : ID LPAREN params RPAREN
               ;

ops : ops_1 PLUS ops_1
    | ops_1 PLUS termo
    | termo PLUS termo
    | ops_1 MINUS ops_1
    | ops_1 MINUS termo
    | termo MINUS termo
    ;

ops_1 : termo DIVIDE termo
    | termo MULTIP termo
    ;

termo : ID
      | NUMBER
      | QUOT const QUOT
      | LPAREN expressao RPAREN
      ;

const : 
      | ID const
      ;
%%

int main (void) {
	return yyparse ( );
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", nolineo, msg, yytext);
	return 0;
}