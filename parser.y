%{
#include <stdio.h> // precisa para chamar funcoes como printf()
#include <stdlib.h>
#include <string.h>
#include "./lib/record.h"


int yylex(void); // retorna o numero correspondente ao token lido
int yyerror(char *s); // chamada quando o parser encontra erro
extern int nolineo; // trackear o numero da linha
extern int nolabels;
extern char * yytext;
extern FILE * yyin, * yyout;

%}

/* */
%union {
	int    iValue; 	/* integer value */
      double dValue;   /* double value */
	char   cValue; 	/* char value */
	char * sValue;  /* string value */
      struct record * rec;
};

%token <sValue> ID LIT_STRING 
%token <sValue> TYPE
%token CONCAT LENGHT AND OR NOT ISEQUAL
%token WHILE IN DO FOR SWITCH CASE BREAK CONTINUE RETURN PRINT INPUT
%token <iValue> NUMBER_INT
%token <dValue> NUMBER
%token FUNCTION PROCEDURE BEGIN_BLOCK END_BLOCK MAIN_BLOCK IF THEN ELSE ELSEIF LPAREN RPAREN COLON
%token SEMICOLON COMMA
%token LESSTHENEQ MORETHENEQ LESSTHEN MORETHEN MOREISEQUAL LESSISEQUAL ISNOTEQUAL INCREMENT DECREMENT 
%token ASSIGNMENT LBRACK RBRACK LBRACE RBRACE DOT PLUS MINUS MULTIP DIVIDE MOD POWER

%type <rec> declaracao decl_vars decl_var_aux  decl_var decl_vars_aux subps subp main decl_funcao decl_procedimento args_aux ids expressao stmt condicional if_single elseif else condicional_aux chamada_funcao saida stmts_aux
%type <rec> ids_aux args params return factor stmts iteracao atribuicao entrada term_terc term_sec terc_ops relacional_ops term_prim sec_ops prim_ops

%start programa

