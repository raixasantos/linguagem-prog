%{
  #include <stdio.h>  
  #include "y.tab.h"
  
  extern int yyerror (char *msg);  
%}

%%

[ \t\n]               ;
[0-9]+                { yylval.iValue = atoi(yytext); 
                        return NUMBER; }
"begin"               { return(BEGIN_BLOCK); }
"end"                 { return(END_BLOCK); }
"main"                { return(MAIN_BLOCK); }
"int"                 {yylval.sValue = strdup("int"); 
                        return TYPE;}
"float"               {yylval.sValue = strdup("float"); 
                        return TYPE;}
"bool"                {yylval.sValue = strdup("bool"); 
                        return TYPE;}
"string"              {yylval.sValue = strdup("string"); 
                        return TYPE;}
"concat"              { return(CONCAT); }
"lenght"              { return(LENGHT); }
"and"                 { return(AND); }
"or"                  { return(OR); }
"not"                 { return(NOT); }
"while"               { return(WHILE); }
"in"                  { return(IN); }
"do"                  { return(DO); }
"for"                 { return(FOR); }
"switch"              { return(SWITCH); }
"case"                { return(CASE); }
"break"               { return(BREAK); }
"continue"            { return(CONTINUE); }
"function"            { return(FUNCTION); }
"procedure"           { return(PROCEDURE); }
"if"                  { return(IF); }
"then"                { return(THEN); }
"else"                { return(ELSE); }
"return"              { return(RETURN); }
"print"               { return(PRINT); }
"input"               { return(INPUT); }
";"                   { return(SEMICOLON); }
"<="                  { return(LESSTHENEQ); }
">="                  { return(MORETHENEQ); }
"<"                   { return(LESSTHEN); }
">"                   { return(MORETHEN); }
"+="                  { return(MOREISEQUAL); }
"-="                  { return(LESSISEQUAL); }
"=="                  { return(ISEQUAL); }
"++"                  { return(INCREMENT); }
"--"                  { return(DECREMENT); }
"="                   { return(ASSIGNMENT); }
","                   { return(COMMA); }
":"                   { return(COLON); }
"("                   { return(LPAREN); }
")"                   { return(RPAREN); }
"["                   { return(LBRACK); }
"]"                   { return(RBRACK); }
"{"                   { return(LBRACE); }
"}"                   { return(RBRACE); }
"."                   { return(DOT); }
"+"                   { return(PLUS); }
"-"                   { return(MINUS); }
"*"                   { return(MULTIP); }
"/"                   { return(DIVIDE); }
"%"                   { return(MOD); }
\"(\\.|[^"\\])*\"     { return(QUOT); }
[a-zA-Z][a-zA-Z0-9]*	{yylval.sValue = strdup(yytext); 
                       return ID;}
.                     { yyerror("invalid character"); }

%%

#ifndef yywrap
   int yywrap (void) {return 1;}
#endif