#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]|-"
	OFS=" "
	split("abcdefghijklmnopqrstuvwxyz", alphabet, "")
	ARGV[1] == "D=1" ? debug=1 : debug=0
}

function dbg(str) {if (debug) print str > "/dev/stderr"}
function increment(num) { return (++num > 26) ? 1 : num }


{
	check_in = $(NF-1)
	sector_id = $(NF-2)

	i = 1
	delete a

	while (i < (NF-2)) {
		a[i] = $i

		split($i, chars, "")
		for (j in chars) {
			for (l in alphabet)
				if (alphabet[l] == chars[j]) {
					print chars[j] " " alphabet[increment(l)]
					continue
				}

		}

		dbg(i " : " $i)
		++i
	}

	for(i in a) {
		dbg(i "s: " elem[i])
	}
	dbg("checksum: " check_in)
	dbg("sector id: " sector_id)

}
