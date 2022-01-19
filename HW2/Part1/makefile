target: test

test: 
		flex gpp_lexer.l && bison gpp_parser.y && cc lex.yy.c gpp_parser.tab.c -ll && ./a.out