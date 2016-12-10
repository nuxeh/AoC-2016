#!/usr/bin/awk -f

BEGIN {
	rs_orig = "\\([0-9]+x[0-9]+\\)"
	RS = rs_orig

	seq = 0
	rt_last = ""

	#ORS="\n"

	if (substr(ARGV[1],1,2) == "D=") debug=substr(ARGV[1],3,1)
}

{
	# Stash record sepatator text for next time
	rt_last = RT

	# Skip first record
	if (rt_last == "") next

	dbg("seq: " seq "\trs: " RS "\trt: " RT, 1)

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

function dbg(d_s, d_l, d_fs, d_rs) {
	d_f=OFS;OFS=(d_fs) ? d_fs : " ";d_fs;d_r=ORS;ORS=(d_rs) ? d_rs : "\n";
	if (debug==d_l) print d_s  > "/dev/stderr";
	OFS=d_f; ORS=d_r;
}
