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

%type <rec> decl_vars decl_var subps subp main decl_funcao decl_procedimento args_aux comando ids expressao condicional chamada_funcao saida
%type <rec> ids_aux args block termo ops ops_1 params return const

%start programa

%%
programa : BEGIN_BLOCK decl_vars subps main END_BLOCK
            {fprintf(yyout, "%s\n%s\n%s", $2->code, $3->code, $4->code);
            freeRecord($2);
            freeRecord($3);
            freeRecord($4);                        
            }                                            
	    ;

decl_vars :                    {$$ = createRecord("","");}
          | decl_var decl_vars {char * s = cat($1->code, "\n", $2->code, "", "");
                               freeRecord($1);
                               freeRecord($2);
                               $$ = createRecord(s, "");
                               free(s);
                               }
          ;

decl_var : TYPE ID ASSIGNMENT expressao SEMICOLON
            {char * s = cat($1, " ", $2, ";", "");
            free($1);
            free($2);
            $$ = createRecord(s, "");
            free(s);
            }
         ;

subps :            {$$ = createRecord("","");}                                        
      | subp subps {char * s = cat($1->code, "\n", $2->code, "", "");
                   freeRecord($1);
                   freeRecord($2);
                   $$ = createRecord(s, "");
                   free(s);
                   }                                          
      ;

subp : decl_funcao       {$$ = $1;}                                        
     | decl_procedimento {$$ = $1;}                                              
     ;

main : MAIN_BLOCK LBRACE block RBRACE
            {char * s1 = cat("main", "(", ")", "{", $3->code);
            char * s2 = cat(s1, "}", "", "", "");
            free(s1);
            freeRecord($3);
            $$ = createRecord(s2, "");
            free(s2);
            }
     ;

decl_funcao : FUNCTION TYPE ID LPAREN args RPAREN  LBRACE block RBRACE             
                 {char * s1 = cat($2, " ", $3, "(", $5->code);
                  char * s2 = cat(s1, ")\n", "{\n", $8->code, "}");
                  free(s1);
                  free($2);
                  free($3);
                  freeRecord($5);
                  freeRecord($8);
                  $$ = createRecord(s2, "");
                  free(s2);
                 }
            ;

decl_procedimento : PROCEDURE ID LPAREN args RPAREN LBRACE block RBRACE  
                        {char * s1 = cat($2, "(", $4->code, ")\n", "{\n");
                        char * s2 = cat(s1, $7->code, "}", "", "");
                        free(s1);
                        free($2);
                        freeRecord($4);
                        freeRecord($7);
                        $$ = createRecord(s2, "");
                        free(s2);
                        }                 
             ;

args :          {$$ = createRecord("","");}                                                            
     | args_aux {$$ = $1;}                                                 
     ;

args_aux : TYPE ids 
            {char * s = cat($1, " ", $2->code, "", "");
                  free($1);
                  freeRecord($2);
                  $$ = createRecord(s, "");
                  free(s);
            }                                      
         | TYPE ids SEMICOLON args_aux     
            {char * s = cat($1, " ", $2->code, ";", "$4->code");
                  free($1);
                  freeRecord($2);
                  freeRecord($4);
                  $$ = createRecord(s, "");
                  free(s);
            }                            
         ;                  

ids :         {$$ = createRecord("","");}                                                         
    | ids_aux {$$ = $1;}                                                    
    ;

ids_aux : ID 
            {$$ = createRecord($1, "");
                  free($1);
            }                                                    
        | ID COMMA ids_aux
            {char * s = cat($1, ",", $3->code, "", "");
                  free($1);
                  freeRecord($3);
                  $$ = createRecord(s, "");
                  free(s);
            }
        ;            

block :                 {$$ = createRecord("","");}
      | decl_var block  {char * s = cat($1->code, " ", $2->code, "", "");
                              freeRecord($1);
                              freeRecord($2);
                              $$ = createRecord(s, "");
                              free(s);
                        }
      | comando block   {char * s = cat($1->code, " ", $2->code, "", "");
                              freeRecord($1);
                              freeRecord($2);
                              $$ = createRecord(s, "");
                              free(s);
                        }                                 
      ;

comando : condicional {$$ = $1;}
        | return      {$$ = $1;}
        | saida       {$$ = $1;}
        ;             

condicional : IF LPAREN expressao RPAREN LBRACE block RBRACE 
                  {char * s1 = cat("if", "(", $3->code, ")", "{\n");
                  char * s2 = cat(s1, $6->code, "}", "", "");
                  free(s1);
                  freeRecord($3);
                  freeRecord($6);
                  $$ = createRecord(s2, "");
                  free(s2);
                  }
            | IF LPAREN expressao RPAREN LBRACE block RBRACE ELSE LBRACE block RBRACE
                  {char * s1 = cat("if", "(", $3->code, ")", "{\n");
                  char * s2 = cat(s1, $6->code, "}", "else", "{");
                  char * s3 = cat(s2, $10->code, "}", "", "");
                  free(s1);
                  free(s2);
                  freeRecord($3);
                  freeRecord($6);
                  freeRecord($10);
                  $$ = createRecord(s3, "");
                  free(s3);
                  }
            ;

return : RETURN SEMICOLON 
            {char * s = cat("return", " ", ";", "", "");
            $$ = createRecord(s, "");
            free(s);
            }
       | RETURN expressao SEMICOLON
            {char * s = cat("return", " ", $2->code, ";", "");
            freeRecord($2);
            $$ = createRecord(s, "");
            free(s);
            }
       ;

saida : PRINT LPAREN expressao RPAREN SEMICOLON
            {char * s = cat("printf", "(", $3->code, ")", ";");
                  freeRecord($3);
                  $$ = createRecord(s, "");
                  free(s);
            }

params : expressao               {$$ = $1;}
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
                  {char * s1 = cat($1, "(", $3->code, ")", ";");
                  free($1);
                  freeRecord($3);
                  $$ = createRecord(s1, "");
                  free(s1);
                  }
               ;

ops : ops_1 PLUS ops_1
      {char * s1 = cat($1->code, "+", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    | ops_1 PLUS termo
      {char * s1 = cat($1->code, "+", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    | termo PLUS termo
      {char * s1 = cat($1->code, "+", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    | ops_1 MINUS ops_1
      {char * s1 = cat($1->code, "-", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    | ops_1 MINUS termo
      {char * s1 = cat($1->code, "-", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    | termo MINUS termo
      {char * s1 = cat($1->code, "-", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    ;

ops_1 : termo DIVIDE termo
            {char * s1 = cat($1->code, "/", $3->code, "", "");
                  freeRecord($1);
                  freeRecord($3);
                  $$ = createRecord(s1, "");
                  free(s1);
            }
    | termo MULTIP termo
      {char * s1 = cat($1->code, "*", $3->code, "", "");
            freeRecord($1);
            freeRecord($3);
            $$ = createRecord(s1, "");
            free(s1);
      }
    ;

termo : ID
            {$$ = createRecord($1, "");
                  free($1);
            }    
      | NUMBER
      | QUOT const QUOT
      | LPAREN expressao RPAREN
            {char * s1 = cat("(", $2->code, ")", "", "");
                  freeRecord($2);
                  $$ = createRecord(s1, "");
                  free(s1);
            }
      ;

const : {$$ = createRecord("","");}
      | ID const
            {char * s1 = cat($1, " ", $2->code, "", "");
                  free($1);
                  freeRecord($2);
                  $$ = createRecord(s1, "");
                  free(s1);
            }
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