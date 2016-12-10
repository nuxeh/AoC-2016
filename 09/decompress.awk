#!/usr/bin/awk -f

BEGIN {
	rs_orig = "\\([0-9]+x[0-9]+\\)"
	RS = rs_orig
	seq = 0
	rt_last = ""

	#ORS="\n"
}

{
	# Skip first record
	if (rt_last == "") {
		rt_last = RT
		next
	}

	print "rt_last: " rt_last
	print $0

	OFS = " "
	ORS = "\n"
	print "seq:", seq, "\trs:", RS, "\trt:", RT

	switch (seq) {
	case 0:

		# Process header text (nxm)
		rt_sub = gensub(/[\)\(]/, "", "g", rt_last)
		split(rt_sub, a, "x")

		n = a[1]
		m = a[2]

		# Change to fixed length RS (for next run)
		rs_new=".{" n "}"
		RS = rs_new

	break
	case 1:

		# Change to header regex RS (for next run)
		RS = rs_orig


	break
	}

	# Increment state
	if (++seq == 2) seq = 0

}
