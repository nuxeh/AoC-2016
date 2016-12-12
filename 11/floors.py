#!/usr/bin/env python2

# The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.	# 1,1 2,1
# The second floor contains a hydrogen generator.						# 1,2
# The third floor contains a lithium generator.							# 2,2
# The fourth floor contains nothing relevant.

items = {'HM': 1, 'LM': 1,
	 'HG': 2,
	 'LG': 3}

import operator

class Elevator(object):

	def __init__(self):
		self.current_floor = 1
		self.items = []

	def add_item(self, item):
		if len(items) < 2:
			self.items.append(item)

	def deposit_item(self, index, floor):
		pass

class Floor(object):

	def __init__(self, num):
		self.num = num
		self.items = []

	def add_item(self, item):
		self.items.append(item)

	def remove_item(self, item_id):
		for index, item in enumerate(self.items):
			if item.item_id == item_id:
				del self.items[index]

	def __str__(self):
		string = "Floor " + str(self.num) + " | "
		for item in self.items:
			string += str(item) + " "
		return string

class Item(object):
	item_id = ""
	item_class = 0
	item_type = 0

	def __init__(self, item_class, item_type):
		self.item_class = item_class
		self.item_type = item_type

	def __str__(self):
		return str(self.item_class) + "_" + str(self.item_type)


def display():
	for floor in floors:
		if floor == elevator.current_floor:
			print "*",
		else:
			print " ",
		print floors[floor]


elevator = Elevator()
#print elevator.current_floor

floors = {1:Floor(1), 2:Floor(2), 3:Floor(3), 4:Floor(4)}

floors[1].add_item(Item(1,1))
floors[1].add_item(Item(2,1))
floors[2].add_item(Item(1,2))
floors[3].add_item(Item(2,2))



display()

