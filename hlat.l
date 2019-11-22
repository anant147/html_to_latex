%{



#include<iostream>
#include<stdio.h>
#include<cstring>
#include<ctype.h>
using namespace std;
#include"makeast.tab.h"
%}

symbol     (\.|\,|\;|\\|\:|\'|\?|\!|\/|\~|\(|\)|\`|\\|\_|\')
special    (\/|\&|\@|\#|\^|\%|\{|\}|\$|\=|\+|\-|\*)
spac	   [ \t]+
newline    [\n]

word       (([a-zA-Z0-9]|{spac}|{symbol}|{special})+[\n]*)*([a-zA-Z0-9]|{symbol}|{spac}|{special})+   
mainsym      (\<|\>|\\|\") 



%x A_ATR
%x F_ATR
%x T_ATR
%x IMG_ATR
%x CMENT
%x DOCT
%x META



%%
[ \t\n]*               ;
  

"<!DOCTYPE HTML"[ ]*                        {   BEGIN(DOCT);  return DOCTYPE;
                                            }

"<!DOCTYPE html"[ ]                          { BEGIN(DOCT);  return DOCTYPE;}

<DOCT>"PUBLIC \""([A-Za-z0-9]|{symbol}|[\t])+[\"]  { 
                                                                   //yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                                                  // strcpy(yylval.s,yytext);
                                                                   
                                                                   return DOCINFO;
                                                                  }

<DOCT>">"              {
                      
                       BEGIN 0;
                       }

"<meta"[ ]                          { BEGIN(DOCT);  return METADATA;}

<META>"http-equiv= \""([A-Za-z0-9]|{symbol}|[\t])+[\"]            {  
                                                                   
                                                                  }

<META>"content= \""([A-Za-z0-9]|{symbol}|[\t])+[\"]               { 
                                                                
                                                                  }

<META>">"              {
                      
                       BEGIN 0;
                       }


 
"<html>"|"<HTML>"      { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); 
                         //printf("HTML \n");
                         return HTST;
                        }
"<head>"|"<HEAD>"       { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("HEAD \n");
                         return HDST;
                        }
"<title>"|"<TITLE>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("TITLE \n");
                         return TITST;
                        }
"<body>"|"<BODY>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("BODY \n");
                         return BDST;
                        }
"<p>"|"<P>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("P \n");
                         return PRST;
                        }

"<div>"|"<DIV>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("DIV \n");
                         return DVST;
                        }


"</html>"|"</HTML>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("HTMLE \n");
                         return HTED;
                        }

"</head>"|"</HEAD>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("HEADE\n");
                         return HDED;
                        }
"</title>"|"</TITLE>"   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("TITLEE \n");
                         return TITED;
                        }
"</body>"|"</BODY>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         
                         return BDED;
                        }
"</p>"|"</P>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("PE \n");
                         return PRED;
                        }

"</div>"|"</DIV>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         //printf("DIVE \n");
                         return DVED;
                        }

 /*Heading Startings*/

"<h1>"|"<H1>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H1 \n");
                         return H1S;
                        }

"<h2>"|"<H2>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H2 \n");
                         return H2S;
                        }

"<h3>"|"<H3>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H3 \n");
                         return H3S;
                        }

"<h4>"|"<H4>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H4 \n");
                         return H4S;
                        }
"<h5>"|"<H5>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H5 \n");
                         return H5S;
                        }
"<h6>"|"<H6>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H6 \n");
                         return H6S;
                        }
 /*Heading Endings*/

"</h1>"|"</H1>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H1e \n");
                         return H1E;
                        }

"</h2>"|"</H2>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H2e \n");
                         return H2E;
                        }

"</h3>"|"</H3>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H3e \n");
                         return H3E;
                        }

"</h4>"|"</H4>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("H4e \n");
                         return H4E;
                        }
"</h5>"|"</H5>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("H5e \n");
                         return H5E;
                        }
"</h6>"|"</H6>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("H6e \n");
                         return H6E;
                        }

 /*Listing Startings*/

"<ul>"|"<UL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("UL \n");
                         return ULS;
                        }
"<li>"|"<LI>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("Li \n");
                         return LIS;
                        }          
"<ol>"|"<OL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("ol \n");
                         return OLS;
                        }   
"<dl>"|"<DL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dl \n");
                         return DLS;
                        }      
"<dt>"|"<DT>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dt \n");
                         return DTS;
                        }           
"<dd>"|"<DD>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dd \n");
                         return DDS;
                        }   
                        

 /*Listing endings*/

"</ul>"|"</UL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("ULe \n");
                         return ULE;
                        }
"</li>"|"</LI>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("Lie \n");
                         return LIE;
                        }          
