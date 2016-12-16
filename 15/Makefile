all: discs

lex.yy.c: discs.l
	flex discs.l

lex.yy.o: lex.yy.c

discs: lex.yy.o
	gcc -o discs lex.yy.c -lfl

.PHONY: test
test: discs
	cat test | ./discs

clean:
	rm -f *.o lex.yy.c discs

.PHONY: run
run: discs
	cat input.txt | ./discs

# TODO: Phony targets don't rebuild when source is changed
