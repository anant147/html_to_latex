#include<iostream>
#include<stdio.h>
#include<cstring>
#include<ctype.h>
#include<vector>
#include<queue>
#include <fstream>
using std::ofstream;

extern string ll;


typedef struct node
{
 int i;
 vector <node *> children;
 string data;
 
}node;


 node *makenode()
{
 node *temp=new node;
 return temp;
}

 node *newstr(string k)
{
  node *temp=makenode();
 temp->i=2;
 temp->data=k;
 return temp;
}

void traverse(node *k)
{
 if((k->i)==2)
  {
  cout<<k->data<<endl; 
  ll = ll+ k->data ;
  }
   if((k->i)==1)
   {
  for(int j=0;j < k->children.size(); j++)
  {
   traverse(k->children[j]);
   }
   }
}

string traverse_main(node *k)
{
	string s="";
	traverse(k);
	return ll;

}










