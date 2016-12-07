#!/usr/bin/awk -f
#
# Scan IPv7 addresses, ABBA patterns in odd entries (separated by square
# brackets) indicate TLS support, unless there is an ABBA pattern in even
# entries. AAAA patterns are not valid.

BEGIN {
	FS="\\[|]"
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str  > "/dev/stderr"}

function process(str) {
	split(str, a, "")
	if (a[1] == a[2]) return 0
	return (a[1] == a[4] && a[2] == a[3]) ? 1 : 0
}

function result(arr) {
	even = 0
	good = 0
	for (k=1; k<=NF; k++) {
		dbg(k ": " arr[k])

		if (even == 1) {
			if (arr[k] == 1) return 0
		} else {
			if (arr[k] == 1) {
				good = 1
				dbg(arr[k] " is good (" k ")")
			}
		}

		if (++even == 2) even = 0
	}
	return good
}

{
	delete b
	for (i=1; i<=NF; i++) {
		l = length($i)

		for (j=1; j<=l-3; ++j) {
			r = process(substr($i, j, 4))
			b[i] = r

			dbg(j "\t" r "\t" substr($i, j, 4))

			if (r == 1) {
				break
			}
		}
	}
	if (result(b)) count++
	dbg("count=" count)
}

END {
	print "count of TLS ips: " count
}
