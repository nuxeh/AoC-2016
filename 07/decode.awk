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
		if (length($i) == 4) {
			r = process($i)
			print r
			b[i] = r
		}
	}
	if (result(b)) count++
}

END {
	print "count of TLS ips: " count
}
