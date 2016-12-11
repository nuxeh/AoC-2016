#!/usr/bin/awk -f
#
# Demonstrates:
# - On-the-fly RS changes
# - RT
# - Character length regex matching
#
# TODO: Do as an awk one-liner
# TODO: Proper handling of v2 compression format
# TODO: v2 with FS/RS

BEGIN {
	RS_MARKER = "\\([0-9]+x[0-9]+\\)"
	RS = RS_MARKER

	seq = 0
	RT_LAST = ""

	ORS=""

	if (substr(ARGV[1],1,2) == "D=") debug=substr(ARGV[1],3,1)
}

{
	# Stash record sepatator text for next time
	RT_LAST = RT

	# Skip first record
	if (RT_LAST == "") next

	dbg("seq: " seq "\trs: " RS "\trt: " RT " $0: " $0 "\n", 1)

	switch (seq) {
	case 0: #### HEADER ####

		# Process header text (nxm)
		get_marker(RT_LAST)
		nn = n; mm = m

		# $0 is remaining characters
		dbg($0 RT_LAST, 2)
		print $0
		count += length($0)

		# Change to fixed length RS (for next run)
		rs_new=".{" nn "}"
		RS = rs_new

	break
	case 1: #### CONTENT ####

		dbg(RT, 2)
		for (o=0; o<mm; ++o) {
			process_markers(RT)
			#print RT
			#count += length(RT)
		}

		# Change to header regex RS (for next run)
		RS = RS_MARKER

	break
	}

	# Increment state
	if (++seq == 2) seq = 0
}

END {
	dbg("\n", 2)
	dbg(count " characters decompressed\n", 3)
}

function dbg(d_s, d_l, d_rs, d_fs) {
	#d_f=OFS;OFS=(d_fs) ? d_fs : " ";d_r=ORS;ORS=(d_rs) ? d_rs : "\n";
	if (debug==d_l) print d_s  > "/dev/stderr";
	#OFS=d_f; ORS=d_r;
}

function get_marker(mtext) {
	rt_sub = gensub(/[\)\(]/, "", "g", mtext)
	split(rt_sub, a, "x")

	n = a[1]
	m = a[2]
}

function process_markers(data) {
	while (1) {
		match(data, RS_MARKER)
		marker_str = substr(data, RSTART, RLENGTH)

		dbg(data "\n", 4)
		dbg("RLENGTH: " RLENGTH " sub: " marker_str "\n", 4)

		if (RLENGTH == -1) # Finished
			break

		print substr(data, 0, RSTART - 1) # Ouput characters to the left
		get_marker(marker_str)
		nnn = n; mmm = m

		for (j=0; j<mmm; ++j) {
			dbg("j: " j "\n", 4)
			print substr(data, RSTART + RLENGTH, nnn)
		}

		data = substr(data, RSTART + RLENGTH + nnn)
	}
}

function process_marker(data) {
	new_data = process_next_marker(data)

	if (new_data == -1)
		return -1
}

function recurse(data) {

}
