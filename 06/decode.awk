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

}

