%{
 #include "y.tab.h"
%}
%%
"do"    			 {return DO;}
"while" 			 {return WHILE;}
"for"   			 {return FOR;}
"if"    			 {return IF;}
"else"                           {return ELSE;}
=|<|>|!=|<=|>=|==|&&|"||"|[+-/*]+ {yylval = strdup(yytext);return OP;}
[0-9]+ 				 {yylval = strdup(yytext);return NUM;}
[a-zA-Z_][a-zA-Z0-9_]*           { yylval = strdup(yytext);return ID;}
[ \n\t];
.                                {return *yytext;}
%%
int yywrap(){return 1;}