"</ol>"|"</OL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("oL \n");
                         return OLE;
                        }   
"</dl>"|"</DL>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dL \n");
                         return DLE;
                        }      
"</dt>"|"</DT>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dt \n");
                         return DTE;
                        }           
"</dd>"|"</DD>"                   { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("dd \n");
                         return DDE;
                        }                                                                                                               


  /*table startings*/

 
"<table>"|"<TABLE>"              { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);
                         return TABLES;
                        } 


  
"<table"[ ]*              { yylval.s=(char *)malloc((10)*sizeof(char));
                         strcpy(yylval.s,"<table>");
                         BEGIN(T_ATR);
                         return TABLES;  
                         
                        }

<T_ATR>[ ]*"border=\"0\">"   {
                               char *temp=(char *)malloc((10)*sizeof(char));
                              temp[0]='0';
			     temp[1]='\0';
                              yylval.s=strdup(temp);
                             
                               BEGIN 0;
                               return TABLEBORDER; 
                               
                             }

<T_ATR>[ ]*"border=\"1\">"    {
                                char *temp=(char *)malloc((10)*sizeof(char));
                              temp[0]='1';
			     temp[1]='\0';
                              yylval.s=strdup(temp);
                               BEGIN 0;
                               return TABLEBORDER; 
                             }

<T_ATR>[ ]*"border=\'0\'>"    {
                               char *temp=(char *)malloc((10)*sizeof(char));
                              temp[0]='0';
			     temp[1]='\0';
                              yylval.s=strdup(temp);
                             
                               BEGIN 0;
                               return TABLEBORDER; 
                             }

<T_ATR>[ ]*"border=\'1\'>"    {
                                
                               char *temp=(char *)malloc((10)*sizeof(char));
                              temp[0]='1';
			     temp[1]='\0';
                              yylval.s=strdup(temp);
                               BEGIN 0;
                               return TABLEBORDER; 
                             }

  /*

<T_ATR>"border=\""[0-9][\"] {
                                 char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                 strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                 
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                         strcpy(yylval.s,k); //printf("tableborder \n");
                         return TABLEBORDER; 
                                  
                                 } 
   
                        




                         

<T_ATR>"border=\'"[0-9][\'] {
                                 char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                 strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                 
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                         strcpy(yylval.s,k); //printf("tableborder \n");
                         return TABLEBORDER; 
                                  
                                 } 
                               


                                 
<T_ATR>">"                {
                           //printf("tabletagend \n");
                           BEGIN 0;
                          
                          }
  */

    

"<tr>"|"<TR>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("tr \n");
                         return TRS;
                        }
"<th>"|"<TH>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("th \n");
                         return THS;
                        }
"<td>"|"<TD>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("td \n");
                         return TDS;
                        }
"<caption>"|"<CAPTION>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("caption \n");
                         return CAPTIONS;
                        }

  /*TABLE ENDINGS*/


"</table>"|"</TABLE>"              { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("tablee \n");
                         return TABLEE;
                        }
 
"</tr>"|"</TR>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("tre \n");
                         return TRE;
                        }
"</th>"|"</TH>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("the \n");
                         return THE;
                        }
"</td>"|"</TD>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("tde \n");
                         return TDE; 
                        }
"</caption>"|"</CAPTION>"                  { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("captione \n");
                         return CAPTIONE;
                        }

            /*TEXTSTYLE STARTINGS*/

"<U>"|"<u>"            { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("U \n");
                         return US;
                        }
"<B>"|"<b>"               { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("B \n");
                         return BS;
                        }
"<I>"|"<i>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("i \n");
                         return IS;
                        }
"<EM>"|"<em>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("em \n");
                         return EMS;
                        }
"<TT>"|"<tt>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("tt \n");
                         return TTS;
                        }
"<STRONG>"|"<strong>"     { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("strong \n");
                         return STRONGS;
                        }

"<SMALL>"|"<small>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("small \n");
                         return SMALLS;
                        }
"<SUB>"|"<sub>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("sub \n");
                         return SUBS;
                        }
"<SUP>"|"<sup>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("sup \n");
                         return SUPS;
                        }


    /*TEXTSTYLE ENDINGS*/

"</U>"|"</u>"            { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("Ue \n");
                         return UE;
                        }
"</B>"|"</b>"               { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("be \n");
                         return BE;
                        }
"</I>"|"</i>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("ie \n");
                         return IE;
                        }
"</EM>"|"</em>"             { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("eme \n");
                         return EME;
                        }
"</TT>"|"</tt>"           { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("tte \n");
                         return TTE;
                        }
"</STRONG>"|"</strong>"     { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("stronge \n");
                         return STRONGE;
                        }

