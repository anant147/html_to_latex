%{

void yyerror(const char *);
int yylex(void);

#include<iostream>
#include<stdio.h>
#include<cstring>
#include<ctype.h>
using namespace std;
#include "header.h"
#include <fstream>
using std::ofstream;


extern FILE *yyin;

FILE  *out,*outfile;

int rows=0;
int cells=0;
string imght="";
string imgsrc="";
string imgwth="";
 //string ahref="";
string aname="";
string atitle="";
int tableborder=0;
string ahref="";
string ll="";
string ll1="";

%}


%union
{
 char *s;
 int i;
 struct node *nod;
};



%token     DOCTYPE DOCINFO METADATA
%token <s> HTST HDST TITST BDST PRST DVST
%token <s> HTED HDED TITED BDED PRED DVED
%token <s> H1S H2S H3S H4S H5S H6S           /*HEADING STARTINGS*/
%token <s> H1E H2E H3E H4E H5E H6E          /*HEADING ENDINGS*/

%token <s> TEXT CENTERS CENTERE BRS COMMENTS
%token <s> AS AHREF ANAME ATITLE AE     /* a tag*/
%token <s> FONTS FONTSIZES FONTE        /* font tab */
%token <s> IMGS IMGSRC IMGHEIGHT IMGWIDTH IMGALT  /* image tag */
%token <s> FIGURES FIGUREE FIGCAPTIONS FIGCAPTIONE   /* figure tag */

%token <s> ULS LIS OLS DLS DTS DDS        /*LISTING STARTINGS*/
%token <s> ULE LIE OLE DLE DTE DDE        /*LISTING ENDINGS*/

%token <s> TABLES TABLEBORDER  TRS THS TDS CAPTIONS /* TABLE STARTINGS*/
%token <s> TABLEE TRE THE TDE CAPTIONE /* TABLE ENDINGS*/

%token <s> US BS IS EMS TTS STRONGS SMALLS SUBS SUPS  /* TEXTSTYLE STARTINGS*/
%token <s> UE BE IE EME TTE STRONGE SMALLE SUBE SUPE GKSYM /* TEXTSTYLE ENDINGS*/


%token <s> ST ED SLH WORD INT 


%type <nod> htlst
%type <nod>  head body content1 doctype content2 div paragraph textstyle content3 heading center break tabling content4 trh trd trd1 th th1 td td1 caption listing list list1 dt dd li ul dl ol figure image figcaption   font  imagecontent  tb alink  acontent
 
 

%%



htlst :  doctype HTST head body HTED         {
                                             struct node *k=makenode();
                                             k->i=1;
                                             k->children.push_back(newstr("\\documentclass{article} \n "));
                                             k->children.push_back(newstr("\\usepackage{hyperref} \n "));
                                             k->children.push_back(newstr("\\usepackage{graphicx} \n "));
                                             k->children.push_back($3);
                                             k->children.push_back($4);
                                             $$=k; cout<<"start"<<endl;
                                             
                                             ll1+= traverse_main($$);
                                             cout<<"start1"<<endl;

                                             
                                       
                                             
                                            }

           | HTST head body HTED             {
                                             struct node * k=makenode();
                                             k->i=1;
                                             k->children.push_back(newstr("\\documentclass{article} \n"));
                                             k->children.push_back(newstr("\\usepackage{hyperref} \n "));
                                             k->children.push_back(newstr("\\usepackage{graphicx} \n "));
                                             k->children.push_back($2);
                                             k->children.push_back($3);
                                             
                                             $$=k;
                                             ll1+=traverse_main($$);// cout<<"value of ll is "<<ll<<endl;
                                             
                                           }
                            
doctype : DOCTYPE DOCINFO             {}                              
      | DOCTYPE                     {}


head : HDST content1 HDED {                  struct node * k=makenode();
                                             k->i=1;
                                             k->children.push_back($2);
                                             $$=k;
                          } 
      | HDST METADATA content1 HDED  {
                                             struct node * k=makenode();
                                             k->i=1;
                                             k->children.push_back($3);
                                             $$=k;
                                      }                   
                     
content1:TITST WORD TITED {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr("\\title{"));
                                        k->children.push_back(newstr($2));
                                        k->children.push_back(newstr("}\n"));
                                        $$=k;    
                          
                          }
                          
