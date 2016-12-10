#!/usr/bin/awk -f

BEGIN {
	RS="\\([0-9]+x[0-9]+\\)"
}

{
	print rt_last
	print $0

	rt_sub = gensub(/[\)\(]/, "", "g", rt_last)
	print rt_sub
	split(rt_sub, a, "x")
	n = a[1]
	print n
	m = a[2]
	print m


	#if (length($0) < )

	rt_last = RT
}
