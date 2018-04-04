%{
	#include<stdio.h>
	#include "y.tab.h"
%}


%%
"(" 						yylval.str=strdup(yytext);return OPEN;
")" 						yylval.str=strdup(yytext);return CLOSE;
"+"							yylval.str=strdup(yytext);return ADD;
"="							yylval.str=strdup(yytext);return EQ;
"*"							yylval.str=strdup(yytext);return MUL;
"-" 						yylval.str=strdup(yytext);return SUB;	
"/" 						yylval.str=strdup(yytext);return DIV;
[a-zA-Z][0-9A-Za-z]*		yylval.str=strdup(yytext);return VARIABLE;
\n        					/*ignore*/  ;  
[ \t]+    					/*ignore*/   ;
. 							;
%%