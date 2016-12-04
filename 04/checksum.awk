#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str}

{
	check_in = $(NF-1)
	sector_id = $(NF-2)

	i = 1
	delete a
	delete n_l
	while (i < (NF-2)) {
		dbg(i " : " $i)
		a[i] = $i

		split($i, chars, "")
		for (j in chars) {
			# Vote for most common letters
			l = chars[j]
			n_l[l]++
		}
			

		++i
	}

	asort(a, elem)
	for(i in a) {
		dbg(i "s: " elem[i])
	}
	dbg("checksum: " check_in)
	dbg("sector id: " sector_id)

	# Tied if field length is 1

	# Most common letters
	for (k in n_l)
		dbg(k ": " n_l[k])
}
