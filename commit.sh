#!/bin/bash
git ct -m "`date +%d`-$1: "
git ct --amend
