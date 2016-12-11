%{
/*
 * Parse the list of instructions
 */

#include "yacc.tab.h"

int pass = 0;

struct bot {
	int low;
	int high;
};

struct bot *bot_list;

int n_bots = 0;
int highest_bot = 1;

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

}

int bot_remove(int bot_n, int chip_n)
{

}

%}


%%
[\t ]+		/* ignore whitespace */ ;

bot |
value |
output		{ return IDENTIFIER; }
low |
high		{ return LOWHIGH; }
[0-9]+		{ return NUM; }

.		{ /* ignore anything else */ }
\n		{ ECHO; }
%%

/*
int main()
{
	bot_list = (struct bot *)malloc(sizeof(struct bot));

	yyparse();
	free(bot_list);
}
*/
