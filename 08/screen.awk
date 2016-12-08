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
	print $0 "\n"

	# Indirect function calls
	command = $1
	switch(NF) {
	case 2:
		@command($2)
	break
	case 3:
		@command($2,$3)
	break
	case 4:
		@command($2,$3,$4)
	break
	}
}

function rect(dimensions) {
	split(dimensions, dims, "x")
	width =  dims[1]
	height = dims[2]
	print "draw rectangle, width: " width " height: " height "\n"
}

function rotate() {

}

END {
	# Output visually
	for (row in lcd) {
		for (col in lcd[row]) print lcd[row][col];
		print "\n"
	}

	# Count of lit pixels
}

