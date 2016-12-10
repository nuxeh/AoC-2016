#!/usr/bin/awk -f

BEGIN {
	RS="\\([0-9]+x[0-9]+\\)"
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

	for (i=0; i <= length(rt_last); ++i)
		string = substr

	for (i=0; i <= length($0); ++i)

	if (characters_read == n)
		section_done = 1

	#if (length($0) < )

	rt_last = RT
}
