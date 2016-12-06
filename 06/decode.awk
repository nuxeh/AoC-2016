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
		PROCINFO["sorted_in"] = "@val_type_desc"
		for (k in f_letter[j])
			print k ": "f_letter[j][k] "|"
		print "\n"
	}
}

