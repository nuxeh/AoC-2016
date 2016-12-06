#!/usr/bin/awk -f

BEGIN {
	FS=""
	ORS=""
}

{
	for (f=1; f<=NF; f++) {
		print $f
		f_letter[f][$f]++
	}
	print "\n"
}

END {
	for (j in f_letter) {
		#PROCINFO["sorted_in"] = "@val_type_desc"
		PROCINFO["sorted_in"] = "@val_type_asc"
		got_letter = 0
		for (k in f_letter[j]) {
			print k ": " f_letter[j][k] "|"

			if (got_letter == 0) {
				message = message k
				got_letter = 1
			}
		}
		print "\n"
	}

	# Print message
	print "message is: " message "\n"
}

