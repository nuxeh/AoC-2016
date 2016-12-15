%{
/*
 * Parse the list of disc positions
 */

void update(char data);
void display(void);
char verify(void);
void advance_1s(void);

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
static char num_discs;

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
	int iterations;

	disc_index = 0;
	num_discs  = 0;

	discs = calloc(MAX_DISCS, sizeof(struct disc));

	yylex();
	printf("number of discs: %d\n", num_discs);

	/* look for solution */
	iterations = 0;
	display();
	do {
		advance_1s();
		if (!verify())
			break;
#define DEBUG
#ifdef DEBUG
		printf("\n");
		display();
#endif
		iterations++;
	} while (1);

	printf("solved in %d iterations (time=%ds)\n", iterations, iterations);
}

void update(char data)
{
	switch (seq) {
	case 0: /* disc number */
		disc_index = data;
		num_discs++;
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
	char *string;

	string = malloc(disc_p->positions * sizeof(char));
	memset(string, '_', disc_p->positions * sizeof(char));
	string[disc_p->pos] = '|';
	string[disc_p->positions] = '\0';

	printf("numpos: %d\tpos: %d\t%s\n", disc_p->positions, disc_p->pos, string);
	free(string);
}

void display(void)
{
	char i;

	for (i=1; i<100; i++) {
		if (discs[i].positions != 0)
			show_disc(&discs[i]);
	}
}

void advance_1s(void)
{
	char i;

	for (i=1; i<100; i++) {
		if (discs[i].positions != 0) {
			discs[i].pos += 1;

			if (discs[i].pos == discs[i].positions)
				discs[i].pos = 0;

		}
	}
}

char verify(void)
{
	char i;
	char target;
	char n_from_end;

	target = 1;
	for (i=1; i<100; i++) {
		if (discs[i].positions != 0) {
			n_from_end = discs[i].positions - discs[i].pos;

			/* bounce - no solution */
			if (n_from_end != target)
				break;

			/* finished */
			if (target == num_discs)
				return 0;

			target++;
		}
	}

	return 1;
}
