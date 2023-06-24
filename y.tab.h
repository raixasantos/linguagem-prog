/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    TYPE = 259,
    CONCAT = 260,
    LENGHT = 261,
    AND = 262,
    OR = 263,
    NOT = 264,
    WHILE = 265,
    IN = 266,
    DO = 267,
    FOR = 268,
    SWITCH = 269,
    CASE = 270,
    BREAK = 271,
    CONTINUE = 272,
    RETURN = 273,
    PRINT = 274,
    INPUT = 275,
    NUMBER = 276,
    FUNCTION = 277,
    PROCEDURE = 278,
    BEGIN_BLOCK = 279,
    END_BLOCK = 280,
    MAIN_BLOCK = 281,
    IF = 282,
    THEN = 283,
    ELSE = 284,
    LPAREN = 285,
    RPAREN = 286,
    COLON = 287,
    SEMICOLON = 288,
    COMMA = 289,
    LESSTHENEQ = 290,
    MORETHENEQ = 291,
    LESSTHEN = 292,
    MORETHEN = 293,
    MOREISEQUAL = 294,
    LESSISEQUAL = 295,
    ISEQUAL = 296,
    INCREMENT = 297,
    DECREMENT = 298,
    ASSIGNMENT = 299,
    LBRACK = 300,
    RBRACK = 301,
    LBRACE = 302,
    RBRACE = 303,
    DOT = 304,
    PLUS = 305,
    MINUS = 306,
    MULTIP = 307,
    DIVIDE = 308,
    MOD = 309,
    QUOT = 310
  };
#endif
/* Tokens.  */
#define ID 258
#define TYPE 259
#define CONCAT 260
#define LENGHT 261
#define AND 262
#define OR 263
#define NOT 264
#define WHILE 265
#define IN 266
#define DO 267
#define FOR 268
#define SWITCH 269
#define CASE 270
#define BREAK 271
#define CONTINUE 272
#define RETURN 273
#define PRINT 274
#define INPUT 275
#define NUMBER 276
#define FUNCTION 277
#define PROCEDURE 278
#define BEGIN_BLOCK 279
#define END_BLOCK 280
#define MAIN_BLOCK 281
#define IF 282
#define THEN 283
#define ELSE 284
#define LPAREN 285
#define RPAREN 286
#define COLON 287
#define SEMICOLON 288
#define COMMA 289
#define LESSTHENEQ 290
#define MORETHENEQ 291
#define LESSTHEN 292
#define MORETHEN 293
#define MOREISEQUAL 294
#define LESSISEQUAL 295
#define ISEQUAL 296
#define INCREMENT 297
#define DECREMENT 298
#define ASSIGNMENT 299
#define LBRACK 300
#define RBRACK 301
#define LBRACE 302
#define RBRACE 303
#define DOT 304
#define PLUS 305
#define MINUS 306
#define MULTIP 307
#define DIVIDE 308
#define MOD 309
#define QUOT 310

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 17 "parser.y"

	int    iValue; 	/* integer value */
	char   cValue; 	/* char value */
	char * sValue;  /* string value */
      struct record * rec;

#line 174 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
