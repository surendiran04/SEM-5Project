%{                                                                                                                                                                     
                                                                                                                                                                       
#include <stdio.h>                                                                                                                                                     
                                                                                                                                                                       
#include <stdlib.h>                                                                                                                                                    
                                                                                                                                                                       
#include <string.h>                                                                                                                                                    
                                                                                                                                                                       
#include "node.h"                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
extern int yylex();                                                                                                                                                    
                                                                                                                                                                       
void yyerror(const char *s);                                                                                                                                           
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
Node *root;                                                                                                                                                            
                                                                                                                                                                       
#define YYDEBUG 1   // Enable debugging                                                                                                                                
                                                                                                                                                                       
%}                                                                                                                                                                     
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%code requires {                                                                                                                                                       
                                                                                                                                                                       
    #include "node.h"                                                                                                                                                  
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%union {                                                                                                                                                               
                                                                                                                                                                       
    char *str;                                                                                                                                                         
                                                                                                                                                                       
    Node *node;                                                                                                                                                        
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%token DOCTYPE HTML_OPEN HTML_CLOSE HEAD_OPEN HEAD_CLOSE TITLE_OPEN TITLE_CLOSE                                                                                        
                                                                                                                                                                       
%token BODY_OPEN BODY_CLOSE P_OPEN P_CLOSE DIV_OPEN DIV_CLOSE H1_OPEN H1_CLOSE                                                                                         
                                                                                                                                                                       
%token <str> TEXT                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%type <node> html head title body content element                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%%                                                                                                                                                                     
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
html: DOCTYPE HTML_OPEN head body HTML_CLOSE      { root = createNode("html"); addChild(root, $3); addChild(root, $4); }                                               
                                                                                                                                                                       
    | HTML_OPEN head body HTML_CLOSE             { root = createNode("html"); addChild(root, $2); addChild(root, $3); }                                                
                                                                                                                                                                       
    ;                                                                                                                                                                  
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
head: HEAD_OPEN content HEAD_CLOSE               { $$ = createNode("head"); addChild($$, $2); }                                                                        
                                                                                                                                                                       
    ;                                                                                                                                                                  
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
title: TITLE_OPEN TEXT TITLE_CLOSE               { $$ = createNode("title"); addChild($$, createNode($2)); }                                                           
                                                                                                                                                                       
     ;                                                                                                                                                                 
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
body: BODY_OPEN content BODY_CLOSE               { $$ = createNode("body"); addChild($$, $2); }                                                                        
                                                                                                                                                                       
     ;                                                                                                                                                                 
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
content: /* empty */                             { $$ = NULL; }                                                                                                        
                                                                                                                                                                       
       | content element                         { if ($1) addChild($1, $2); else $$ = $2; }                                                                           
                                                                                                                                                                       
       ;                                                                                                                                                               
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
element: title                                                                                                                                                         
                                                                                                                                                                       
       | P_OPEN TEXT P_CLOSE                     { $$ = createNode("p"); addChild($$, createNode($2)); }                                                               
                                                                                                                                                                       
       | DIV_OPEN content DIV_CLOSE              { $$ = createNode("div"); addChild($$, $2); }                                                                         
                                                                                                                                                                       
       | H1_OPEN TEXT H1_CLOSE                   { $$ = createNode("h1"); addChild($$, createNode($2)); }                                                              
                                                                                                                                                                       
       | TEXT                                    { $$ = createNode($1); }                                                                                              
                                                                                                                                                                       
       ;                                                                                                                                                               
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
%%                                                                                                                                                                     
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
Node *createNode(char *tag) {                                                                                                                                          
                                                                                                                                                                       
    Node *node = (Node *)malloc(sizeof(Node));                                                                                                                         
                                                                                                                                                                       
    node->tag = strdup(tag);                                                                                                                                           
                                                                                                                                                                       
    node->child = NULL;                                                                                                                                                
                                                                                                                                                                       
    node->sibling = NULL;                                                                                                                                              
                                                                                                                                                                       
    return node;                                                                                                                                                       
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
void addChild(Node *parent, Node *child) {                                                                                                                             
                                                                                                                                                                       
    if (!parent->child) {                                                                                                                                              
                                                                                                                                                                       
        parent->child = child;                                                                                                                                         
                                                                                                                                                                       
    } else {                                                                                                                                                           
                                                                                                                                                                       
        Node *temp = parent->child;                                                                                                                                    
                                                                                                                                                                       
        while (temp->sibling) temp = temp->sibling;                                                                                                                    
                                                                                                                                                                       
        temp->sibling = child;                                                                                                                                         
                                                                                                                                                                       
    }                                                                                                                                                                  
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
void printTree(Node *node, int depth) {                                                                                                                                
                                                                                                                                                                       
    if (!node) return;                                                                                                                                                 
                                                                                                                                                                       
    for (int i = 0; i < depth; i++) printf("  ");                                                                                                                      
                                                                                                                                                                       
    printf("%s\n", node->tag);                                                                                                                                         
                                                                                                                                                                       
    printTree(node->child, depth + 1);                                                                                                                                 
                                                                                                                                                                       
    printTree(node->sibling, depth);                                                                                                                                   
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
void yyerror(const char *s) {                                                                                                                                          
                                                                                                                                                                       
    fprintf(stderr, "Syntax Error: %s\n", s);                                                                                                                          
                                                                                                                                                                       
}                                                                                                                                                                      
                                                                                                                                                                       
                                                                                                                                                                       
                                                                                                                                                                       
int main() {                                                                                                                                                           
                                                                                                                                                                       
    yydebug = 1;  // Enable debugging output                                                                                                                           
                                                                                                                                                                       
    yyparse();                                                                                                                                                         
                                                                                                                                                                       
    printTree(root, 0);                                                                                                                                                
                                                                                                                                                                       
    return 0;                                                                                                                                                          
                                                                                                                                                                       
}      
