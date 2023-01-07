"""
Prepare> Data Structures> Linked Lists> Print the Elements of a Linked List
https://www.hackerrank.com/challenges/print-the-elements-of-a-linked-list/problem
This is an to practice traversing a linked list. Given a pointer to the head node of a linked list, print each node's  element, one per line. 
If the head pointer is null (indicating the list is empty), there is nothing to print.
Function Description
  Complete the printLinkedList function in the editor below.
  printLinkedList has the following parameter(s):
  - SinglyLinkedListNode head: a reference to the head of the list
Print
  For each node, print its `data` value on a new line (console.log in Javascript).
"""


# SinglyLinkedListNode 에 대해 유튜브에서 공부를 하고와서, 만들어보았다.
# https://www.youtube.com/watch?v=79OmVgeNoUY

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

# Complete the printLinkedList function below.

#
# For your reference:
#
# SinglyLinkedListNode:
#     int data
#     SinglyLinkedListNode next
#

# iterative한 방법
def printLinkedList(head):
    crnt = head
    while crnt is not None:
        print(crnt.data)
        crnt = crnt.next # head 는 정말 첫 번째 노드를 가리키는 것이다. 다음 노드를 가르키도록 next 지정.

# 강의를 보고 따라한 recursive한 방법인데 이건 안먹음
# def printLinkedList(head):
#     print(head.data)
#     if head.next is not None:
#         print(head.next)


if __name__ == '__main__':
    llist_count = int(input())

    llist = SinglyLinkedList()

    for _ in range(llist_count):
        llist_item = int(input())
        llist.insert_node(llist_item)

    printLinkedList(llist.head)



# 도저히 풀지 못하겠었다. 이전에도 SinglyLinkedListNode 이런 객체 문제가 나왔어서 풀다가 중단했었던 기억이 있는데, 또 그런 문제이다.
# 풀이를 보고 이해해보도록 하려고 했다.

"""다른 풀이"""

# by.hanumant_jadhav1 : head.next 가 비어있지 않을 경우, data를 읽는다. 그리고 head는 다음 데이터가 된다. 반복을 하는데 왜 print 가 또 아래 있는지 모르겠다.
def printLinkedList(head):
      while (head.next is not None):
          print(head.data)
          head = head.next
      print(head.data)


# by.cherithreddy2002 : ...? 
def printLinkedList(head):
    temp=head
    while temp:
        print(temp.data)
        temp=temp.next
  # or : 위의 풀이와 같은 방식이다. 
def printLinkedList(head):
    temp=head
    while temp.next!=None:
         print(temp.data)
         temp=temp.next
    print(temp.data)


# by. Pjmcnally: 풀이를 좀 보려고 더 찾아보았다.
def print_list(head):
    if head is not None:
        print(head.data)
        print_list(head.next)
# In this example the function takes a node, checks if it exists and if it does prints the data in that node. 
# Then it runs that same function (print_list) on the next node (node.next). 
# This will keep calling that function inside of itself until it runs out of nodes.

