#!/usr/bin/awk -f

BEGIN {
	RS="\\([0-9]+x[0-9]+\\)"
	#ORS="\n"
}

{
	print rt_last
	print $0

	#if (rt_last == "") next

	rt_sub = gensub(/[\)\(]/, "", "g", rt_last)
	split(rt_sub, a, "x")
	if (section_done) {
		n = a[1]
		m = a[2]
	}

	RS=""


	rt_last = RT
}
