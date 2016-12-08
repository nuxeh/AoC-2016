#!/bin/bash
git ct -m "`pwd -P | awk 'BEGIN{FS="/"}{print $NF}'`-$(<./n): "
git ct --amend
