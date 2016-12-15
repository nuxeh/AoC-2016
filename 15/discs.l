%{
/*
 * Parse the list of disc positions
 */

/* lexing pass */
char pass = 0;
/* pass	function
 * 0	count defined discs (lines in file), assign memory
 * 1	create disc structures, process
 */

int yywrap()
{
        return 1;
}


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
