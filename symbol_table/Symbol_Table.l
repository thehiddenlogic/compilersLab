%{
	#include<stdio.h>
	#include "y.tab.h"	
	#include<string.h>
%}
%%
[ \t\n]+	{}
"{"	{yylval.string = strdup(yytext);return openSet;}
"}"	{yylval.string = strdup(yytext);return closeSet;}
"int"	{yylval.string = strdup(yytext);return INT;}
"float"	{yylval.string = strdup(yytext);return FLOAT;}
"double"	{yylval.string = strdup(yytext);return DOUBLE;}
[a-zA-Z_][a-zA_Z0-9_]*	{yylval.string = strdup(yytext);return var;}
","	{yylval.string = strdup(yytext);return comma;}
";"	{yylval.string = strdup(yytext);return semi_colon;}
%%

