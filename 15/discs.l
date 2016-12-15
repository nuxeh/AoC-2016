%{
/*
 * Parse the list of disc positions
 */



%}

%%
[\t ]+		/* ignore whitespace */ ;
[0-9]+		{ printf("%d\n", yytext); }
\n		{ printf("newline"); }
%%

int main()
{
	yylex();
}
