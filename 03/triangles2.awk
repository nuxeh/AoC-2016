#!/usr/bin/awk -f

BEGIN {
	FS=" ";
	count=0
	r_count=1
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str}

{
	dbg("-- record: " $1 " " $2 " " $3 " --")

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
		calculate(t1)
		calculate(t2)
		calculate(t3)
	}

}

function calculate(array) {
	for (f in array)
		dbg(f " : " array[f])

	asort(array, a_sorted)

	for (e in a_sorted)
		dbg(e "s: " a_sorted[e])

	if (a_sorted[1] + a_sorted[2] > a_sorted[3])
		++count
}

END {
	print count " of " NR " triangles are valid"
}
