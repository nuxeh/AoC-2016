#!/usr/bin/awk -f

BEGIN {
	# Keypad:
	r[1] = ". . . . . . ."
	r[2] = ". . . 1 . . ."
	r[3] = ". . 2 3 4 . ."
	r[4] = ". 5 6 7 8 9 ."
	r[5] = ". . A B C . ."
	r[6] = ". . . D . . ."
	r[7] = ". . . . . . ."

	num_rows = 7

	# Start at 5:
	x = 2; y = 4;

	for (i=1; i<num_rows; ++i) {
		a[i][0] = "";
		split(r[i], a[i], " ")
	}

	FS=""
}

function move(dir) {
	switch (dir) {
	case "U":
		if (y > 1) --y
	break
	case "D":
		if (y < 3) ++y
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
	}
	key = a[y][x]
	print "Press key: " key
	code = code "" key
}

END {
	print "the code is: " code
}


