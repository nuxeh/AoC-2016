#!/usr/bin/awk -f
# Build a password of 8 characters from fields where the 6th character (if
# 0-7) is an address, and the 7th character is a value to insert. Do not
# overwrite if the slot in the password has already been assigned.

BEGIN {FS=""; count=0; ORS=""
	split("________", a, "")
}

{
	gsub(/\s.*$/, "", $0)
	print $0 " "
	if ($6 >= 0 && $6 <= 7) {
		if (a[$6+1] == "_") {
			++count;
			a[$6+1] = $7
		}
	}
	echo()
	if (count == 8)	exit
}

function echo(){
	print "|"
	for (i in a) {
			print a[i]
	}
	print "|\n"
}
