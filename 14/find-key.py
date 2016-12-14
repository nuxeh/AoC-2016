#!/usr/bin/env python2
import md5
import sys
import re

def dump_keys():
    for key in key_first:
        print str(key) + ": " + key_first[key][0] + " " + key_first[key][1]

#input = 'ahsbgdzn'
input = 'abc'
num = 0
count = 0

key_first = {}

rep_re_3 = re.compile(r'(.)\1{2}')
rep_re_5 = re.compile(r'(.)\1{4}')

keys_found = 0

while True:
    seed = input + str(num)
    m = md5.new()
    m.update(input + str(num))
    hex_string = m.hexdigest()

    key_parts_3 = [match.group() for match in rep_re_3.finditer(hex_string)]
    key_parts_5 = [match.group() for match in rep_re_5.finditer(hex_string)]

    for index, part in enumerate(key_parts_5):
	for key in sorted(key_first):
	    if key_first[key][1] == part[0:3]:
                print "original  " + hex_string

                keys_found += 1
                print("found key " + key_first[key][0] + " at " + str(input +
                      str(key)) + " num: " + str(num))
                print str(keys_found) + " keys found"
                dump_keys()

            raw_input()

    for index, part in enumerate(key_parts_3):
	key_first[num] = (hex_string, part);

    num += 1


# http://stackoverflow.com/questions/6306098/regexp-match-repeated-characters
