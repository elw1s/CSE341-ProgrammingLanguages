%{
#include "gpp_parser.tab.h"
int open = 0;
%}

newline \n
identifier [a-zA-z][a-zA-z0-9]*
comment ;;.*
unsigned_int "0"|[1-9][0-9]*
unsigned_real [1-9]+\.[0-9]+
error_value "0"|[0-9]*|"0"[1-9]*\.[0-9]+ 
%%

{comment} {return COMMENT;}

\( {return OP_OP;}
\) {return OP_CP;}
\+ {return OP_PLUS;}
\- {return OP_MINUS;} 
\* {return OP_MULT;}
\/ {return OP_DIV;} 
\" {    
            if(open==0)
            {
                return OP_OC;
                open=1;
            }             
            else{ 
                return OP_CC;
                open=0;

            }  
        }
\, {return OP_COMMA;}

deffun {return KW_DEFFUN;}
if {return KW_IF;} 
and {return KW_AND;} 
or {return KW_OR;} 
not {return KW_NOT;} 
equal {return KW_EQUAL;} 
less {return KW_LESS;} 
nil {return KW_NIL;} 
list {return KW_LIST;} 
append {return KW_APPEND;} 
concat {return KW_CONCAT;} 
set {return KW_SET;} 
for {return KW_FOR;} 
exit {return KW_EXIT;} 
load {return KW_LOAD;} 
disp {return KW_DISP;} 
true {return KW_TRUE;} 
false {return KW_FALSE;}
while {return KW_WHILE;}
defvar {return KW_DEFVAR;}


{identifier} {strcpy(yylval.id, yytext); return IDENTIFIER;}
{unsigned_real} {yylval.value = atoi(yytext); return VALUE; }
{unsigned_int} {yylval.value = atoi(yytext); return VALUE; }
{error_value}  {
    printf("SYNTAX ERROR! %s cannot be tokenized.\n",yytext);
    exit(1);       
}

{newline} {} /* Print nothing. */


" "  {}
\r {} /* Only for Windows */

.   {
    printf("SYNTAX ERROR! %s cannot be tokenized.\n",yytext);
    exit(1);       
    }

%%

int yywrap() {}

