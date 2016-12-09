#!/usr/bin/awk -f

BEGIN {
	RS="\\([0-9]+x[0-9]+\\)"
}

{
	print rt_last
	print $0

	rt_last = RT
}
