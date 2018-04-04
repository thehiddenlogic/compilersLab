#include<bits/stdc++.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
using namespace std;
#define MAXN 5
struct symbolTable
{
	char name[50];
	struct symbolTable * next;
};
struct holder
{
	struct symbolTable*tuple;
};
struct blocks
{
	struct holder head[MAXN];
};
stack<blocks>s;
void initialize(blocks *b)
{	
	int i;
	for (i = 0;i<MAXN;i++)
		b->head[i].tuple = NULL;
}

struct symbolTable * createNode(char val[])
{
	struct symbolTable * newnode = (struct symbolTable*)malloc(sizeof(struct symbolTable));
	strcpy(newnode->name,val);
	newnode->next = NULL;
	return newnode;
}
void print(blocks b)
{
	int i;
	for(i=0;i<5;i++)
	{
		struct symbolTable*temp = b.head[i].tuple;
		if(temp)
		{
			cout<<endl;
			if(i == 0)
				cout<<"INTEGER"<<endl;
			if(i == 1)
				cout<<"FLOAT"<<endl;
			if(i == 2)
				cout<<"DOUBLE"<<endl;
		}
		while(temp)
		{
			printf("%s ,",temp->name);
			temp = temp->next;
		}
		//cout<<endl;
	}

}
int search(blocks b,char temp[])
{
	int i;	
	for(i = 0;i<MAXN;i++)
	{	
		struct symbolTable*l = b.head[i].tuple;
		while(l!=NULL)
		{			
			if(strcmp(l->name,temp) == 0)
			{				
				return 1;
			}
			l = l->next;
		}
	}
	return 0;
}

struct symbolTable * insertVal(struct symbolTable*l,char val[])
{	
	struct symbolTable*temp = l;
	if(!temp)
		return createNode(val);
	while(temp->next)
		temp = temp->next;
	temp->next = createNode(val);
	return l;
}

int insert(int type,char val[])
{		
	int flag;		
	if(search(s.top(),val) == 1)
	{		
		flag = 0;
	}	
	else flag = 1;
	if(flag == 0)
	{
		return 0;
	}	
	blocks temp = s.top();
	temp.head[type].tuple = insertVal(temp.head[type].tuple,val);	
	s.pop();
	s.push(temp);
	return 1;
}
void CREATE()
{
	blocks b;
	initialize(&b);
	s.push(b);
}
void DELETE()
{
	if(!s.empty())
	{
		print(s.top());
		s.pop();		
	}
}