%%
      programa : BEGIN_BLOCK declaracao subps main END_BLOCK
                  {
                        fprintf(yyout, "%s%s%s", $2->code, $3->code, $4->code);
                        freeRecord($2);
                        freeRecord($3);
                        freeRecord($4);                        
                  }                                            
            ;

      declaracao:       {$$ = createRecord("","");}
            | decl_vars SEMICOLON
                        {
                              char * s = cat($1->code, ";\n", "", "", "");
                              freeRecord($1);
                              $$ = createRecord(s, "");
                              free(s);
                        }

      decl_vars : decl_var      {$$ = $1;} 
            | decl_vars_aux {$$ = $1;} 
            ;

      decl_vars_aux : decl_var COMMA decl_var_aux 
                        {
                              char * s = cat($1->code, ", ", $3->code, "", "");
                              freeRecord($1);
                              freeRecord($3);
                              $$ = createRecord(s, "");
                              free(s);
                        }
                  ;

      decl_var_aux : atribuicao {$$ = $1;}  
                  | atribuicao COMMA decl_var_aux 
                        {
                              char * s = cat($1->code, ", ", $3->code, "", "");
                              freeRecord($1);
                              freeRecord($3);
                              $$ = createRecord(s, "");
                              free(s);
                        }
                  ;

            
      decl_var : TYPE atribuicao
                  {
                        char * s1 = cat($1, " ", $2->code, "", "");
                        freeRecord($2);
                        $$ = createRecord(s1, "");
                        free(s1);
                  }
            ;

      subps :            {$$ = createRecord("","");}                                        
            | subp subps {
                              char * s = cat($1->code, "\n", $2->code, "", "");
                              freeRecord($1);
                              freeRecord($2);
                              $$ = createRecord(s, "");
                              free(s);
                        }                                          
            ;

      subp : decl_funcao       {$$ = $1;}                                        
      | decl_procedimento {$$ = $1;}                                              
      ;

      main : MAIN_BLOCK LBRACE stmts RBRACE
                  {
                        char * s1 = cat("int main", "(", ")", "{\n", $3->code);
                        char * s2 = cat(s1, "\nreturn 0;", "\n}", "", "");
                        free(s1);
                        freeRecord($3);
                        $$ = createRecord(s2, "");
                        free(s2);
                  }
      ;

      decl_funcao : FUNCTION TYPE ID LPAREN args RPAREN  LBRACE stmts RBRACE             
                  {
                              char * s1 = cat($2, " ", $3, "(", $5->code);
                              char * s2 = cat(s1, ")", "{\n", $8->code, "\n}");
                              free(s1);
                              free($2);
                              free($3);
                              freeRecord($5);
                              freeRecord($8);
                              $$ = createRecord(s2, "");
                              free(s2);
                  }
                  ;

      decl_procedimento : PROCEDURE ID LPAREN args RPAREN LBRACE stmts RBRACE  
                              {
                                    char * s1 = cat($2, "(", $4->code, ")\n", "{\n");
                                    char * s2 = cat(s1,$7->code, "\n}", "", "");
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
                  {
                        char * s = cat($1, " ", $2->code, "", "");
                        free($1);
                        freeRecord($2);
                        $$ = createRecord(s, "");
                        free(s);
                  }                                      
            | TYPE ids SEMICOLON args_aux     
                  {
                        char * s = cat($1, " ", $2->code, ",", $1);
                        char * s1 = cat(s, $4->code,"","","");
                        free(s);
                        free($1);
                        freeRecord($2);
                        freeRecord($4);
                        $$ = createRecord(s1, "");
                        free(s1);
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
                  {
                        char * s = cat($1, ",", $3->code, "", "");
                        free($1);
                        freeRecord($3);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;            
      stmts:            {$$ = createRecord("","");}
            | stmts_aux {$$ = $1;}
            ;

      stmts_aux: stmt        {$$ = $1;}
            | stmt stmts_aux 
                  {
                        char * s = cat($1->code, "\n", $2->code, "", "");
                        freeRecord($1);
                        freeRecord($2);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;

      stmt: decl_vars SEMICOLON
                  {
                        char * s = cat($1->code, ";", "", "", "");
                        freeRecord($1);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | return SEMICOLON
                  {
                        char * s = cat($1->code, "", "", "", "");
                        freeRecord($1);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | atribuicao SEMICOLON
                  {
                        char * s = cat($1->code, ";", "", "", "");
                        freeRecord($1);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | entrada SEMICOLON
                  {
                        char * s = cat($1->code, "", "", "", "");
                        freeRecord($1);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | saida SEMICOLON
                  {
                        char * s = cat($1->code, "", "", "", "");
                        freeRecord($1);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | condicional           
                  {$$ = $1;}
            | iteracao              
                  {$$ = $1;}
            ;       

      condicional : 
              if_single condicional_aux
              {
                char * s = cat($1->code, "\n", $2->code, "", "");
                freeRecord($1);
                freeRecord($2);
                $$ = createRecord(s, "");
                free(s);
               }  
     ; 
            ;
      condicional_aux :        {$$ = createRecord("","");}
                  | elseif condicional_aux
                  {
                    char * s = cat($1->code, "\n", $2->code, "", "");
                    freeRecord($1);
                    freeRecord($2);
                    $$ = createRecord(s, "");
                    free(s);
                    } 
                  | else  {$$ = $1;}
                ;
      else: ELSE LBRACE stmts RBRACE
            {
                char * s = cat("else", "{", $3->code, "}", "\n");
                freeRecord($3);
                $$ = createRecord(s, "");
                free(s);
            };

      elseif: ELSEIF LPAREN expressao RPAREN LBRACE stmts RBRACE
           {
            char * s1 = cat("else if", "(", $3->code, ")", "{\n");
            char * s2 = cat(s1, $6->code, "\n}", "", "");
            free(s1);
            freeRecord($3);
            freeRecord($6);
            $$ = createRecord(s2, "");
            free(s2);
      }
            ;
                  //if(a<0){...}
      if_single : IF LPAREN expressao RPAREN LBRACE stmts RBRACE
      {
            char * s1 = cat("if", "(", $3->code, ")", "{\n");
            char * s2 = cat(s1, $6->code, "\n}", "", "");
            free(s1);
            freeRecord($3);
            freeRecord($6);
            $$ = createRecord(s2, "");
            free(s2);
      }

      iteracao : WHILE LPAREN expressao RPAREN LBRACE stmts RBRACE
                  {
                        char str[10000];
                        sprintf(str, "%d", nolabels);
                        char * s11 = cat("if(!", $3->code, "){\n goto fim; \n}\n", "", "");
                        char * s1 = cat("label", str, ":\n", s11, $6->code);
                        char * s2 = cat(s1, "\ngoto ", "label", str, ";\nfim:");
                        nolabels++;
                        free(s1);
                        free(s11);
                        freeRecord($3);
                        freeRecord($6);
                        $$ = createRecord(s2, "");
                        free(s2);
                  }
            ;  

      atribuicao : ID ASSIGNMENT expressao
                  {
                        char * s = cat($1," ", "= ", $3->code,"");
                        freeRecord($3);
                        $$ = createRecord(s, "");
                        free(s);
                  }
                  | ID MOREISEQUAL expressao
                  {
                        char * s = cat($1," ", "+= ", $3->code,"");
                        freeRecord($3);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;

      return : RETURN expressao
                  {
                        char * s = cat("return", " ", $2->code, ";", "");
                        freeRecord($2);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;

      entrada : INPUT LPAREN TYPE ID RPAREN
                  {     
                        char* s = "";
                        if(!strcmp($3,"int")){
                        s = cat("scanf(\"%d\", ", $4, ");" , "", "");
                        $$ = createRecord(s, "");
                        }else if(!strcmp($3,"float")){
                              s = cat("scanf(\"%lf\", ", $4, ");" , "", "");
                              $$ = createRecord(s, "");
                        }else if(!strcmp($3,"string")){
                              s = cat("scanf(\"%s\", ", $4, ");" , "", "");
                              $$ = createRecord(s, "");
                        }else if(!strcmp($3,"bool")){
                              s = cat("scanf(\"%i\", ", $4, ");" , "", "");
                              $$ = createRecord(s, "");
                        }
                        free(s);
                  }
            ;

      saida : PRINT LPAREN expressao COMMA ids RPAREN
                  {
                        char * s1 = cat("printf", "(", $3->code, ", ", $5->code);
                        char * s2 = cat(s1, ")", ";", "", "");
                        free(s1);
                        freeRecord($3);
                        freeRecord($5);
                        $$ = createRecord(s2, "");
                        free(s2);
                  }
            | PRINT LPAREN expressao RPAREN 
                  {
                        char * s = cat("printf", "(", $3->code, ")", ";");
                        freeRecord($3);
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;

      params : expressao               {$$ = $1;}
            | expressao COMMA params  {
                                          char * s = cat($1->code, ",", $3->code, "", "");
                                          freeRecord($1);
                                          freeRecord($3);
                                          $$ = createRecord(s, "");
                                          free(s);
                                    }
            ;

      expressao : term_terc                           {$$ = $1;}
            | expressao relacional_ops term_terc  {
                                                            char * s = cat($1->code, $2->code, $3->code, "", "");
                                                            freeRecord($1);
                                                            freeRecord($2);
                                                            freeRecord($3);
                                                            $$ = createRecord(s, "");
                                                            free(s);
                                                      }                                   
            ;

      term_terc : term_sec terc_ops term_terc {
                                                      char * s = cat($1->code, $2->code, $3->code, "", "");
                                                      freeRecord($1);
                                                      freeRecord($2);
                                                      freeRecord($3);
                                                      $$ = createRecord(s, "");
                                                      free(s);
                                          }
            |term_sec                         {$$ = $1;}
            ; 

      term_sec : term_prim sec_ops term_sec {
                                                char * s = cat($1->code, $2->code, $3->code, "", "");
                                                freeRecord($1);
                                                freeRecord($2);
                                                freeRecord($3);
                                                $$ = createRecord(s, "");
                                                free(s);
                                          }
            |term_prim                      {$$ = $1;}
            ;
            
      term_prim: factor prim_ops term_prim {
                                                char * s = cat($1->code, $2->code, $3->code, "", "");
                                                freeRecord($1);
                                                freeRecord($2);
                                                freeRecord($3);
                                                $$ = createRecord(s, "");
                                                free(s);
                                          }
            |factor                         {$$ = $1;}
            ;    

      factor : ID       {     
                              $$ = createRecord($1, "");
                              free($1);
                        }
            | NUMBER_INT {    
                              char* str = malloc(sizeof(char) * 1000); 
                              sprintf(str, "%d", $1);
                              $$ = createRecord(str, "");
                              free(str);
                        }
            | NUMBER     {    char* str = malloc(sizeof(char) * 1000); 
                              sprintf(str, "%lf", $1);
                              $$ = createRecord(str, "");
                              free(str);
                        }
            | LIT_STRING {    char* print = malloc(sizeof(char) *10000);
                              if($1 != NULL) {
                                    sprintf(print, "%s", $1);
                              }
                              $$ = createRecord(print, "");
                              free($1);
                              free(print);
                        }
            | LPAREN expressao RPAREN
                  {
                        char * s1 = cat("(", $2->code, ")", "", "");
                        freeRecord($2);
                        $$ = createRecord(s1, "");
                        free(s1);
                  }
            | chamada_funcao
                  {$$ = $1;}
            ;

      relacional_ops : AND
                        {
                              char * s = cat(" && ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | OR
                        {
                              char * s = cat(" || ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | ISEQUAL
                        {
                              char * s = cat(" == ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | ISNOTEQUAL
                        {
                              char * s = cat(" != ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | LESSTHENEQ
                        {
                              char * s = cat(" <= ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | MORETHENEQ
                        {
                              char * s = cat(" >= ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | LESSTHEN
                        {
                              char * s = cat(" < ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | MORETHEN
                        {
                              char * s = cat(" > ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | MOREISEQUAL
                        {
                              char * s = cat(" += ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            | LESSISEQUAL
                        {
                              char * s = cat(" -= ", "", "", "", "");
                              $$ = createRecord(s, "");
                              free(s);
                        }
            
            ;

      prim_ops : POWER 
                  {
                        char * s = cat(" ^ ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
      ;

      sec_ops : DIVIDE
                  {
                        char * s = cat(" / ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | MULTIP
                  {
                        char * s = cat(" * ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | MOD
                  {
                        char * s = cat(" % ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
      ;

      terc_ops : PLUS
                  {
                        char * s = cat(" + ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
            | MINUS
                  {
                        char * s = cat(" - ", "", "", "", "");
                        $$ = createRecord(s, "");
                        free(s);
                  }
            ;

      chamada_funcao : ID LPAREN params RPAREN
                  {
                        char * s1 = cat($1, "(", $3->code, ")", "");
                        free($1);
                        freeRecord($3);
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
    char *diretives = "#include <stdio.h>\n";
    fprintf(yyout, "%s", diretives);
    
    codigo = yyparse();

    fclose(yyin);
    fclose(yyout);

    return codigo;
}

int yyerror (char *msg) {
	fprintf (stderr, "%d: %s at '%s'\n", nolineo, msg, yytext);
	return 0;
}