"</SMALL>"|"</small>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("smalle \n");
                         return SMALLE;
                        }
"</SUB>"|"</sub>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("sube \n");
                         return SUBE;
                        }
"</SUP>"|"</sup>"         { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("supe \n");
                         return SUPE;
                        }



{word}                 { yylval.s=(char *)malloc(5000*sizeof(char));
                         strcpy(yylval.s,yytext); //printf("word \n");
                         return WORD;
                        }


                          
                          



"<center>"|"<CENTER>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("centers \n");
                         return CENTERS;   
                         // printf("%s",yytext);
                        }
                        
"</center>"|"</CENTER>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("centere \n");
                         return CENTERE;
                         
                         // printf("%s",yytext);
                        }                        
                        
"<br>"|"<br/>"|"<BR>"|"<BR/>"  {
                                 yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("br \n");
                         return BRS; 
                         // printf("%s",yytext);
                               }   
                               
"<a>"                          {
                                /* yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                         strcpy(yylval.s,yytext);//printf("as \n");
                         return AS; 
                         // printf("%s",yytext);  */
                               }                                                 

"<a"[ ]*                    { BEGIN(A_ATR);
                           yylval.s=(char *)malloc((6)*sizeof(char));
                         strcpy(yylval.s,"<a>");//printf("asst \n");
                         BEGIN(A_ATR);
                         return AS;
                         //printf("A"); 
                        } 
<A_ATR>[ ]*"href=\""({word}|(\.|\/|\\|\_|\~|\:|\#))*"\""[ ]* { 
                                                       
                                                      char *s=(char*)malloc(6000);
                                                        
                                                     
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                 
                                          
                                                   while(s[i]!='\"')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\"')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';
                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            yylval.s=k;
                                             
                                            
                                            return AHREF; 
                                  
                                 }
                                 

<A_ATR>[ ]*"href=\'"({word}|(\.|\/|\\|\_|\~|\:|\#))*"\'"[ ]* { 
                                                      char *s=(char*)malloc(6000);
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                
                                          
                                                   while(s[i]!='\'')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\'')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';
                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            strcpy(yylval.s,k); 
                                            
                                            return AHREF; 
                                  
                                 }


<A_ATR>[ ]*"name=\""{word}[\"][ ]* { 
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf(" \n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return ANAME;
                                  
                                 }   

<A_ATR>[ ]*"name=\'"{word}[\'][ ]* { 
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                 
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf(" \n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return ANAME; 
                                  
                                 }     
                                 
<A_ATR>[ ]*"title=\""{word}[\"][ ]* { 
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf(" \n %s",k);
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return ATITLE; 
                                  
                                  
                                 }  

<A_ATR>[ ]*"title=\'"{word}[\"][ ]' { 
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf(" \n %s",k);
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return ATITLE;
                                  
                                  
                                 }                                                           
                                 
                                 
                                 
                                 
<A_ATR>">"                   {   
				BEGIN 0;
                                //printf(">");
                                }  
                                
"</a>"                        {
                              yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(yylval.s,yytext);//printf("ae \n");
                                  return AE;
                              }  
                              
"<font>"                        {
                              yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(yylval.s,yytext);//printf("font \n");
                                  return FONTS;
                              }  
                                                                                        
                                
"<font"[ ]*                    {
                                BEGIN(F_ATR);
                                 yylval.s=(char *)malloc((10)*sizeof(char));
                                  strcpy(yylval.s,"<font>");
                                  return FONTS;
                                //printf("f \n");
                                 }   
                                 
<F_ATR>"size=\""[0-9]+[\"] {
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);//printf("fontsize \n");
                                  return FONTSIZES;
                                  
                                 }      

<F_ATR>"size=\'"[0-9]+[\'] {
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                  yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);//printf("fontsize \n");
                                  return FONTSIZES;
                                  
                                 }
                                                                
<F_ATR>">"                       {
                                   
                                  BEGIN 0;
                                  }    
                                  
"</font>"                        {
                                   
                                  yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(yylval.s,yytext); //printf("fonted \n");
                                  return FONTE;
                              //printf("</font>");
                              }                   

"<img"[ ]*                     {
                                yylval.s=(char *)malloc((8)*sizeof(char));
                                  strcpy(yylval.s,"<img>");
                                 
                              BEGIN(IMG_ATR); //printf("img \n");
                               return IMGS;
                              //printf("IMG");
                              }    
  


<IMG_ATR>[ ]*"src=\""({word}|(\.|\/|\\|\_))*"\""[ ]* {
                                                 char *s=(char*)malloc(6000);
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                
                                          
                                                   while(s[i]!='\"')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\"')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';
                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            strcpy(yylval.s,k); 
                                           
                                            return IMGSRC;
                                  
                                 }   

<IMG_ATR>[ ]*"src=\'"({word}|(\.|\/|\\|\_))*"\'"[ ]* {
                                                 char *s=(char*)malloc(6000);
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                
                                          
                                                   while(s[i]!='\'')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\'')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';

                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            strcpy(yylval.s,k); 
                                            
                                            return IMGSRC;
                                  
                                 } 

  /*         
                                      
<IMG_ATR>[ ]*"src=\""({word}|(\.|\/|\\|\_))*"\""[ ]* {
                                                 char *s=(char*)malloc(6000);
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                
                                          
                                                   while(s[i]!='\"')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\"')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';

                                  
                                  //cout<<"kkkkkkkkkkkkkkkkkk"<<k<<"kkkkkkkkkkkkkkk "<<endl;
                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            strcpy(yylval.s,k); 
                                            cout<<yylval.s<<endl;
                                            return IMGSRC;
                                  
                                 }   

<IMG_ATR>[ ]*"src=\'"({word}|(\.|\/|\\|\_))*"\'"[ ]* {
                                                 char *s=(char*)malloc(6000);
						
                                		  strcpy(s,yytext);
					
                                		  char *k=(char*)malloc(6000);
                                                 int i=0,j=0;
                                                
                                          
                                                   while(s[i]!='\'')
                                                      {
                                                         i++;
                                                      }
                                                   i++;
                                  
                                                 while(s[i]!='\'')
                                                 {
                                                 k[j]=s[i];
                                                 j++;
                                                 i++;
                                                 }
                                               k[j]='\0';

                                            yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                            strcpy(yylval.s,k); 
                                            cout<<yylval.s<<endl;
                                            return IMGSRC;
                                  
                                 }  

 */
                                 
                                      
