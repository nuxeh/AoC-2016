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

function inc(reg)	{ registers[reg]++ }
function dec(reg)	{ registers[reg]-- }
function cpy(n, reg)	{ registers[reg] = n }
function jnz(cond, n)	{ if (cond != 0) jump = n }

END {
	print "reg a = " registers["a"] "\n"
}
