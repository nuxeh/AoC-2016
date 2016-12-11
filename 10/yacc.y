%token IDENTIFIER LOWHIGH NUM

%{
/*
 * TODO: passing values between rules (lowhigh)
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int pass = 0;

struct bot {
	int low;
	int high;
};

struct bot *bot_list;

int n_bots = 0;
int highest_bot = 0;

int add_bot(int n)
{
	n_bots++;

	/* if needed, extend bot array */
	if (n > highest_bot) {
		highest_bot = n;
		bot_list = realloc(bot_list, sizeof(struct bot) * n);
	}

	/* add a new bot */
	struct bot new_bot;
	bot_list[n] = new_bot;
}

int bot_add(int bot_n, int chip_n)
{
	printf("> adding bot\t\t%d, highest: %d\n", bot_n, highest_bot);
	if (highest_bot < bot_n)
		add_bot(bot_n);
}

int bot_remove(int bot_n, int chip_n)
{

}


/* -------------------- yacc stuff -------------------- */

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
        return 1;
}

int main()
{
	bot_list = (struct bot *)malloc(sizeof(struct bot));
        yyparse();
}

%}

%%
commands:
	| commands command
	;

command:
	val_assign
	|
	bot_transfer
	;

val_assign:
	IDENTIFIER NUM IDENTIFIER NUM
	{
		printf("value assignment\t%d to bot %d\n", $2, $4);
		bot_add($4, $2);
		printf("> number of bots:\t%d\n", n_bots);
	}
	;

bot_transfer:
/*	1          2   3       4          5   6       7          8 */
	IDENTIFIER NUM LOWHIGH IDENTIFIER NUM LOWHIGH IDENTIFIER NUM
	{
		printf("bot transfer\t\tbot %d: %d -> %d, %d -> %d\n",
		       $2, $3, $5, $6, $8 );
	}
	;

/*
lowhigh:
	LOW
	{ return 0; }
	|
	HIGH
	{ return 1; }
*/
%%
