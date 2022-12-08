""" 
I can't solve this problem ....... especially the class `SinglyLinkedListNode`. Someone used `head`, but I don't know why we 'can' use it.
so I decided to refer to the other's answers and grow up by theirs.

Prepare> Data Structures> Linked Lists> Print in Reverse
https://www.hackerrank.com/challenges/print-the-elements-of-a-linked-list-in-reverse/problem
Given a pointer to the head of a singly-linked list, print each `data` value from the reversed list. 
If the given list is empty, do not print anything.
"""

""" 채 하지못한 나의  """

#!/bin/python3

import math
import os
import random
import re
import sys

class SinglyLinkedListNode:
    def __init__(self, node_data):
        self.data = node_data
        self.next = None

class SinglyLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None

    def insert_node(self, node_data):
        node = SinglyLinkedListNode(node_data)

        if not self.head:
            self.head = node
        else:
            self.tail.next = node


        self.tail = node

def print_singly_linked_list(node, sep):
    while node:
        print(node.data, end='')

        node = node.next

        if node:
            print(sep, end='')

#
# Complete the 'reversePrint' function below.
#
# The function accepts INTEGER_SINGLY_LINKED_LIST llist as parameter.
#

#
# For your reference:
#
# SinglyLinkedListNode:
#     int data
#     SinglyLinkedListNode next
# first number is number of cases
# second number is number of first case's integer
#

def reversePrint(llist):
    ar = []
    while llist:
        ar.append(llist.data)
        llist = llist.next
    for _ in ar[::-1]:
        print(_)
    return 
        
        
        
    return llist
if __name__ == '__main__':
    tests = int(input())

    for tests_itr in range(tests):
        llist_count = int(input())

        llist = SinglyLinkedList()

        for _ in range(llist_count):
            llist_item = int(input())
            llist.insert_node(llist_item)

        reversePrint(llist.head)



"""현답들"""

# by.iambanker : recursive solution
def ReversePrint(head):
    if head:
        ReversePrint(head.next)
        print(head.data)


# by.AffineStructure
def ReversePrint(head):
    if head is None:
        return None
    else:
        stack = []
        while head:
            stack.append(head.data)
            head = head.next
        while stack:
            print(stack.pop())


# by.khoai345678
# recursive python solution
def reversePrint(llist):
    if llist is None:
        return
    reversePrint(llist.next)
    print(llist.data)

# or
def reversePrint(llist):
    ar = []
    while llist:
        ar.append(llist.data)
        llist = llist.next
    for _ in ar[::-1]:
        print(_)


# by.tameem1361 : alike with `by.AffineStructure` but little different
def reversePrint(llist):
    head=llist
    if llist is None:
        return
    else:
        arr1=[]
        while head:
            arr1.insert(0,head.data)
            head=head.next
        for i in arr1:
            print(i)