body:BDST content2 BDED    {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr("\\begin{document} \n "));
                                        k->children.push_back(newstr("\\maketitle \n "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr("\\end{document} \n"));
                                        $$=k;
                          
                             }

   
                             
                           

content2:  content2 paragraph    {     struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                            
                          
                           }
                           
          | content2  div   {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                           }
                           
         | content2 textstyle  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                                         
                          
                           } 
                           
         | content2 tabling  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }  
                           
        | content2 listing  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
                           
        | content2 figure {
                            
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                           }                                                                             

                         
                                 
        | paragraph        {            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        
                                        $$=k;
                            
                          
                           }
        | div               {           struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                            
                          
                           }
         
         | textstyle          {           struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;  cout<<"tttoo"<<endl;
                            
                          
                           }        
                           
         | tabling          {           struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                            
                          
                           } 
                           
          | listing          {           struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                            
                          
                           }
         
         | figure          {           struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                            
                          
                           }                  
                                                                      
                           
        
div : DVST  content2 DVED      {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\par  "));
                                        k->children.push_back($2);
                                       
                                        $$=k;
                          
                           }
           | DVST   DVED      {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\par  "));
                                       
                                        $$=k;
                           }   
                           
                        
                           
paragraph : PRST content2 PRED {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\par "));
                                        k->children.push_back($2);
                                        
                                        $$=k;
                                     
                           } 
           | PRST  PRED {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\par "));
                                        $$=k;
                                     
                           }  
            

                           
                           
heading : H1S content3 H1E           {
                                            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\section{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }"));
                                        $$=k;
                          
                             }
                             
     | H2S content3 H2E           {
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\subsection{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }"));
                                        $$=k;
                             }                             
                             
   | H3S content3  H3E           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\subsubsection{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }"));
                                        $$=k;
                          
                             }                                                                    
                                                                           
   | H4S content3  H4E           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" {\\Large "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }"));
                                        $$=k;
                          
                             }  
   
                             
                                
                             
tabling : TABLES content4 TABLEE {
                                        struct node *k=makenode();
                                       
                                        
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{tabular} "));
                                        
                                        int val=cells/rows;string m="";
                                        
                                        if(tableborder==0)
                                        {
                                         m=m+"{ ";
                                        for(int i=1;i<=val;i++)
                                        m=m+"c ";
                                        
                                        m=m+"}";
                                         }
                                         else
                                         {
                                           m=m+"{ |";
                                        for(int i=1;i<=val;i++)
                                        m=m+"c |";
                                        
                                        m=m+"}"; 
                                          }

                                        k->children.push_back(newstr(m)); 
                                        k->children.push_back($2);
                                        if(tableborder==1)k->children.push_back(newstr(" \\hline "));
                                        
                                        
                                        k->children.push_back(newstr(" \\end{tabular} \\newline "));
                                        rows=0;cells=0;tableborder=0;
                                        $$=k;
                                           
                          
                           }
         
        
         
       /* | TABLES TABLEBORDER content4 TABLEE  {
                                                cout<<"here first";
                                          struct node *k=makenode();
                                        k->i=1;
                                        string m="";
                                        k->children.push_back(newstr(" \\begin{tabular} "));

                                        if($2[0]=='1')
                                        {
                                
                                        tableborder=1;
                                        int val=cells/rows;

                                        m="{ |";
                                        for(int i=1;i<=val;i++)
                                        m=m+"c |";
                                        
                                        m=m+"}"; 
                                        }
                                        else 
                                        { int val=cells/rows; 
                                         m="{ "; 
                                        for(int i=1;i<=val;i++)
                                        m=m+"c ";
                                        
                                        m=m+"}";
                                        tableborder=0;
                                         }
                                        
                                        k->children.push_back(newstr(m));
                                        k->children.push_back($3);
                                        rows=0;cells=0;

                                        if(tableborder==1)
                                        k->children.push_back(newstr(" \\hline "));
                                        k->children.push_back(newstr(" \\end{tabular} \\newline "));
                                        
                                        $$=k;
                                              
                                          } 
                       */

   
                                              
                           
content4 : tb caption trh trd {
                                        struct node *k=makenode();

                                        k->i=1;

                                        k->children.push_back($2);
                                        k->children.push_back($3);
                                        k->children.push_back($4);
                                        $$=k;
                          
                           }
           |  caption trh trd {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        k->children.push_back($3);

                                        $$=k;
                          
                           }
           
          | tb trh trd         {  
                                    
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($2);
                                        k->children.push_back($3);
                                        $$=k;
                          
                           }
           
         | trh trd         {             
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }

          | tb trd     {            
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($2);
                                        $$=k;
                          
                                 }

          | trd            {      
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }

