%{
 #include "y.tab.h"
%}
alpha [A-Za-z]
digit [0-9]
%%
[ \t\n]   
if    	  			 {fprintf(yyout,yytext);return IF;}
else      			 {fprintf(yyout,yytext);return ELSE;}
[0-9]+    			 {fprintf(yyout,yytext);return NUM;}
[A-Za-z]* 			 {fprintf(yyout,yytext);return ID;}
=|<|>|!=|<=|>=|==|&&|"||"|[+-/]+ {fprintf(yyout,yytext);return OPR;}
;				{fprintf(yyout,yytext);return SC; }
[(){}]                             {fprintf(yyout,yytext);return B; }
.    return yytext[0];
%%

