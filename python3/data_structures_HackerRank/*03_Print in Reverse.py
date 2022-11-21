""" 
I can't solve this problem ....... especially the class `SinglyLinkedListNode`. Someone used `head`, but I don't know why we 'can' use it.
so I decided to refer to the other's answers and grow up by theirs.

Prepare> Data Structures> Linked Lists> Print in Reverse
https://www.hackerrank.com/challenges/print-the-elements-of-a-linked-list-in-reverse/problem
Given a pointer to the head of a singly-linked list, print each `data` value from the reversed list. 
If the given list is empty, do not print anything.
"""


"""현답들"""

# by.iambanker 
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


# by.tameem1361
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

