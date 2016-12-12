#!/usr/bin/awk -f

# TODO: lex

BEGIN {
	jump = 1
	pc = 0
	ORS = ""
}

{
	print $0 "\n"

	if (jump > 1) {
		cache[pc] = $0
		++pc
		--jump
		next
	}

	if (jump < 0) {
		$0 = cache[pc - jump]
		pc = pc - jump
		jump++
	}
		

	instruction()
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

	print "| pc " pc
	for (r in registers)
		print " " r " " registers[r]
	print " |\n"
	++pc
}

function inc(reg)	{ registers[reg]++;	++target_pc }
function dec(reg)	{ registers[reg]--;	++target_pc }
function cpy(n, reg)	{
	registers[reg] = (match(n, /[0-9]+/)) ? n : registers[n]; ++target_pc
}
function jnz(cond, n)	{ if (cond != 0) target_pc = pc + n }

END {
	print "reg a = " registers["a"] "\n"
}
