#!/usr/bin/awk -f

BEGIN {
	FS="[:space:]*";
}

{
	for (i=0; i<=NF; ++i) {
		print $i
	}
}

END {

}
