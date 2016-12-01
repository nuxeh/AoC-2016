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
	print "original: " direction
	direction--
	print "decrement: " direction
	if (direction < 0) { direction = -direction };
	print "fix sign: " direction
	direction %= 4;
	print "mod: " direction
	#print "turning left";
}
function turn_right() {
	--direction;
	direction = (direction + (direction++) % 4);
	print "turning right";
}
function step(n) {
	switch(direction) {
	case 0:
		x += n;
		break
	case 1:
		y += n;
		break
	case 2:
		x -= n;
		break
	case 3:
		y -= n;
		break
	}
}

BEGIN {
	FS=", "
	direction=0
	x=0
	y=0
}
/cheese/ {
	for (i=0; i<=NF; ++i) {
		print $i;
		print substr($i,1,1) " " substr($i,2,2);
		if (substr($i,1,1) == "L") turn_left();
		else if (substr($i,1,1) == "R") turn_right();
		print direction
	}

}
END {
	direction=0;
	for (i=0; i<5; ++i) { turn_left(); print direction }
#	for (i=0; i<5; ++i) { turn_right(); print direction }
}
