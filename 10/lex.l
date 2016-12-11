%{
/*
 * Parse the list of instructions
 */

int pass = 0;
%}

%%
[\t ]+		/* ignore whitespace */ ;

bot |
value		{ printf("%s: found specifier\n", yytext); }
low |
high		{ printf("%s: found lowhigh\n", yytext); }
[0-9]+		{ printf("%s: number\n", yytext); }
.|\n		{ /* normal default anyway */ }
%%

int main()
{
	yylex();
}
