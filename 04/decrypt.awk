#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
	ORS=""
	split("abcdefghijklmnopqrstuvwxyz", alphabet, "")
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str > "/dev/stderr"}
function inc_1(num) { return (++num > 26) ? 1 : num }
function increment(num,inc) {for (k=inc; k>0; k--) {num = inc_1(num)} return num}

{
	check_in = $(NF-1)
	sector_id = $(NF-2)

	i = 1
	delete a

	while (i < (NF-2)) {
		split($i, chars, "")
		for (j in chars) {
			for (l in alphabet)
				if (alphabet[l] == chars[j]) {
					l_new = alphabet[increment(l, sector_id)]
					dbg(chars[j] " " l_new "\n")
					print l_new
					continue
				}
		}
		dbg("\n")
		print " "
		++i
	}
	print "\t\t[" $0 "]\n"
}
