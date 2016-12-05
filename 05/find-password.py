#!/usr/bin/env python2

import md5

input = 'abc'
num = 3231928
count = 0
password = ""

while True:
    m = md5.new()
    m.update(input + str(num))
    hex_string = m.hexdigest()

    if hex_string[0:5] == '00000':
        password += hex_string[5]
	print hex_string + " " + password
	if len(password) == 8:
            print "Password is: " + password
            exit()

    num += 1
