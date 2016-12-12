#!/usr/bin/awk -f

# TODO: lex

BEGIN {
	
}

{
	
	print NF
}

function inc(reg)	{ registers[reg]++ }
function dec(reg)	{ registers[reg]-- }
function cpy(n, reg)	{ registers[reg] = n }
function jnz(cond, n)	{  }

END {

}
