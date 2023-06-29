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
%token ASSIGNMENT LBRACK RBRACK LBRACE RBRACE DOT PLUS MINUS MULTIP DIVIDE MOD LIT_STRING POWER

%start programa

%%
programa : BEGIN_BLOCK decl_vars subps main END_BLOCK                                              
	    ;

decl_vars : 
          | decl_var decl_vars
          ;

decl_var : TYPE ID ASSIGNMENT expressao
         ;

subps :                                                              
      | subp subps                                                    
      ;

subp : decl_funcao                                                        
     | decl_procedimento                                                  
     ;

main : MAIN_BLOCK LBRACE stmts RBRACE
     ;

decl_funcao : FUNCTION TYPE ID LPAREN args RPAREN  LBRACE stmts RBRACE             
       ;

decl_procedimento : PROCEDURE ID LPAREN args RPAREN LBRACE stmts RBRACE                   
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
stmts:
      | stmts_aux SEMICOLON
      ;

stmts_aux: stmt
      | stmt SEMICOLON stmts_aux
      ;
stmt: decl_var
      | condicional
      | return
      | saida
      ;       

condicional : IF LPAREN expressao RPAREN LBRACE stmts RBRACE 
            | IF LPAREN expressao RPAREN LBRACE stmts RBRACE ELSE LBRACE stmts RBRACE
            ;

return : RETURN
       | RETURN expressao
       ;

saida : PRINT LPAREN expressao RPAREN

params : expressao
       | expressao COMMA params
       ;

expressao : term_terc
          | expressao relacional_ops term_terc
          | 
          ;

term_terc : term_sec terc_ops term_terc
      |term_sec
      ; 

term_sec : term_prim sec_ops term_sec
      |term_prim
      ;
      
term_prim: factor prim_ops term_prim
      |factor
      ;    

factor : ID
      | NUMBER
      | LIT_STRING
      | LPAREN expressao RPAREN
      ;

relacional_ops : ISEQUAL
          | LESSTHENEQ
          | MORETHENEQ
          | LESSTHEN
          | MORETHEN
          | MOREISEQUAL
          | LESSISEQUAL
          ;

prim_ops : POWER 
    ;

sec_ops : DIVIDE
      | MULTIP
    ;

terc_ops : PLUS
    | MINUS
    ;
chamada_funcao : ID LPAREN params RPAREN
                  ;
%%

int main (void) {
	return yyparse ( );
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", nolineo, msg, yytext);
	return 0;
}