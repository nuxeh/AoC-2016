%{
/*
 * Parse the list of disc positions
 */

void update(char data);
void display(void);
char verify(void);
void advance(char increment);

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
//#define DEBUG
#define OPTIMISE

/* lexing state variable */
static char seq;

/* disc data structure */
struct disc {
	char positions;
	char pos;
};

static char disc_index;
static struct disc *discs;
static char num_discs;


/* variables used for optimisation */
static unsigned long long start_time;
static char increment_by;
static char solved_levels;
static char level_hits;
static char last_level_hit;

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
	unsigned long long iterations;

	disc_index    = 0;
	num_discs     = 0;
	solved_levels = 0;

	discs = calloc(MAX_DISCS, sizeof(struct disc));

	/* lex the input */
	yylex();

	display();
	printf("number of discs: %d\n", num_discs);

	/* look for solution */
	iterations   = 0;
	start_time   = 0;
	increment_by = 1;

	do {
		iterations++;
		start_time += increment_by;
		advance(increment_by);
#ifdef DEBUG
		printf("\niter:\t%d\tt: %d\ti: %d\n",
			iterations, start_time, increment_by);
		display();
#endif
		if (!verify())
			break;
	} while (1);

	display();
	printf("solved in %d iterations (time=%ds)\n", iterations, start_time);
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

void advance(char increment)
{
	char i;

	for (i=1; i<100; i++) {
		if (discs[i].positions != 0) {
			discs[i].pos = ((discs[i].pos + increment)
					% discs[i].positions);
		}
	}
}

/*
 * Update solved levels, if this is the second time the capsule has reached
 * the current level, update the incrementation amount as the difference.
 */
#ifdef OPTIMISE
void update_optimisation(char target)
{
	if (target > solved_levels) {
		level_hits++;

		if (level_hits > 1) {
			increment_by  = start_time - last_level_hit;
			solved_levels = target;
			level_hits    = 0;

#ifdef DEBUG
			printf("update opt. i: %d l: %d\n",
			       increment_by, solved_levels);
#endif
			printf("current level: %d increment: %d\n", solved_levels, increment_by);
			display();
		}

		last_level_hit = start_time;
	}
}
#endif

/*
 * The capsule drops through if successive discs are a distance from wrapping
 * around to position 0, which increases by one per disc, since the ball takes
 * one time period to proceed down one level down, per disc.
 */
char verify(void)
{
	char i;
	char target;
	char n_from_end;

	target = 1;
	for (i=1; i<100; i++) {
		if (discs[i].positions != 0) {
			n_from_end = (discs[i].positions - discs[i].pos);

			/* bounce - no solution */
			if ((n_from_end % target) != 0) {
#ifdef OPTIMISE
				update_optimisation(target);
#endif
#ifdef DEBUG
				printf("ball:\t%d\n", target);
#endif
				/* stop processing this time slot */
				break;
			}

			/* finished */
			if (target == num_discs)
				return 0;

			target++;
		}
	}

	return 1;
}

/* Optimisation * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 * iter:	17
 * iter:	82
 * iter:	147
 * iter:	212
 * iter:	277
 * iter:	342
 * iter:	407
 * iter:	472
 * iter:	537
 * iter:	602
 *
 * The ball gets to the third level each 65 iterations (for
 * this data)
 *
 * Each time a new level is solved, from that point onwards, increment by the
 * number of steps it took to solve up to that level, so as not to repeat the
 * calculations necessary to get that far, redundantly.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
