#!/bin/bash

# Depends on ubuffer from expect package

echo -n $1 \
| awk 'BEGIN{count=3231928;OFS=""}{while (++count>=0) print $0,count}' \
| stdbuf -oL -eL awk '{ORS=""; cmd="md5sum"; print $0 | cmd; close(cmd)}' \
| awk '{ORS=""; if (substr($1,1,5) == "00000") print substr($1,6,1) "\n"}'
