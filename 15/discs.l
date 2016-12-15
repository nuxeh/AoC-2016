%{
/*
 * Parse the list of disc positions
 */



%}

%%
[\t ]+		{ /* ignore whitespace */	}
time=0		{ /* ignore time=0 */		}
[0-9]+		{ printf("%d\n", atoi(yytext));	}
\n		{ printf("newline\n");		}
.		{ /* ignore anything else*/	}
%%

int main()
{
	yylex();
}
