#!/bin/bash

echo -n $1 \
| awk 'BEGIN{count=-1;OFS=""}{while (++count>=0) print $0,count}' \
| awk '{cmd="md5sum"; print $0 | cmd; close(cmd)}'
