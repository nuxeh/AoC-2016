#!/usr/bin/awk -f

BEGIN {
	FS="\\[|]"
}

function process(str) {
	split($i, a, "")
	return (a[1] == a[4] && a[2] == a[3]) ? 1 : 0
}

function result(arr) {
	if (arr[2] == 1)
		return 0
	if (arr[1] == 1 || arr[3] == 1)
		return 1
	else
		return 0
}

{
	delete b
	for (i=0; i<=NF; i++) {
		print $i
		l = length($i)
		for (j=1; j<=l-3; ++j) {
			r = process(substr($i, j, 4))
			print j " " r " " substr($i, j, 4)
			if (r == 1) {
				b[i] = r
				break
			}
		}
	}
	if (result(b)) count++
}

END {
	print "count of TLS ips: " count
}
