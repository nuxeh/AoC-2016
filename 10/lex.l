%{
/*
 * Parse the list of instructions
 */

#include "yacc.tab.h"



%}


%%
[\t ]+		/* ignore whitespace */ ;

bot |
value |
output		{ return IDENTIFIER; }
low |		/* { return LOW; } */
high		{ yylval = !strcmp(yytext,"high"); return LOWHIGH; }
[0-9]+		{ yylval = atoi(yytext); return NUM; }

.		{ /* ignore anything else */ }
\n		{ }
%%

/*
int main()
{
	bot_list = (struct bot *)malloc(sizeof(struct bot));

	yyparse();
	free(bot_list);
}
*/
