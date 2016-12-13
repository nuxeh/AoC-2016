#!/usr/bin/awk -f

# TODO: lex
# TODO: verilog?

BEGIN {
	jump = 1
	pc = 1
	ORS = ""
}

{
	print NR " " $0 "\n"
	cache[NR] = $0
}

END {
	do {
		$0 = cache[pc]
		print $0 "\n"
		instruction()
	} while (pc <= NR)

	print "reg a = " registers["a"] "\n" > "/dev/stderr"
}

function instruction() {
	i = $1

	switch(NF) {
	case 2:
		@i($2)
	break
	case 3:
		@i($2, $3)
	break
	}

	print_state()
	print_cache()
}

# Instructions ###############################################################
function inc(reg)	{ registers[reg]++; pc++ }
function dec(reg)	{ registers[reg]--; pc++ }
function cpy(n, reg)	{
	registers[reg] = (match(n, /[0-9]+/)) ? n : registers[n]; pc++
}
function jnz(cond, n)	{
	cond = (match(cond, /[0-9]+/)) ? cond : registers[cond];
	pc = (cond != 0) ? pc + n : pc + 1;
}
##############################################################################

function print_cache() {
	for (i in cache) {
		if (i == pc)
			print "*"
		else
			print " "
		print "| i " i "\t| " cache[i] "\n"
	}
}

function print_state() {
	print "pc " pc " |"
	for (r in registers)
		print " " r " " registers[r]
	print " |\n"
}
