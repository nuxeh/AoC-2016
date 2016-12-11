%token IDENTIFIER LOWHIGH NUM

%{
/*
 * TODO: passing values between rules (lowhigh)
 */

#include <stdio.h>
#include <string.h>

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
