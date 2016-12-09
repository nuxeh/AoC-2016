#!/usr/bin/awk -f

BEGIN {
	RS=/\([:digit:]+x[:digit:]+\)/
}

{
	print RT
	print $0
}
