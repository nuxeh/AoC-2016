%{
/*
 * Parse the list of disc positions
 */

void update(char data);
void display(void);

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

#define MAX_DISCS 100
static char seq;

struct disc {
	char positions;
	char pos;
};

static char disc_index;
static struct disc *discs;

%}

%%
[\t ]+		{ /* ignore whitespace */	}
time=0		{ /* ignore time=0 */		}

Disc		{ seq = 0;			}
has		{ seq = 1;			}
position	{ seq = 2;			}

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
	discs = calloc(MAX_DISCS, sizeof(struct disc));
	yylex();
	display();
}

void update(char data)
{
	switch (seq) {
	case 0: /* disc number */
		disc_index = data;
		if (disc_index > MAX_DISCS)
			printf("Maximum number of discs %s exceeded",
				MAX_DISCS);
	break;
	case 1: /* number of positions */
		discs[disc_index].positions = data;
	break;
	case 2: /* start at (position) */
		discs[disc_index].pos = data;
	break;
	}
}

void show_disc(struct disc* disc_p)
{
	printf("numpos: %d pos: %d\n", disc_p->positions, disc_p->pos);
}

void display(void)
{
	char i;

	for (i=1; i<100; i++) {
		if (discs[i].positions != 0)
			show_disc(&discs[i]);
	}
}
