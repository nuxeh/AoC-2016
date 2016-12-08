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

	# Barrel shift
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
	xy = substr(n,3,1)
	print "rotate " rowcol ": " xy " by " amount "\n"

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

