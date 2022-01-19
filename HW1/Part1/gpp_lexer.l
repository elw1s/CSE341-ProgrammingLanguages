%{
    int open = 0;
%}

newline \n
identifier [a-zA-z][a-zA-z0-9]*
comment ;;.*
unsigned_int "0"|[1-9][0-9]*
unsigned_real [1-9]+\.[0-9]+
error_value "0"|[0-9]*|"0"[1-9]*\.[0-9]+ 
%%

{comment} {printf("COMMENT\n");}

\( {printf("OP_OP\n");}
\) {printf("OP_CP\n");}
\+ {printf("OP_PLUS\n");}
\- {printf("OP_MINUS\n");} 
\** {printf("OP_DBLMULT\n");}
\* {printf("OP_MULT\n");}
\/ {printf("OP_DIV\n");} 
\" {    
            if(open==0)
            {
                printf("OP_OC\n");
                open=1;
            }             
            else{ 
                printf("OP_CC\n");
                open=0;

            }  
        }
\, {printf("OP_COMMA\n");}

deffun {printf("KW_DEFFUN\n");}
if {printf("KW_IF\n");} 
and {printf("KW_AND\n");} 
or {printf("KW_OR\n");} 
not {printf("KW_NOT\n");} 
equal {printf("KW_EQUAL\n");} 
less {printf("KW_LESS\n");} 
nil {printf("KW_NIL\n");} 
list {printf("KW_LIST\n");} 
append {printf("KW_APPEND\n");} 
concat {printf("KW_CONCAT\n");} 
set {printf("KW_SET\n");} 
for {printf("KW_FOR\n");} 
exit {printf("KW_EXIT\n"); exit(0);} 
load {printf("KW_LOAD\n");} 
disp {printf("KW_DISP\n");} 
true {printf("KW_TRUE\n");} 
false {printf("KW_FALSE\n");}


{identifier} {printf("IDENTIFIER\n");}
{unsigned_real} {printf("VALUE\n");}
{unsigned_int} {printf("VALUE\n");}
{error_value}  {
    printf("SYNTAX ERROR! %s cannot be tokenized.\n",yytext);
    exit(1);       
    }

{newline} {printf("");} /* Print nothing. */


" "  {}
\r {printf("");} /* Only for Windows */

.   {
    printf("SYNTAX ERROR! %s cannot be tokenized.\n",yytext);
    exit(1);       
    }

%%

yywrap() {}

int main(int argc, char *argv[])
{
    printf("\n\n\nFLEX PROGRAM\n\n");
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
