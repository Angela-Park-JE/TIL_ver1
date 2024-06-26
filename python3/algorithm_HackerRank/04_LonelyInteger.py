"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 2> Lonely Integer
https://www.hackerrank.com/challenges/one-week-preparation-kit-lonely-integer/problem
Given an array of integers, where all elements but one occur twice, find the unique element.
* Example
  `a = [1, 2, 3, 4, 3, 2, 1]`
  The unique element is `4`.
* Function Description
  Complete the lonelyinteger function in the editor below.
  lonelyinteger has the following parameter(s) : int a[n]: an array of integers
* Returns
  int: the element that occurs only once
* Input Format 
  The first line contains a single integer, `n`, the number of integers in the array.
  The second line contains `n` space-separated integers that describe the values in `a`.
"""

#!/bin/python3
import math
import os
import random
import re
import sys

# `list`.count(`elements`) 
def lonelyinteger(a):
    for i in a:
       times= a.count(i)
       if times ==1:
        return i
    return


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    a = list(map(int, input().rstrip().split()))

    result = lonelyinteger(a)

    fptr.write(str(result) + '\n')

    fptr.close()



"""오답노트"""

""" what I thought first, but it return `None` """
def lonelyinteger(a):
    ar = list(a)
    dic = dict.fromkeys(ar)
    for k in dic.keys():
        dic[k] = int(0)
    for i in ar:
        dic[i] = dic[i] + 1
    for k, v in dic.items():
        if v < 2:
            print(k)

""" other ways, but it return `None` too.. """
def lonelyinteger(a):
    ar = list(a)
    zeros = [0] * n
    dic = dict(zip(ar, zeros)) 
    for i in ar:
        dic[i] = dic[i] + 1
    for k, v in dic.items():
        if v < 2:
            print(k) 

""" used searching by `if` but... `None` too. """
def lonelyinteger(a):
    dic = dict()
    for i in a:
        if i not in dic.keys():
            dic[i] = 1
        else:
            dic[i] = dic[i] +1
    for k, v in dic.items():
        if v < 2:
            print(k)
