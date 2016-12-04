#!/usr/bin/awk -f

BEGIN {
	FS="  ";
	count=0
}

{
	print $0

	for (i=2; i<=NF; ++i) {
		a[i] = $i
	}

	asort(a, a_sorted)
	for (e in a_sorted)
		print e ": " a_sorted[e]

	if (a_sorted[1] + a_sorted[2] > a_sorted[3])
		++count
}

END {
	print count " triangles are valid"
}
