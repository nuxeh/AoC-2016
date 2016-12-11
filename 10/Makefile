all: lexfiles binaries

lexfiles: lex.yy.c
	flex lex.l

binaries: bots
	gcc -o bots lex.yy.c -lfl

run:
	cat test | ./bots
