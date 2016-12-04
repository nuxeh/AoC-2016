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
	while (i < (NF-2)) {
		dbg(i " : " $i)
		a[i] = $i
		++i
	}

	asort(a, elem)
	for(i in a) {
		dbg(i "s: " elem[i])
	}
	dbg("checksum: " check_in)
	dbg("sector id: " sector_id)
}
