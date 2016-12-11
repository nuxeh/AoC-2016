#!/usr/bin/env python2

# The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
# The second floor contains a hydrogen generator.
# The third floor contains a lithium generator.
# The fourth floor contains nothing relevant.

items = {'HM': 1, 'LM': 1,
	 'HG': 2,
	 'LG': 3}

import operator

class Elevator(object):
	current_floor = 1

class Item(object):
	name

	def __init__(name):



def display():
	floor = 1
	for item in sorted(items.iteritems(), key=operator.itemgetter(1)):
		if item[1] == floor:
			print item[0],
		else:
			floor += 1
			print
			print item[0],


elevator = Elevator.new()


display()