<IMG_ATR>[ ]*"height=\""[0-9]+[\"][ ]* {
                                        char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                        strcpy(s,yytext);
                                         char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                         int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return IMGHEIGHT;
                                  
                                 }   

<IMG_ATR>[ ]*"height=\'"[0-9]+[\'][ ]* {
                                        char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                        strcpy(s,yytext);
                                         char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                         int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return IMGHEIGHT;
                                  
                                 }                                                                                                
                                      
<IMG_ATR>[ ]*"width=\""[0-9]+[\"][ ]* {
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='"')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='"')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return IMGWIDTH;
                                  
                                 }

<IMG_ATR>[ ]*"width=\'"[0-9]+[\'][ ]* {
                                  char *s=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  strcpy(s,yytext);
                                  char *k=(char*)malloc(sizeof(yytext)*sizeof(char));
                                  int i=0,j=0;
                                  
                                  while(s[i]!='\'')
                                  {
                                     i++;
                                  }
                                  
                                  i++;
                                  
                                  while(s[i]!='\'')
                                  {
                                  k[j]=s[i];
                                  j++;
                                  i++;
                                  }
                                  k[j]='\0';
                                  //printf("\n %s",k);
                                  
                                   yylval.s=(char *)malloc(sizeof(strlen(k)+1)*sizeof(char));
                                  strcpy(yylval.s,k);
                                  return IMGWIDTH;
                                  
                                 }
                                 

                                 
<IMG_ATR>">"                     {
                             
                                 BEGIN 0;
                                 
                                  
                                 }   
                                 
<IMG_ATR>"/>"                    {
                               
                                 BEGIN 0;
                                 }
   
                                 
"<!--"                                   {
                                          BEGIN(CMENT);
                                         }             

<CMENT>"-->"                        {
                                     BEGIN(INITIAL);
                                    }
<*>                                  ;
                                                                                  
                                 
"<FIGURE>"|"<figure>"              { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                   strcpy(yylval.s,yytext);//printf("figures \n");
                                   return FIGURES;
                                   // printf("%s",yytext);
                                    }   
                        
"</FIGURE>"|"</figure>"            { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                   strcpy(yylval.s,yytext);//printf("figuree \n");
                                    return FIGUREE;
                                    // printf("%s",yytext);
                                }    
                        
"<FIGCAPTION>"|"<figcaption>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                        strcpy(yylval.s,yytext);//printf("figurecaptions \n");
                                        return FIGCAPTIONS;
                                        // printf("%s",yytext);
                                        }   
                        
"</FIGCAPTION>"|"</figcaption>"    { yylval.s=(char *)malloc(sizeof(yytext)*sizeof(char));
                                          strcpy(yylval.s,yytext);//printf("figurecaptione \n");
                                          return FIGCAPTIONE;
                                           // printf("%s",yytext);
                                            }                                
                        



%%

int yywrap(){ return 1;}



