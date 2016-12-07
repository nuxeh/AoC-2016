#!/usr/bin/awk -f

BEGIN {
	FS="\\[|]"
}

function process(str) {
	split($i, a, "")
	return (a[1] == a[4] && a[2] == a[3]) ? 1 : 0
}

function result(arr) {
	even = 0
	good = 0
	for (k=1; k<=NF; k++) {
		print k ": " arr[k]

		if (even == 1) {
			if (arr[k] == 1) return 0
		} else {
			if (arr[k] == 1) good = 1
			print arr[k] " is good"
		}

		if (++even == 2) even = 0
	}
	return good
}

{
	delete b
	for (i=0; i<=NF; i++) {
		print $i
		l = length($i)
		for (j=1; j<=l-3; ++j) {
			r = process(substr($i, j, 4))
			print j "\t" r "\t" substr($i, j, 4)
			b[i] = r
			if (r == 1) {
				break
			}
		}
	}
	if (result(b)) count++
}

END {
	print "count of TLS ips: " count
}
