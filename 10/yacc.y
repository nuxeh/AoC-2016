%token IDENTIFIER LOWHIGH NUM

%{
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
		printf("found value assignment\n");
	}
	;

bot_transfer:
	IDENTIFIER NUM LOWHIGH IDENTIFIER NUM LOWHIGH IDENTIFIER NUM
	{
		printf("found bot transfer\n");
	}
	;
%%
