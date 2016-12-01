#!/usr/bin/awk -f
BEGIN {
	FS=", "
}
{
	for (i=0; i<=NF; ++i) {
		print $i;
		print substr($i,1,1) " " substr($i,2,2);
	}

}
END {
}
