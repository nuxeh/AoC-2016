#!/usr/bin/env python2
# Generate a string with fixed input data, concatenated with an increasing
# integer, and checksum the resulting string. Print checksums starting with 5
# zeroes (valid data) and take the 6th character in the string as being a
# character in the password, concatenated in order of discovery into a final
# password string.
#
# Stop after 8 characters if printing to a terminal, or continuously output
# valid checksums if output is redirected.

import md5
import sys

input = 'wtnhxymk'
#input = 'abc'
num = 0
count = 0
password = ""

while True:
    m = md5.new()
    m.update(input + str(num))
    hex_string = m.hexdigest()

    if hex_string[0:5] == '00000':
        password += hex_string[5]

	print hex_string + " " + password
	sys.stdout.flush()

	if len(password) == 8 and sys.stdout.isatty():
            print "Password is: " + password
            exit()

    num += 1
