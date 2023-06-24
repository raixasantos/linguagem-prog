%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./lib/record.h"

int yylex(void);
int yyerror(char *s);
extern int yylineno;
extern char * yytext;
extern FILE * yyin, * yyout;

char * cat(char *, char *, char *, char *, char *);

%}

%union {
	int    iValue; 	/* integer value */
	char   cValue; 	/* char value */
	char * sValue;  /* string value */
      struct record * rec;
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

%type <rec> decl_vars decl_var subps subp main decl_funcao decl_procedimento args block 
%type <rec>  return

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
                 {char * s1 = cat("function", " ", $2, " ", $3);
                  char * s2 = cat(s1, " ", "(",  $5->code, ")\n");
                  char * s3 = cat(s2, "{\n", $8->code, "}", "");
                  free(s1);
                  free(s2);
                  free($2);
                  free($3);
                  freeRecord($5);
                  freeRecord($8);
                  $$ = createRecord(s3, "");
                  free(s3);
                 }
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


int main (int argc, char ** argv) {
 	int codigo;

    if (argc != 3) {
       printf("Usage: $./compiler input.txt output.txt\nClosing application...\n");
       exit(0);
    }
    
    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[2], "w");

    codigo = yyparse();

    fclose(yyin);
    fclose(yyout);

	return codigo;
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", yylineno, msg, yytext);
	return 0;
}

char * cat(char * s1, char * s2, char * s3, char * s4, char * s5){
  int tam;
  char * output;

  tam = strlen(s1) + strlen(s2) + strlen(s3) + strlen(s4) + strlen(s5)+ 1;
  output = (char *) malloc(sizeof(char) * tam);
  
  if (!output){
    printf("Allocation problem. Closing application...\n");
    exit(0);
  }
  
  sprintf(output, "%s%s%s%s%s", s1, s2, s3, s4, s5);
  
  return output;
}