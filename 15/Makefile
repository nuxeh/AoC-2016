all: discs

lexfiles: lex.yy.c
	flex discs.l

discs: discs.o
	gcc -o discs lex.yy.c -lfl

test: discs
	cat test | ./discs

run: discs
	cat input.txt | ./discs
