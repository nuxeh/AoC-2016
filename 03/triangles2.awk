#!/usr/bin/awk -f

BEGIN {
	FS=" ";
	count=0
	r_count=1
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str}

{
	print $0

	t1[r_count] = $1
	t2[r_count] = $2
	t3[r_count] = $3

	for (t in t1)
		dbg(t ": " t1[t])
	for (t in t2)
		dbg(t ": " t2[t])
	for (t in t3)
		dbg(t ": " t3[t])

	if (++r_count == 4) {
		r_count=1
		dbg("calculating 3 triangles")
		#calculate()
	}

}

function calculate() {
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
