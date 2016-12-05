#!/usr/bin/awk -f

BEGIN {FS=""; count=0; ORS=""
	split("_______", a, "")
}

{
	print $0 "\n"
	if ($6 > 0 && $6 <= 7) {
		a[$6] = $7
		echo()
		if (++count == 8)
			exit
	}
}

function echo(){
	print "|"
	for (i in a) {
			print a[i]
	}
	print "|\n"
}
