#!/usr/bin/awk -f

BEGIN {
	# Keypad:
	r[1] = "1 2 3"
	r[2] = "4 5 6"
	r[3] = "7 8 9"

	# Start at 5:
	x = 2; y = 2;

	for (i=1; i<4; ++i) {
		a[i][0] = "";
		split(r[i], a[i], " ")
	}

	FS=""
}

function move(dir) {
	switch (dir) {
	case "U":
		if (y < 3) ++y
	break
	case "D":
		if (y > 1) --y
	break
	case "L":
		if (x > 1) --x
	break
	case "R":
		if (x < 3) ++x
	break
	}
}

{
	print $0
	# Parse each movement
	for (i=1; i<=NF; ++i) {
		move($i)
		print x " " y
	}
	key = a[y][x]
	print "Press key: " key
	code = code "" key
}

END {
	print "the code is: " code
}


