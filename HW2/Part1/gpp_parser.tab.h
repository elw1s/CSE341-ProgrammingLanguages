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

#ifndef YY_YY_GPP_PARSER_TAB_H_INCLUDED
# define YY_YY_GPP_PARSER_TAB_H_INCLUDED
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
    IDLIST = 258,
    null = 259,
    OP_PLUS = 260,
    OP_OP = 261,
    OP_CP = 262,
    OP_MINUS = 263,
    OP_DBLMULT = 264,
    OP_MULT = 265,
    OP_DIV = 266,
    OP_OC = 267,
    OP_CC = 268,
    OP_COMMA = 269,
    KW_IF = 270,
    KW_SET = 271,
    KW_DEFFUN = 272,
    KW_AND = 273,
    KW_OR = 274,
    KW_NOT = 275,
    KW_EQUAL = 276,
    KW_LESS = 277,
    KW_NIL = 278,
    KW_LIST = 279,
    KW_APPEND = 280,
    KW_CONCAT = 281,
    KW_FOR = 282,
    KW_EXIT = 283,
    KW_LOAD = 284,
    KW_DISP = 285,
    KW_TRUE = 286,
    KW_FALSE = 287,
    KW_WHILE = 288,
    KW_DEFVAR = 289,
    COMMENT = 290,
    VALUE = 291,
    IDENTIFIER = 292
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 13 "gpp_parser.y"

	int value;
	void* values;
	char id[32];

#line 101 "gpp_parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GPP_PARSER_TAB_H_INCLUDED  */
