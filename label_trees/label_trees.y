%{
	#include<bits/stdc++.h>	
	using namespace std;
	extern char* yytext;

	typedef struct NODE{
		struct NODE *left, *right;
		char* val;
	} node;

	int currentInstructionNumber = 0;

	int nextInstruction() {
		return currentInstructionNumber++;
	}

	string toString(int n) {
		if(n==0) {
			return "0";
		}
		string x = "";
		while(n) {
			x = x + char(n%10 + 48);
			n/=10;
		}
		reverse(x.begin(),x.end());
		return x;	
	}

	stack<string> st;
	
	node* makeNode(char* val,node* left,node* right) {
		node* newNode = (node *)malloc(sizeof(node));
		newNode->val = val;
		newNode->left = left;
		newNode->right = right;
		return newNode;
	}

	void postOrder(node* root) {
		if(root != NULL) {
			postOrder(root->left);
			postOrder(root->right);
			// cout << root->val << ' ';
			string rootVal = root->val;
			if(rootVal =="+" || rootVal =="-"|| rootVal =="*"|| rootVal=="/") {
				string a = st.top();
				st.pop();
				string b = st.top();
				st.pop();
				string res = "t" + toString(nextInstruction());
				if(rootVal == "+" || rootVal == "*")
				cout << res << " = " << a << rootVal << b << endl;
				else
				cout << res << " = " << b << rootVal << a << endl;
				st.push(res);
			}
			else {
				string x = rootVal;
				st.push(x);
			}
		}
	}

	int label[1000];
	map<node*,int> nodeIntegerMapping;
	int globalValue = 0;
	map<string,string> instructionForOperators;

	void generateId(node* root){
		if(root!=NULL){
			nodeIntegerMapping.insert(make_pair(root,++globalValue));
			generateId(root->left);
			generateId(root->right);
		}
	}

	void generateLabels(node* root) {
		if(root!=NULL) {
			generateLabels(root->left); generateLabels(root->right);
			if(root->left == NULL && root->right == NULL) {
				label[nodeIntegerMapping[root]] = 1;
			}
			else {
				if(label[nodeIntegerMapping[root->left]] != label[nodeIntegerMapping[root->right]]) {
					label[nodeIntegerMapping[root]] = max(label[nodeIntegerMapping[root->left]], label[nodeIntegerMapping[root->right]]);
				}
				else {
					label[nodeIntegerMapping[root]] = label[nodeIntegerMapping[root->left]]+1;
				}
			}
		}
	}

	void generateCode(node* root,int base) {
		if(root!=NULL) {
			if(root->left == NULL && root->right == NULL) {
				cout << "LD R"<<base<<" "<<(string)(root->val)<<endl;
			}
			//not leaf , unequal labels
			else if(label[nodeIntegerMapping[root->left]] != label[nodeIntegerMapping[root->right]]) {
				generateCode(root->right,base);
				generateCode(root->left,base);
				string op = (string)(root->val);
				int one = label[nodeIntegerMapping[root->left]];
				int two = label[nodeIntegerMapping[root->right]];
				int maxi = max(one,two);
				int mini = one + two - maxi;
				cout << instructionForOperators[op] << " R" << base+maxi-1 << " R" <<  base+mini-1 << " R"<<base+maxi-1<<endl;
				
			}
			//not leaf, equal labels
			else {
				generateCode(root->right,base+1);
				generateCode(root->left,base);
				string op = (string)(root->val);
				int k = label[nodeIntegerMapping[root]];
				cout << instructionForOperators[op] << " R" << base+k-1 << " R" <<  base+k-2 << " R"<<base+k-1<<endl;
			}
		}
	}

	void codeGenFromLabelTree(node *root) {
		for(int i=0;i<1000;i++) label[i] = 0;
		instructionForOperators.insert(make_pair("+","ADD"));
		instructionForOperators.insert(make_pair("-","SUB"));
		instructionForOperators.insert(make_pair("*","MUL"));
		instructionForOperators.insert(make_pair("/","DIV"));
		generateId(root);
		generateLabels(root);
		generateCode(root,1);
	}

	void finish_up(char *s) {
		cout<< s << " = " << st.top() << endl;
	}

	int yyerror(char*);
	int yylex();

%}

%token OPEN CLOSE ADD MUL VARIABLE DIV SUB EQ

%type <str> OPEN CLOSE ADD MUL VARIABLE DIV SUB EQ
%type <myNode> E T F ST

%union{
	struct NODE *myNode;
	char *str;
}

%%
ST : VARIABLE EQ E { cout<<"Valid Statement!\n"; codeGenFromLabelTree($3); printf("\n"); };
E : E ADD T {$$=makeNode("+",$1,$3);} | E SUB T {$$=makeNode("-",$1,$3);} | T {$$=$1;};
T : T MUL F {$$=makeNode("*",$1,$3);} | T DIV F {$$=makeNode("/",$1,$3);} | F {$$=$1;};
F : OPEN E CLOSE {$$=$2;}| VARIABLE {$$=makeNode($1,NULL,NULL);};
%%

int yyerror(char* s) {
	printf("There was a %s\n",s);
}

int yywrap() {
	return 1;
}

int main() {
	printf("Enter the exp \n");
	yyparse();


	/*printf("\n***CHECK***\n");
	node* root = makeNode("*" ,NULL, NULL);
	root->left = makeNode("a" ,NULL, NULL);
	root->right = makeNode("b" ,NULL, NULL);
	postOrder(root);*/

	return 0;
}