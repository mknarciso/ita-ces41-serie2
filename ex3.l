delim		[ \t\n\r]
ws			{delim}+
letra		[A-Za-z]
digito		[0-9]
id			{letra}({letra}|{digito})*
%%
{ws}		{ ;}
bool		{return BOOL;}
char		{return CHAR;}
float		{return FLOAT;}
int			{return INT;}
{id}		{strcpy (yylval.cadeia, yytext); return ID;}
"("			{return ABPAR;}
")"			{return FPAR;}
"{"			{return ABCHAV;}
"}"			{return FCHAV;}
";"			{return PVIRG;}
","			{return VIRG;}
.			{yylval.carac = yytext[0]; return INVAL;}
%%
