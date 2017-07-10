%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
void Esperado (char *);
%}

%union {
	char cadeia[50];
	char carac;
}

%token		BOOL
%token		CHAR
%token		FLOAT
%token		INT
%token		<cadeia>		ID
%token		ABPAR
%token		FPAR
%token		ABCHAV
%token		FCHAV
%token		PVIRG
%token		VIRG                 
%token		<carac>		INVAL
%%

Funcao	:  Cabecalho  Declaracoes
			;
Cabecalho  	:  ID  ABPAR  {printf ("%s \( ", $1);} FPAR  			{printf (")\n");}
			|  ID error {printf ("%s ", $1); 
			    Esperado  ("(");} 
			    FPAR  {yyerrok; printf (")\n");}
			|  ID error {printf ("%s\n", $1); 
			    Esperado  ("( )"); yyerrok;}
			|  error {Esperado  ("Identificador");} 
			    ABPAR  FPAR  {yyerrok; printf ("() ");}
			|  ID ABPAR error {printf ("%s (\n", $1); 			    Esperado  (")"); yyerrok;}
			;

Declaracoes :    ABCHAV  {printf ("\{\n");} ListDecl 
			      FCHAV   {printf ("}\n");}
			;
ListDecl	:
			|    ListDecl  Declaracao
			;
Declaracao	:     Tipo  ListElemDecl  PVIRG 
			      {printf ("; \n");}
			|    Tipo  ListElemDecl  error  PVIRG  			      {Esperado("';' "); yyerrok;}
			;

Tipo  		:   INT 	 {printf ("int ");}
			|  FLOAT    {printf ("float ");}
			|  CHAR	 {printf ("char ");}
			|  BOOL	 {printf ("bool ");}
			;
ListElemDecl :  ElemDecl
			|  ListElemDecl  VIRG  {printf (", ");} 			    ElemDecl
			;
ElemDecl :  ID {printf ("%s ", $1);}
			|   error  ID  
			     {Esperado("Identificador"); yyerrok;}
			;                                     


%%
#include "lex.yy.c"

void Esperado (char *s) {
	printf ("\n***** Esperado: %s \n", s);
}
