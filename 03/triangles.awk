#!/usr/bin/awk -f

BEGIN {
	FS="  ";
}

{
	print $0
	for (i=2; i<=NF; ++i) {
		print $i
	}
}

END {

}
