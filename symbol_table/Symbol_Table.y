%{
	#include<stdio.h>
	#include "stc.h"
	#include<bits/stdc++.h>
	using namespace std;
	int yylex();
	int yyerror(const char *);	
	extern char * yytext;
	extern FILE *yyin;
	int i = 1;
%}
%union
{
	char *string;		
}
%type <string> S I LINT LFLOAT LDOUBLE
%token <string> INT var comma semi_colon openSet closeSet FLOAT DOUBLE
%%
	S	:	openSet {CREATE();} I  closeSet {DELETE();cout<<endl<<"End of the block "<<i<<endl;i++;cout<<endl;} I
		|	{}
		;
	I	:	INT var LINT	{
						if(insert(0,$2) == 0)
						{
							yyerror(strcat($2 , " already declared"));
						}
					}				
		|	FLOAT var LFLOAT	{
						if(insert(1,$2) == 0)
						{
							yyerror(strcat($2 , " already declared"));
						}
					}						
		|	DOUBLE var LDOUBLE	{
						if(insert(2,$2) == 0)
						{
							yyerror(strcat($2 , " already declared"));
						}
					}				
		|	S
		;
	LINT:	semi_colon I
		|	comma var	LINT {
							if(insert(0,$2) == 0)
								{
									yyerror(strcat($2 , " already declared"));
								}
						} 
		;
	LFLOAT:	semi_colon I
		|	comma var	LFLOAT {
							if(insert(1,$2) == 0)
								{
									yyerror(strcat($2 , " already declared"));
								}
						} 
	LDOUBLE:	semi_colon I
		|	comma var	LDOUBLE {
							if(insert(2,$2) == 0)
								{
									yyerror(strcat($2 , " already declared"));
								}
						} 		
		;

%%
int yyerror(const char *s)
{
	printf("%s\n",s);
	exit(1);
}
int main()
{	
	//yyin = fopen("in.txt","r");
	//while(!feof(yyin))
		yyparse();	
}
