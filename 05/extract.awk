#!/usr/bin/awk -f

BEGIN {FS=""; count=0; ORS=""}

{
	print $6 $7 "\n"
	if ($6 > 0 && $6 <= 7) {
		print "good\n"
		a[count] = $7
		if (++count == 8)
			exit
	}
}

END{
	for (i in a)
		print a[i]
	print "\n"
}
