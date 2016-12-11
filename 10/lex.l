%{
/*
 * Parse the list of instructions
 */

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
output		{ printf("%s:\tfound specifier\n", yytext); }
low |
high		{ printf("%s:\tfound lowhigh\n", yytext); }
[0-9]+		{ printf("%s:\tfound number\n", yytext); }
.		{ /* normal default anyway */ }
\n		{ ECHO; }
%%

int main()
{
	bot_list = (struct bot *)malloc(sizeof(struct bot));

	yylex();
	free(bot_list);
}
