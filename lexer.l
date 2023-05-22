%{
  #include <stdio.h>  
%}

%%

[ \t\n]               ;
[0-9]+                { printf("NUMBER(%s)\n",yytext); }
"int"                 { printf("INT\n"); }
"float"               { printf("FLOAT\n"); }
"bool"                { printf("BOOL\n"); }
"string"              { printf("STRING\n"); }
"concat"              { printf("CONCAT\n"); }
"lenght"              { printf("LENGHT\n"); }
"and"                 { printf("AND\n"); }
"or"                  { printf("OR\n"); }
"not"                 { printf("NOT\n"); }
"while"               { printf("WHILE\n"); }
"begin"               { printf("BEGIN\n"); }
"end"                 { printf("END\n"); }
"do"                  { printf("DO\n"); }
"for"                 { printf("FOR\n"); }
"if"                  { printf("IF\n"); }
"then"                { printf("THEN\n"); }
"else"                { printf("ELSE\n"); }
"return"              { printf("RETURN\n"); }
";"                   { printf("SEMICOLON\n"); }
"<="                  { printf("LESSTHENEQ\n"); }
">="                  { printf("MORETHENEQ\n"); }
"+="                  { printf("MOREISEQUAL\n"); }
"-="                  { printf("LESSISEQUAL\n"); }
"=="                  { printf("ISEQUAL\n"); }
"++"                  { printf("INCREMENT\n"); }
"--"                  { printf("DECREMENT\n"); }
"="                   { printf("ASSIGNMENT\n"); }
","                   { printf("COMMA\n"); }
":"                   { printf("COLON\n"); }
"("                   { printf("LPAREN\n"); }
")"                   { printf("RPAREN\n"); }
"["                   { printf("BRACK\n"); }
"]"                   { printf("RBRACK\n"); }
"{"                   { printf("LBRACE\n"); }
"}"                   { printf("RBRACE\n"); }
"."                   { printf("DOT\n"); }
"+"                   { printf("PLUS\n"); }
"-"                   { printf("MINUS\n"); }
"*"                   { printf("MULT\n"); }
"/"                   { printf("DIVIDE\n"); }
"<"                  { printf("LESSTHEN\n"); }
">"                  { printf("MORETHEN\n"); }
[a-zA-Z][a-zA-Z0-9]*  { printf("ID(%s)\n",yytext); }
.                     { printf("Invalid character(%s).\n",yytext); }

%%

/* TODO: adicionar <=, >=, ==, +=, -= */

#ifndef yywrap
   int yywrap (void) {return 1;}
#endif

int main(void)
{
  yylex();  
  return 0;
}