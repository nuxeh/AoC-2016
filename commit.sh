#!/bin/bash
git ct -m "`pwd -P | awk 'BEGIN{FS="/"}{print $NF}'`-`cat ./n`: "
git ct --amend