tb : TABLEBORDER                  {
                                        if($1[0]=='1')
                                        tableborder=1;
                                        else
                                        tableborder=0;
                                  }           
                           
caption : CAPTIONS content3 CAPTIONE  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\center{\\caption{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }}"));
                                        $$=k;
                          
                           }

trh : TRS th TRE             {      
                                        struct node *k=makenode();
                                        k->i=1; rows++;
                                        if(tableborder==1)
                                        k->children.push_back(newstr(" \\hline "));

                                        k->children.push_back($2);
                                        k->children.push_back(newstr("\\\\ "));
                                        
                                        
                                        $$=k;
                          
                           }
                           
th : th th1                {
                                        struct node *k=makenode();
                                        k->i=1; 
                                        k->children.push_back($1);
                                        k->children.push_back(newstr(" & "));
                                        k->children.push_back($2);
                                        $$=k;  
                          
                           }           
    | th1                   {
                                            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           } 
  
                           
th1 : THS content3  THE        {
                                        
                                        struct node *k=makenode();
                                        k->i=1; cells++;
                                       
                                        k->children.push_back($2);
                                       
                                        $$=k;
                          
                           }                                                        
             
trd : trd trd1             {
                                        struct node *k=makenode();
                                        k->i=1;
                                        
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
      | trd1                {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;  
                          
                           }  
                      

trd1 : TRS td TRE          {
                                        struct node *k=makenode();
                                        k->i=1; rows++;
                                       if(tableborder==1)
                                       k->children.push_back(newstr(" \\hline "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" \\\\ "));
                                        
                                        
                                        $$=k;
                          
                           }  
                          
td : td td1                {
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back(newstr(" & "));
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
     | td1                 {
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }
  
                           
td1 : TDS content3 TDE          {
                                        struct node *k=makenode();
                                        k->i=1; cells++;
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }  
                                                    
                           

listing : ul               {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k; 
                          
                           } 
                                        
         | dl               {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }
                           
         | ol               {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k; 
                          
                           }
                           
        

ul: ULS list ULE           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{itemize} "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" \\end{itemize} "));
                                        $$=k;
                          
                           } 
                           
ol: OLS list OLE           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{enumerate} "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" \\end{enumerate} "));
                                        $$=k;
                           }
                           
dl: DLS list1 DLE           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{description} "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" \\end{description} "));
                                        $$=k;
                        
                           }    
                           
list : list li            {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
     | list ul            {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
                                                   
     | list ol            {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }
     | list dl            {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }                                                                                                                               
     | li                  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }
     | ul                  {
                                          struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k; 
                          
                           }
                           
     | dl                  {
                                            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }
                           
     | ol                  {
                                       struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k; 
                          
                           }  
   
                           
                                                    
li : LIS content3  LIE         {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\item "));
                                        k->children.push_back($2);
                                       
                                        $$=k;
                          
                           }    
                           
list1 : list1 dt           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;  
                          
                           }
                           
       | list1 dd          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                            
                          
                           }

       | list1 ol          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                            
                          
                           }
           
        | list1 ul          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                            
                          
                           }
                           
       | list1 dl          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2);
                                        $$=k;
                            
                          
                           }

       | dt                {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                          
                           }
                           
       | dd                {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                                    
                           }

        | ol               {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                                    
                           }
        | ul                {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                                    
                           }
         | dl                {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        $$=k;
                                    
                           }

       
      
                           
dt: DTS content3  DTE           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\item[ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" ] "));
                                        $$=k;
                                        
                           } 
                                                                                                                                
                               
dd : DDS content3  DDE            {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($2);
                                        $$=k;
                          
                           }  

 

content3 : content3 textstyle          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1);
                                        k->children.push_back($2); 
                                        $$=k;
                          
                                        }
          | textstyle                   {
                                         struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back($1); 
                                        $$=k;
                          
                                        }                           
                           
                           
