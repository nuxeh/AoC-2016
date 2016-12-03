#!/usr/bin/awk -f

# Keypad:
#
# 1 2 3
# 4 5 6
# 7 8 9
#
# Start at 5

BEGIN {
	a[1] = [1,2,3]
	a[2] = [4,5,6]
	a[3] = [7,8,9]

	x = 2; y = 2;
}

{
	print a[x, y]
}


