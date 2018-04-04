%{
#include <stdio.h>
#include <stdlib.h>
extern FILE* yyout;
%}
%token ID NUM IF ELSE  SC OPR B
%%

S      	: ST {printf("Input accepted.\n");exit(0);};
ST      : IF B E B ST1 ELSE ST1
        | IF B E B ST1 {fprintf(yyout,"else{}");}
	|
        ;
ST1  	: B ST1 B {printf("here");}
	| ST
        | E SC
        ;
E    	: E OPR E
        | ID
        | NUM
        ;

%%
int main()
{
  yyout = fopen("out.txt","w");
  yyparse();

}
void yyerror(char* s){
 
} 


