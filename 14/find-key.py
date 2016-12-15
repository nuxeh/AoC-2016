#!/usr/bin/env python2
# Hacky pyton thing to find md5sums with repeated characters

import md5
import sys
import re

def dump_keys(arr):
    for key in sorted(arr):
        print str(key) + ":\t" + arr[key][0] + " " + key_first[key][1]

input = 'ahsbgdzn'
input = 'abc'
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

    key_parts_3 = [match.group() for match in rep_re_3.finditer(hex_string)]
    key_parts_5 = [match.group() for match in rep_re_5.finditer(hex_string)]

    for index, part in enumerate(key_parts_5):
	found_keys_5.append((hex_string, part, num));

    for index, part in enumerate(key_parts_3):
	found_keys_3.append((hex_string, part, num));


    num += 1
    if (num == 100000):
        break


for three in found_keys_3:
    print three

for five in found_keys_5:
    print five

if False:


    for key in sorted(key_first):
        hash_str  = key_first[key][0]
        match     = key_first[key][1]
    
        if match == part[0:3] and (num - key) <= 1000:
            print "original  " + hex_string + " diff: " + str(num - key)
    
            keys_found += 1
    
            print("found key " + hash_str + " at " + str(input +
                  str(key)) + " num: " + str(num))
     
            print str(keys_found) + " keys found " + str(len(found_keys)) 
    
            if key in found_keys.keys():
                print "dupe!!"
                #found_keys[str(key) + "_"] = hash_str
    		#else:
            found_keys[key] = hash_str
    
            #dump_keys()
            dump_keys_found()
    
            if len(found_keys) > 64+1:
                print "Found 64 keys at index: " + str(key)
                exit(0)
            #break
    
        raw_input()

# http://stackoverflow.com/questions/6306098/regexp-match-repeated-characters
