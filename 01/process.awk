#!/usr/bin/awk
BEGIN {
	FS=","
}
{
for (i=0; i<=NF; ++i) print $i;
}
END {
}
