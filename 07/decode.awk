#!/usr/bin/awk -f
#
# Scan IPv7 addresses, ABBA patterns in odd entries (separated by square
# brackets) indicate TLS support, unless there is an ABBA pattern in even
# entries. AAAA patterns are not valid.

BEGIN {
	FS="\\[|]"
	if (substr(ARGV[1],1,2) == "D=") debug=substr(ARGV[1],3,1)
}

function dbg(str,lvl) {if (debug==lvl) print str  > "/dev/stderr"}

function process(str) {
	split(str, a, "")
	if (a[1] == a[2]) return 0
	return (a[1] == a[4] && a[2] == a[3]) ? 1 : 0
}

function process_ssl(str) {
	split(str, a, "")
	if (a[1] == a[2]) return 0
	return (a[1] == a[3]) ? 1 : 0
}

function result(arr) {
	even = 0
	good = 0
	for (k=1; k<=NF; k++) {
		dbg(k ": " arr[k], 1)

		if (even == 1) {
			if (arr[k] == 1) return 0
		} else {
			if (arr[k] == 1) {
				good = 1
				dbg(arr[k] " is good (" k ")", 1)
			}
		}

		if (++even == 2) even = 0
	}
	return good
}

{
	delete b
	delete c
	delete d
	hypernet = 0
	for (i=1; i<=NF; i++) {
		l = length($i)

		for (j=1; j<=l-3; ++j) {
			r = process(substr($i, j, 4))
			b[i] = r

			dbg(j "\t" r "\t" substr($i, j, 4), 1)

			if (r == 1) {
				break
			}

		}

		for (m=1; m<=l-2; ++m) {
			sstr = substr($i, m, 3)
			r = process_ssl(sstr)
			dbg(sstr " [" r "] hypernet: " hypernet, 2)

			if (r == 1) {
				if (hypernet == 0)
					c[i "_" m] = sstr
				else
					d[i "_" m] = sstr
			}
		}

		if (++hypernet > 1) hypernet = 0
	}

	if (result_ssl(c,d)) count_ssl++
	if (result(b)) count++
	dbg("count=" count, 1)
}

function ababab(sup_s, hyp_s) {
	if (substr(sup_s, 1, 1) == substr(hyp_s, 2, 1))
		if (substr(sup_s, 2, 1) == substr(hyp_s, 1, 1)) {
			dbg("match s: " sup_s " h: " hyp_s, 2)
			return 1
		}
	return 0
}

function result_ssl(super, hyper) {
	for (aba in super) {
		for (bab in hyper) {
			dbg("super: " super[aba] " hyper: " hyper[bab], 2)
			if (ababab(super[aba], hyper[bab]) == 1) {
				return 1
			}
		}
	}
	return 0
}

END {
	print "count of TLS ips: " count
	print "count of SSL ips: " count_ssl
	print "total records: " NR
}
