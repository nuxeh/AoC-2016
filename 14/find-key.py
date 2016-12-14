#!/usr/bin/env python2
import md5
import sys
import re

#input = 'ahsbgdzn'
input = 'abc'
num = 0
count = 0

key_first = {}

rep_re_3 = re.compile(r'(.)\1{2}')
rep_re_5 = re.compile(r'(.)\1{4}')

while True:
    m = md5.new()
    m.update(input + str(num))
    hex_string = m.hexdigest()

    key_parts_3 = [match.group() for match in rep_re_3.finditer(hex_string)]
    key_parts_5 = [match.group() for match in rep_re_5.finditer(hex_string)]

    for index, part in enumerate(key_parts_3):
	print input + str(num)
	print hex_string
	print str(index) + ": " + part

	key_first[num] = (hex_string, part);

    for index, part in enumerate(key_parts_5):
	print input + str(num)
	print hex_string
	print str(index) + ": " + part

	for it_num, details in enumerate(key_first):
		pass

    num += 1


# http://stackoverflow.com/questions/6306098/regexp-match-repeated-characters
