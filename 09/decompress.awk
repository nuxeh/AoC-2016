#!/usr/bin/awk -f

BEGIN {
	rs_orig = "\\([0-9]+x[0-9]+\\)"
	RS = rs_orig

	#ORS="\n"
}

{
	print "rt_last: " rt_last
	print $0

	#if (rt_last == "") next

	rt_sub = gensub(/[\)\(]/, "", "g", rt_last)
	split(rt_sub, a, "x")
	if (section_done) {
		n = a[1]
		m = a[2]
	}

#	RS=".{,n}"
#	print RS
#	$0 = RT
#	print $0

	FS=".{,n}"
	print $1

	rt_last = RT
}
