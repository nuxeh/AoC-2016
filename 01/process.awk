#!/usr/bin/awk -f

# Direction:
#        0
#        N
#        ▲
#   3W ◄   ► E1
#        ▼
#        S
#        2

BEGIN {
	FS=", "
	direction=0; x=0; y=0;
	crumbs[0] = $i " x:" x " y:" y;
	crumb = 1;
}

function turn_left()  { if (--direction < 0) direction = 3 }
function turn_right() { if (++direction > 3) direction = 0 }
function step(n) {
	for (s=n; s>0; --s) {
		switch(direction) {
		case 0:
			++x;
			break
		case 1:
			++y;
			break
		case 2:
			--x;
			break
		case 3:
			--y;
			break
		}
		print "  " $i " x:" x " y:" y;
		crumbs[crumb++] = $i " x:" x " y:" y;
		print NF
	}
}
function abs(n) { return n < 0 ? -n : n }

{
	for (i=1; i<=NF; ++i) {
		if (substr($i,1,1) == "L") turn_left();
		else if (substr($i,1,1) == "R") turn_right();
		step(substr($i,2,length($i)));
		print $i " x:" x " y:" y;
	}

}

END {
	# Calculate the distance in blocks
	distance = abs(x) + abs(y)
	print "Number of blocks away: " distance " (in " NF " steps)"

	for (c in crumbs) {
		print c ": " crumbs[c]
	}
}
