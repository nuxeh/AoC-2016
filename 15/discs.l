%{
/*
 * Parse the list of disc positions
 */

#if 0
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
#endif

struct disc {
	char positions;
	char position;
};

static char disc_index;
static struct disc *discs;

%}

%%
[\t ]+		{ /* ignore whitespace */	}
time=0		{ /* ignore time=0 */		}
[0-9]+		{
			printf("%d\n", atoi(yytext));
			update(atoi(yytext));
		}
\n		{ printf("newline\n");		}
.		{ /* ignore anything else*/	}
%%

int main()
{
	disc_index = 0;
	discs = calloc(100, sizeof(struct disc));
	yylex();
}

static char seq;

int update(char data)
{
	switch (seq) {
		case 0: /* disc number */
			disc_index = data;
		break;
		case 1: /* number of positions */
			discs[disc_index]->positions = data;
		break;
		case 2: /* start at (position) */
			discs[disc_index]->position = data;
		break;
	}
	seq++;
}
