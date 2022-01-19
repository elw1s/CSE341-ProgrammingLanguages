%{
#include <stdio.h>
#include "identifiers.h"
int yylex();
void yyerror(const char *s);
%}
// Definitions
%start START
%token IDLIST null OP_PLUS OP_OP OP_CP OP_MINUS OP_DBLMULT OP_MULT OP_DIV OP_OC OP_CC OP_COMMA KW_IF KW_SET KW_DEFFUN KW_AND KW_OR KW_NOT KW_EQUAL KW_LESS KW_NIL KW_LIST KW_APPEND KW_CONCAT KW_FOR KW_EXIT KW_LOAD KW_DISP KW_TRUE KW_FALSE KW_WHILE KW_DEFVAR COMMENT


%union
{
	int value;
	void* values;
	char id[32];
}

%token <value> VALUE
%token <id> IDENTIFIER
%type <value> START
%type <value> INPUT
%type <value> EXPI
%type <value> EXPB
%type <values> EXPLISTI
%type <values> LISTVALUE
%type <values> VALUES
%type <value> BinaryValue

// Rules

%%

START: INPUT {printf("Syntax OK.\nResult: %d\n", $1);}
| START INPUT {printf("Syntax OK.\nResult: %d\n", $2);}
;
INPUT: EXPI | EXPLISTI | COMMENT
;
LISTVALUE:  '\'' OP_OP VALUES OP_CP 
| '\'' OP_OP OP_CP 
| null
;
VALUES: VALUES VALUE | VALUE {$$ = $1;}
;
EXPI: OP_OP OP_PLUS EXPI EXPI OP_CP {$$ = $3 + $4;}
| OP_OP OP_MINUS EXPI EXPI OP_CP {$$ = $3 - $4;}
| OP_OP OP_MULT EXPI EXPI OP_CP {$$ = $3 * $4;}
| OP_OP OP_DIV EXPI EXPI OP_CP {$$ = $3 / $4;}
| IDENTIFIER {Identifier* id = get($1); if (id == NULL) $$ = 0; else $$=id->value;}
| OP_OP IDENTIFIER EXPLISTI OP_CP
| OP_OP KW_SET IDENTIFIER EXPI OP_CP { $$ = $4; put($3, $4); }
| VALUE  {$$ = $1;}
| OP_OP KW_DEFFUN IDENTIFIER IDLIST EXPLISTI OP_CP
| OP_OP KW_IF EXPB EXPLISTI OP_CP { $$ = $3 == 1 ? $4 : 0; }
| OP_OP KW_IF EXPB EXPLISTI EXPLISTI OP_CP { $$ = $3 == 1 ? $4 : $5; }
| OP_OP KW_WHILE OP_OP EXPB OP_CP EXPLISTI OP_CP 
| OP_OP KW_FOR OP_OP IDENTIFIER EXPI EXPI OP_CP EXPLISTI OP_CP
| OP_OP KW_DEFVAR IDENTIFIER EXPI OP_CP { $$ = $4; put($3, $4); }
;
EXPB: OP_OP KW_AND EXPB EXPB OP_CP { $$ = $3 && $4;}
| OP_OP KW_OR EXPB EXPB OP_CP { $$ = $3 || $4; }
| OP_OP KW_NOT EXPB OP_CP { $$ = !$3;}
| OP_OP KW_EQUAL EXPB EXPB OP_CP { $$ = $3 == $4 ? 1 : 0; }
| BinaryValue
;
BinaryValue: KW_TRUE {$$ = 1;}
| KW_FALSE {$$ = 0;}
;
EXPLISTI: OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP | OP_OP KW_APPEND EXPI EXPLISTI OP_CP | LISTVALUE
;
%%
  
void yyerror(const char * s)
/* yacc error handler */
{  
 printf ("SYNTAX_ERROR Expression not recognized.\n");
}
  
int main(void){
 create();
 printf("ENTER AN EXPRESSION: \n>> ");
 yyparse();
 clear();
} 
