%{
#include<stdio.h>
#include<string.h>
FILE* yyin;
FILE* fp;
char temp[100];
char temp1[100];
char temp2[100];
char temp3[100];
char temp4[100];
char exp[100];
extern char* yytext;
%}

%token DO WHILE FOR IF ELSE OP ID NUM

%%
start     : s {printf("valid");};
s         : for s   
          | while s 
          | do s 
          |'@'
          ;
          
for       : FOR OB E1 SC E2 SC E3 CB  block   
          ;
E1        : E {strcpy(temp,(char*)$1);fprintf(fp,"%s\n",temp);}
          ;
E2	  : E {strcpy(temp,(char*)$1);fprintf(fp,"while(%s)\n",temp);}
	  ;
E3	  : E {strcpy(temp,(char*)$1);fprintf(fp,"{%s}\n",temp);}
	  ;

while     : WHILE OB E CB block {strcpy(temp1,(char*)$3);printf("Here %s",$3);fprintf(fp,"while(%s){}\n",temp1);}
          ;
          
do        : DO block WHILE OB E CB SC {strcpy(temp4,(char*)$5);printf("%s",temp4);fprintf(fp,"while(%s){}\n",temp4);}
          ;

block     : '{' stmt_list '}'	
          | block
          ;
stmt_list : stmt_list stmt
          | stmt
          ;
stmt      : E ';'
          |
          ;
E         : E OPR E {strcpy(exp,"");strcat(exp,(char*)$1);strcat(exp,(char*)$2);strcat(exp,(char*)$3);$$=exp;}
	  | ID {$$ = $1;}
          | NUM {$$ = $1;}
	  ;
OPR:	  OP {$$ = $1;}
	  ;
SC        : ';'
          ;
OB	  : '('
          ;
CB        : ')'
          ;
%%
main()
{
 yyin = fopen("input.txt","r");
 fp = fopen("output.txt","w");
 yyparse();
}
yyerror(char* s){
  printf("invalid syntax");
}

void convert_for(char* a,char* b,char*c)
{
   fprintf(fp,"\n%s\n",a);
   fprintf(fp,"while(%s)\n",b);
   fprintf(fp,"{%s}",c);
 }


