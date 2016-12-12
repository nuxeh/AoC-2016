#!/usr/bin/awk -f

# TODO: lex
# TODO: verilog?

BEGIN {
	jump = 1
	pc = 0
	ORS = ""
}

{
	print $0 "\n"
	print "t" target_pc " p" pc "\n"

	if (target_pc < pc) {
		do {
			$0 = cache[target_pc]
			print "> " $0 "\n"
			instruction()
		} while (target_pc < pc)
		print "break out\n"
		$0 = cache[pc]
	}

	cache[pc] = $0

	if (target_pc > pc) {
		++pc
		next
	}

	instruction()
	++pc
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

	print "pc " pc " |"
	for (r in registers)
		print " " r " " registers[r]
	print " | tpc " target_pc "\n"
	print_cache()
}

function inc(reg)	{ registers[reg]++;	++target_pc }
function dec(reg)	{ registers[reg]--;	++target_pc }
function cpy(n, reg)	{
	registers[reg] = (match(n, /[0-9]+/)) ? n : registers[n]; ++target_pc
}
function jnz(cond, n)	{ if (cond != 0) target_pc = pc + n }

function print_cache() {
	for (i in cache)
		print ">> i " i "\t| " cache[i] "\n"
}

END {
	print "reg a = " registers["a"] "\n"
}
