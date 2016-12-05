#!/usr/bin/awk -f

BEGIN {FS=""; count=0; ORS=""
	split("________", a, "")
}

{
	gsub(/\s.*$/, "", $0)
	print $0 "\n"
	if ($6 >= 0 && $6 <= 7) {
		if (a[$6+1] == "_") ++count;
		a[$6+1] = $7
		echo()
		if (count == 8)
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
