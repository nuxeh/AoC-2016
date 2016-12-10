#!/usr/bin/awk -f

BEGIN {
	rs_orig = "\\([0-9]+x[0-9]+\\)"
	RS = rs_orig

	#ORS="\n"
}

{
	print "rt_last: " rt_last
	print $0


	rt_sub = gensub(/[\)\(]/, "", "g", rt_last)
	split(rt_sub, a, "x")
	n = a[1]
	m = a[2]
	header = 1

	rs_new=".{" n "}"
	print rs_new
	if (header == 1) {
		RS = rs_new
		header = 0
	}
	print RS
	RS=".{5}"
	#print RS
	#$0 = RT
	#print $0
	print RT

	#FS=".{,n}"
	#print $1

	rt_last = RT
	RS = rs_orig
}
