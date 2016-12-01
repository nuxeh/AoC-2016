#!/usr/bin/awk -f

# Direction:
#        0
#        N
#        ▲
#   3W ◄   ► E1
#        ▼
#        S
#        2

function turn_left() {
	(--direction) % 3;
}
function turn_right() {
	(++direction) % 3;
}

BEGIN {
	FS=", "
	direction=0
	x=0
	y=0
}
{
	for (i=0; i<=NF; ++i) {
		print $i;
		print substr($i,1,1) " " substr($i,2,2);
	}

}
END {
}
