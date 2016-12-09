#!/usr/bin/awk -f

BEGIN {
	screen_width  = 7 # 50
	screen_height = 3 # 6
	screen_width  = 50
	screen_height = 6

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
	# Comments begin with #
	if (substr($1,1,1) == "#") next

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
	display()
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
	split(n, xy_a, "=")
	xy = xy_a[2] + 1
	print "rotate " rowcol ": " xy " by " amount "\n"

	# Barrel shift
	# y = (x << shift) | (x >> (width - shift));
	x = ""

	if (rowcol == "row") {
		for (col in lcd[xy]) x = x lcd[xy][col]
		x = bin2dec(x)
		new_row = or(rshift(x,amount),lshift(x,(screen_width-amount)))
		split(dec2bin(new_row,screen_width), lcd[xy], "")
	}
	else if (rowcol == "column") {
		for (row in lcd) x = x lcd[row][xy]

		print x "\n"

		x = bin2dec(x)
		new_col = or(rshift(x,amount),lshift(x,(screen_height-amount)))

		print dec2bin(new_col,screen_height) "\n"

		split(dec2bin(new_col,screen_height), new_col_a, "")
		for (row in lcd) {
			lcd[row][xy] = new_col_a[row]
			print "row: " row " xy: " xy " val: " new_col_a[row] "\n"
		}
	}
}

function ispixel(x,y) {
	return (x<=screen_width && x>0 && y<=screen_height && y>0) ? 1 : 0
}

function display() {
	for (row in lcd) {
		for (col in lcd[row]) print lcd[row][col];
		print "\n"
	}
}

END {
	# Output visually
	for (row in lcd) {
		for (col in lcd[row]) {
			print lcd[row][col];
			if (lcd[row][col]) count++
		}
		print "\n"
	}

	# Count of lit pixels
	print "count of lit pixels: " count "\n"
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
function dec2bin(d,padwidth,b) {
	do {
		b = "" d%2 b
		d = int(d/2)
	} while (length(b)<padwidth);
	return b
}

# http://cgd.sdf-eu.org/a/libs/awk/binary.awk

