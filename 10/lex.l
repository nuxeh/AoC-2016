%{
/*
 * Parse the list of instructions
 */

int pass = 0;
%}

%%
[\t ]+		/* ignore whitespace */ ;

bot |
value |
output		{ printf("%s:\tfound specifier\n", yytext); }
low |
high		{ printf("%s:\tfound lowhigh\n", yytext); }
[0-9]+		{ printf("%s:\tfound number\n", yytext); }
.		{ /* normal default anyway */ }
\n		{ ECHO; }
%%

int main()
{
	yylex();
}
