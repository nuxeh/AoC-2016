#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
	total = 0; valid = 0
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str  > "/dev/stderr"}

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
	delete a
	delete n_l

	while (i < (NF-2)) {
		a[i] = $i

		split($i, chars, "")
		for (j in chars) {
			# Vote for most common letters
			l = chars[j]
			n_l[l]++
		}

		dbg(i " : " $i)
		++i
	}

	asort(a, elem)

	for(i in a) {
		dbg(i "s: " elem[i])
	}
	dbg("checksum: " check_in)
	dbg("sector id: " sector_id)

	# Most common letters
	dbg("letters:")
	PROCINFO["sorted_in"] = "sort_letters"
	out_count=1
	check_out = ""
	for (k in n_l) {
		dbg(k ": " n_l[k])
		if (out_count <= 5) check_out = check_out "" k
		++out_count;
	}

	# Compute checksum
	dbg("computed checksum: " check_out)

	if (check_in == check_out) {
		dbg("valid")
		total += sector_id
		valid++
	}
}

END {
	print valid " valid records of " NR  > "/dev/stderr"
	print "total of valid sector ids: " total  > "/dev/stderr"
}