textstyle:   US content3  UE             {
                                            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\underline{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                          
                                       }

            | BS content3  BE              {
                                            struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\textbf{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                          
                                           } 
            | IS content3  IE              {
                                              struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\textit{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                                            } 


            | EMS content3  EME          {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\emph{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                                          
                                          } 


            | TTS content3  TTE           {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\texttt{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                                            } 

          | STRONGS content3  STRONGE  {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\emph{\\textbf{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }} "));
                                        $$=k;
                          
                                        } 

            | SMALLS content3  SMALLE   {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\small{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                                          } 

             | SUBS content3  SUBE          {
                            
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" $_{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }$ "));
                                        $$=k;
                                             } 

             | SUPS content3 SUPE         {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" $^{ "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" }$ "));
                                        $$=k;
                                           } 
                                           
             | WORD                        {
                                             struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back(newstr($1)); 
                                            $$=k;
                                             }

             
                                            
                                             
            | heading          {
                                            struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back($1);
                                            $$=k;
                          
                           }
                           
           | center          {
                                            struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back($1);
                                            $$=k;
                          
                           }
                           
          | break            {
                                            struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back($1);
                                            $$=k;
                             }      
                             
                          
                             
         | alink                  {
                                           struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back($1);
                                            cout<<"h7"<<endl;
                                            $$=k;cout<<"h8"<<endl;
                                  }

          
         | font                     {
                                            struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back($1);
                                            $$=k;
                                    } 
         
                                    
                                             
                         
center : CENTERS content2 CENTERE    {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{center} "));
                                        k->children.push_back($2);
                                        k->children.push_back(newstr(" \\end{center} "));
                                        $$=k;
                                }
      | CENTERS  CENTERE    {
                                        struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{center} "));
                                        k->children.push_back(newstr(" \\end{center} "));
                                        $$=k;
                                }    
                                
break :   BRS                   {
                                            struct node *k=makenode();
                                            k->i=1;
                                            k->children.push_back(newstr(" \\newline "));
                                            $$=k;
                                
                                } 
                                
                            
                                
font :FONTS FONTSIZES content3 FONTE {
                                            struct node *k=makenode();
                                        k->i=1;
                                        if($2[0]=='1') 
                                        k->children.push_back(newstr(" {\\footnotesize "));
                                        else if($2[0]=='2')
                                        k->children.push_back(newstr(" {\\small "));
                                        else if($2[0]=='3')
                                        k->children.push_back(newstr(" {\\normalsize "));
                                        else if($2[0]=='4')
                                        k->children.push_back(newstr(" {\\large "));
                                        else if($2[0]=='5')
                                        k->children.push_back(newstr(" {\\Large "));
                                        else if($2[0]=='6')
                                        k->children.push_back(newstr(" {\\LARGE "));
                                        else
                                        k->children.push_back(newstr(" {\\huge "));
 
                                        
                                        k->children.push_back($3);
                                        k->children.push_back(newstr(" } "));
                                        $$=k;
                                 
                                  }                                    
                                
                               

figure : FIGURES image figcaption FIGUREE {
                                                struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{figure} "));
                                        k->children.push_back($2);
                                        k->children.push_back($3);
                                        k->children.push_back(newstr(" \\end{figure} "));
                                        $$=k;
                                               
                                               } 

       | FIGURES figcaption image FIGUREE {
                                               struct node *k=makenode();
                                        k->i=1;
                                        k->children.push_back(newstr(" \\begin{figure} "));
                                        k->children.push_back($2);
                                        k->children.push_back($3);
                                        k->children.push_back(newstr(" \\end{figure} "));
                                        $$=k;
                                               
                                               }                                        
       | FIGURES image FIGUREE                 {
                                                  struct node *k=makenode();
                                                  k->i=1;
                                                  k->children.push_back(newstr(" \\begin{figure} "));
                                                  k->children.push_back($2);
                                                  k->children.push_back(newstr(" \\end{figure} "));
                                                  $$=k;
                                                
                                               }                       
       
        | image                                {
                                                struct node *k=makenode();
                                                  k->i=1;
                                                  k->children.push_back($1);
                                               
                                               } 
                                               
                                            
                                               
alink :  AS acontent content3 AE            {
                                                  struct node *k=makenode();
                                                  k->i=1;
                                                   
                                                  k->children.push_back(newstr(" \\href"));
                                                  string m="";
                                                  
                                                  if(ahref!="")
                                                  {
                                                  m="{"+ahref+"}"; cout<<m<<endl;
                                                  k->children.push_back(newstr(m)); 
                                                  }
                                                 
                                                  string o="";
                                                  
                                                  if(aname.size()!=0)
                                                  {
                                                  string o=" \\label{"+aname+"}";
                                                  k->children.push_back(newstr(o)); 
                                                  }
                                                  
                                                   
                                                  
                                                  k->children.push_back(newstr("{"));
                                                  k->children.push_back($3);
                                                  k->children.push_back(newstr(" } "));
                                                   cout<<"h5"<<endl; aname="";atitle="";ahref="";
                                                  
                                                  $$=k;
                                
                                  } 
                                  
                                  
       | AS acontent AE            {
                                                  struct node *k=makenode();
                                                  k->i=1;
                                                  k->children.push_back(newstr(" \\href"));  
                                                  string m="";
                                                  string o="";
                                                  
                                                  if(aname.size()!=0)
                                                  {
                                                  string o=" \\label{"+aname+"}";
                                                  k->children.push_back(newstr(o));
                                                  }
                                                  
                                                  if(ahref.size()!=0)
                                                  {
                                                  m="{"+ahref+"}";
                                                  k->children.push_back(newstr(m));
                                                  }
                                                   
                                                  aname="";atitle="";ahref="";  
                                                
                                  }

                       
       | AS AE                   {
                                  }
       AS content3 AE               {
                                                  
                                  } 
                              
                              
       
                                  
acontent  :acontent AHREF       {
                                     string str($2);
                                       ahref=str;        
                                
                                  } 
          | AHREF                {
					
					string str($1);
                                       ahref=str; 
					 
                                 
                                  } 
                                  
           | acontent ANAME       {
                                       aname=string($2);              
                                 
                                  }        
          | acontent ATITLE      {
                                        atitle=string($2);                   
                                 
                                  }                                          
          
          | ANAME               {
                                          aname=string($1); 
                                 
                                  } 
          | ATITLE                {
                                           atitle=string($1); 
                                 
                                  } 
  
                                  
                                                                                    
                                                           
figcaption :FIGCAPTIONS content3 FIGCAPTIONE         {
                                                           struct node *k=makenode();
                                                            k->i=1;
                                                            k->children.push_back(newstr(" \\caption{"));
                                                            k->children.push_back($2);
                                                            k->children.push_back(newstr(" } "));
                                                            $$=k; 
                                                          }             
                                                          

image : IMGS imagecontent                      {
                                                 string j= "\\newline \\includegraphics"; string m=""; string p="";
                                                 
                                                 if(imght!="" && imgwth!="")
                                                 {
                                                 m="[width="+imgwth+"px, height="+imght+"px]"; 
                                                 }
                                                 else if(imght!="")
                                                  m="[height="+imght+"px]";
                                                 else if(imgwth!="")
                                                 m="[width="+imgwth+"px]";
                                                
                                                 
                                                 
                                                 if(imgsrc.size()!=0)
                                                  p="{"+imgsrc+"}";
                                                
                                                 
                                                 
                                                 j=j+m+p;
                                                 
                                                 imgsrc="";imght="";imgwth="";
                                                 
                                                 struct node *k=makenode();
                                                 k->i=1; 
                                                 k->children.push_back(newstr(j));
                                                 $$=k;
                                                 
                                                 }
                                                 
                                               
                                               
imagecontent :imagecontent IMGSRC              {
                                               imgsrc=string($2);
                                               }
             
                                              
                                              
            | imagecontent IMGHEIGHT              {
                                              imght=string($2);
                                              
                                              }         
            
            
            | imagecontent IMGWIDTH              {
                                                 imgwth=string($2);  
                                              }     
                                              
                                                
             | IMGSRC                        {
                                              imgsrc=string($1);
                                              }
               
                                              
             | IMGHEIGHT                         {
                                                  
                                              imght=string($1);
                                              
                                              }      
                                              
             | IMGWIDTH                         {
                                                  
                                              imgwth=string($1);
                                              
                                              }                                                                                                       
                                              
                                              
                                                                                                                                                                                                                           
                            
  

%%


void yyerror(const char *msg)
{
printf("Error:");
cout<<msg<<endl; 
}

int main(int argc,char* argv[])
{

yyin = fopen(argv[1],"r");

ofstream out(argv[2]);

cout<<ll<<endl;

if(yyin==NULL)
{printf("Cannot open file");return 0;}

yyparse();
out<<ll1;
return 0;


} 

















