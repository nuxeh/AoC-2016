#!/bin/bash

# Depends on ubuffer from expect package

echo -n $1 \
| awk 'BEGIN{count=3231928;OFS=""}{while (++count>=0) print $0,count}' \
| unbuffer -p awk '{ORS=""; cmd="md5sum"; print $0 | cmd; close(cmd)}' \
| awk '{print NR " " substr($1,1,5)}'
