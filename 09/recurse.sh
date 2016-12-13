#!/bin/bash

# The command:
#
# cat input.txt | ./decompress.awk D=3 | ./decompress.awk D=3 \
# | ./decompress.awk D=3 | ./decompress.awk D=3 | ./decompress.awk D=3 \
# | ./decompress.awk D=3 | ./decompress.awk D=3 | wc -c 2>&1 | tee out
#
# gradually fills all 8GB memory... cache each stage in /tmp instead

cat input.txt | ./decompress.awk D=3 > /tmp/decompress

LOOP=1
while true; do
	echo "loop: $LOOP"
	echo "cached size: $(du -h /tmp/decompress)"

	cat /tmp/decompress | ./decompress.awk D=3 > /tmp/decompress2
	mv /tmp/decompress2 /tmp/decompress

	LOOP=$((LOOP+1))
done

# This method still fills all memory and swap, topped out at around 12.2G
# before giving up
