#!/usr/bin/awk -f

BEGIN {
	screen_width  = 7 # 50
	screen_height = 3 # 6

	#         x=0123456
	# lcd[1] = '0000000' # y=0
	# lcd[2] = '0000000' #   1
	# lcd[3] = '0000000' #   2

	# Create the screen
	row_str = ""
	for (col=1; col<=screen_width; ++col) row_str = row_str "0";
	for (row=1; row<=screen_height; ++row) {
		lcd[row][0] = ""
		split(row_str, lcd[row], "")
	}

	ORS=""
}

{
	# Indirect function calls
	command = $1
	switch(NF) {
	case 2:
		@command($2)
	break
	case 5:
		@command($2,$3,$5)
	break
	}
}

function rect(dimensions) {
	split(dimensions, dims, "x")
	width =  dims[1]
	height = dims[2]
	print "draw rectangle, width: " width " height: " height "\n"

	for (rx=1; rx<=width; ++rx) {
		for (ry=1; ry<=height; ++ry) {
			if (ispixel(rx,ry)) lcd[ry][rx] = 1
		}
	}
}

function rotate(rowcol,n,amount) {
	# input is zero indexed
	xy = substr(n,3,1) + 1
	print "rotate " rowcol ": " xy " by " amount "\n"

	# Barrel shift
	# y = (x << shift) | (x >> (width - shift));
	if (rowcol == "row") {
		for (col in lcd[xy]) x = x lcd[xy][col]
		x = bin2dec(x)
		print dec2bin(rshift(x,6), screen_width) "\n"
		new_row = or(lshift(x,amount),rshift(x,(screen_width-amount)))
		split(new_row, lcd[xy], "")
	}
}

function ispixel(x,y) {
	return (x<=screen_width && x>0 && y<=screen_height && y>0) ? 1 : 0
}

END {
	# Output visually
	for (row in lcd) {
		for (col in lcd[row]) print lcd[row][col];
		print "\n"
	}

	# Count of lit pixels
}

# bin2dec(binary_string), returns decimal equivalent
# ex: bin2dec("10011001") -> 153
#
function bin2dec(b,n,i,d) {
	n = length(b)
	d = 0
	for (i=1; i<=n; i++) {
		d += d # d = d*2
		if (substr(b, i, 1) == "1")
			d++
	}
	return d
}

# dec2bin(decimal_integer), returns the equivalent binary string
# ex: dec2bin(202) -> 11001010
function dec2bin(d,padwidth) {
	do {
		b = "" d%2 b
		d = int(d/2)
	} while (length(b)<padwidth);
	return b
}

# http://cgd.sdf-eu.org/a/libs/awk/binary.awk

