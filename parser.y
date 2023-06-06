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
%token CONCAT LENGHT AND OR NOT 
%token WHILE IN DO FOR SWITCH CASE BREAK CONTINUE RETURN PRINT INPUT
%token <iValue> NUMBER
%token FUNCTION PROCEDURE BEGIN_BLOCK END_BLOCK IF  THEN ELSE LPAREN RPAREN COLON
%token SEMICOLON COMMA
%token LESSTHENEQ MORETHENEQ LESSTHEN MORETHEN MOREISEQUAL LESSISEQUAL ISEQUAL INCREMENT DECREMENT 
%token ASSIGNMENT LBRACK RBRACK LBRACE RBRACE DOT PLUS MINUS MULTIP DIVIDE

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

funcao : FUNCTION ID LPAREN args RPAREN COLON TYPE corpo             
       ;

procedimento : PROCEDURE ID LPAREN args RPAREN corpo                 
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

corpo : BEGIN_BLOCK END_BLOCK                                        
     ;
%%

int main (void) {
	return yyparse ( );
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", yylineno, msg, yytext);
	return 0;
}