%{
/*
 * Parse the list of instructions
 */

int pass = 0;
%}

%%
[\t ]+		/* ignore whitespace */ ;

value 		{ printf("%s: found\n", yytext); }
[a-zA-Z0-9]+	{ printf("%s: not recognised\n", yytext); }
.|\n		{ ECHO; /* normal default anyway */ }
%%

int main()
{
	yylex();
}
