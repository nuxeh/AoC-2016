#!/usr/bin/awk -f

BEGIN {
	FS=" ";
	count=0
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str}

{
	dbg($0)

	for (i=1; i<=NF; ++i) {
		a[i] = $i
	}

	asort(a, a_sorted)
	for (e in a_sorted)
		dbg(e ": " a_sorted[e])

	if (a_sorted[1] + a_sorted[2] > a_sorted[3])
		++count
}

END {
	print count " of " NR " triangles are valid"
}
