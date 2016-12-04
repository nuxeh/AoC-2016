#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
}

{
	print "--"

	check_in = $(NF-1)
	sector_id = $(NF-2)

	i = 1
	delete a
	while (i < (NF-2)) {
		print i " : " $i

		a[i] = $i

		++i
	}
	asort(a, elem)
	print "sorted: "
	for(i in a) {
		print i "s: " elem[i]
	}
	print "checksum: " check_in
	print "sector id: " sector_id
}
