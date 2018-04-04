token IF ELSE OP CL OB CB TEXT SC UNR
%{
	#include<stdio.h>
	extern char *yytext;
%}
%%
start : s {printf("Accepted\n");}
s:	TEXT
| IF OP TEXT CL OB s CB t	
|
;
t: 	ELSE OB s CB s | s;
%%
#include "lex.yy.c"
int yyerror(char *s)
{
	printf("%s",s);
}
int main(void)
{
	yyparse();
}
