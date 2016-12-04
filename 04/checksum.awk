#!/usr/bin/awk -f

# input record:
# aaaaa-bbb-z-y-x-123[abxyz]

BEGIN {
	FS="\\[|]"
}

{
	i = 1
	while (i < NF) {
		print i ": " $i
		++i
	}

}
