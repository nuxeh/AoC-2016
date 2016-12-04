#!/usr/bin/awk -f

BEGIN {
	FS="  ";
}

{
	print $0

	for (i=2; i<=NF; ++i) {
		a[i] = $i
	}

	asort(a, a_sorted)
	for (e in a_sorted)
		print a_sorted[e]
}

END {

}
