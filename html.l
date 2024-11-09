%{                                                                                                                                                                     
                                                                                                                                                                       
#include <stdio.h>                                                                                                                                                     
                                                                                                                                                                       
#include <stdlib.h>                                                                                                                                                    
                                                                                                                                                                       
#include <string.h>                                                                                                                                                    
                                                                                                                                                                       
#include "y.tab.h"                                                                                                                                                     
                                                                                                                                                                       
%}                                                                                                                                                                     
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%%                                                                                                                                                                     
                                                                                                                                                                       
"<!DOCTYPE"            { return DOCTYPE; }                                                                                                                             
                                                                                                                                                                       
"<html>"               { return HTML_OPEN; }                                                                                                                           
                                                                                                                                                                       
"</html>"              { return HTML_CLOSE; }                                                                                                                          
                                                                                                                                                                       
"<head>"               { return HEAD_OPEN; }                                                                                                                           
                                                                                                                                                                       
"</head>"              { return HEAD_CLOSE; }                                                                                                                          
                                                                                                                                                                       
"<title>"              { return TITLE_OPEN; }                                                                                                                          
                                                                                                                                                                       
"</title>"             { return TITLE_CLOSE; }                                                                                                                         
                                                                                                                                                                       
"<body>"               { return BODY_OPEN; }                                                                                                                           
                                                                                                                                                                       
"</body>"              { return BODY_CLOSE; }                                                                                                                          
                                                                                                                                                                       
"<p>"                  { return P_OPEN; }                                                                                                                              
                                                                                                                                                                       
"</p>"                 { return P_CLOSE; }                                                                                                                             
                                                                                                                                                                       
"<div>"                { return DIV_OPEN; }                                                                                                                            
                                                                                                                                                                       
"</div>"               { return DIV_CLOSE; }                                                                                                                           
                                                                                                                                                                       
"<h1>"                 { return H1_OPEN; }                                                                                                                             
                                                                                                                                                                       
"</h1>"                { return H1_CLOSE; }                                                                                                                            
                                                                                                                                                                       
[a-zA-Z0-9]+           { yylval.str = strdup(yytext); return TEXT; }                                                                                                   
                                                                                                                                                                       
[ \t\n]+               { /* skip whitespace */ }                                                                                                                       
                                                                                                                                                                       
.                      { /* skip other characters */ }                                                                                                                 
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%%                                                                                                                                                                     
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
int yywrap() { return 1; }     
