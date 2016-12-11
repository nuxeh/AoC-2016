all: bison lexfiles binaries

lexfiles: yacc.tab.h
	flex lex.l

bison:
	bison -d yacc.y

binaries: lex.yy.c yacc.tab.c
	gcc -o bots lex.yy.c yacc.tab.c -lfl

run:
	cat test | ./bots
