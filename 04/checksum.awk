#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str}

# Sort letters by count and alphabetically
function sort_letters(i1, v1, i2, v2) {
	if (v2 < v1)
		return -1
	else if (v2 == v1)
		return (i2 > i1) ? -1 : +1
	else if (v2 > v1)
		return +1
}

{
	check_in = $(NF-1)
	sector_id = $(NF-2)

	i = 1
	t_count = 1
	delete a
	delete n_l
	delete t

	while (i < (NF-2)) {
		a[i] = $i

		split($i, chars, "")
		for (j in chars) {
			# Vote for most common letters
			l = chars[j]
			n_l[l]++
		}

		if (length($i) == 1)
			t[count++] = $i

		dbg(i " : " $i)
		++i
	}

	asort(a, elem)

	for(i in a) {
		dbg(i "s: " elem[i])
	}
	dbg("checksum: " check_in)
	dbg("sector id: " sector_id)

	# Tied if field length is 1
	dbg("ties:")
	for (tn in t)
		dbg(tn ": " t[tn])

	# Most common letters
	dbg("letters:")
	PROCINFO["sorted_in"] = "sort_letters"
	for (k in n_l)
		dbg(k ": " n_l[k])

	# Compute checksum
	check_out = 1
	dbg("computed checksum: " check_out)
}
