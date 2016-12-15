#!/usr/bin/env python2
# Hacky pyton thing to find md5sums with repeated characters

import md5
import sys
import re

input = 'ahsbgdzn'
#input = 'abc'
num = 0
count = 0

rep_re_3 = re.compile(r'(.)\1{2}')
rep_re_5 = re.compile(r'(.)\1{4}')

keys_found = 0

found_keys_3 = []
found_keys_5 = []


while True:
    seed = input + str(num)
    m = md5.new()
    m.update(input + str(num))
    hex_string = m.hexdigest()

    for n in xrange(1, 2016):
        m = md5.new()
        m.update(hex_string)
        hex_string = m.hexdigest()

    key_parts_3 = [match.group() for match in rep_re_3.finditer(hex_string)]
    key_parts_5 = [match.group() for match in rep_re_5.finditer(hex_string)]

    if len(key_parts_5) > 0:
        found_keys_5.append((hex_string, key_parts_5[0], num));

    if len(key_parts_3) > 0:
        found_keys_3.append((hex_string, key_parts_3[0], num));

    num += 1
    if (num == 10):
        break


for three in found_keys_3:
    for five in found_keys_5:
        if three[1][0] == five[1][0]:
            diff = five[2] - three[2]
            if diff <= 1000 and diff > 0:
                print diff
                print three

		keys_found += 1

		if keys_found == 64:
                    print three[2]
                    exit(0)


# http://stackoverflow.com/questions/6306098/regexp-match-repeated-characters
