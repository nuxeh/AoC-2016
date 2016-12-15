all: discs

lex.yy.c: discs.l
	flex discs.l

lex.yy.o: lex.yy.c

discs: lex.yy.o
	gcc -o discs lex.yy.c -lfl

test: discs
	cat test | ./discs

clean:
	rm -f *.o lex.yy.c discs

run: discs
	cat input.txt | ./discs
