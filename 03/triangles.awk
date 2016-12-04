#!/usr/bin/awk -f

BEGIN {
	FS="  ";
	count=0
}

{
	for (i=2; i<=NF; ++i) {
		a[i] = $i
	}

	asort(a, a_sorted)

	if (a_sorted[1] + a_sorted[2] > a_sorted[3])
		++count
}

END {
	print count " of " NR " triangles are valid"
}
