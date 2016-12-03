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
}
{

}
END {
	print a[x][y]
}


