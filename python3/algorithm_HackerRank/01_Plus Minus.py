"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 1> Plus Minus
https://www.hackerrank.com/challenges/one-week-preparation-kit-plus-minus/
Given an array of integers, calculate the ratios of its elements that are positive, negative, and zero. 
Print the decimal value of each fraction on a new line with  places after the decimal.
"""


#!/bin/python3

import math
import os
import random
import re
import sys

def plusMinus(arr):
    n = len(arr)
    p, m, z = [], [], []
    for i in arr:
        if i > 0:
            p.append(i)
        elif i < 0:
            m.append(i)
        elif i == 0:
            z.append(i)
    print(len(p)/n, '\n', len(m)/n, '\n', len(z)/n)

if __name__ == '__main__':
    numbers = int(input().strip())
    arr = list(map(int, input().rstrip().split()))
    plusMinus(arr)


    
# 나중에 문제가 또나와서 풀었는데 큰 변화는 없다 (23.01.05) 오히려 이전이 깔끔해보이는 이유는?
def plusMinus(arr):
    # Write your code here
    p, m, z = [], [], []
    n = len(arr)
    for i in arr:
        if i > 0:
            p.append(i)
        elif i < 0:
            m.append(i)
        else:
            z.append(i)
    numbers = len(p), len(m), len(z)
    for i in numbers:
        print(round(i/n, 5))



"""다른 풀이"""

# by.reddyjahnavi : n을 이렇게 지정해주었다. 이게맞나...? 아무튼 len()안쓰고 카운트를 올리는 형식으로, 아래 부분을 안돌려도되는 형식이다... 호오...
n = int(input().strip())
arr = [1 if int(temp)>0 else -1 if int(temp)<0 else 0 for temp in input().strip().split(' ') ]
print("{0:.6f}".format(arr.count(1)/n))
print("{0:.6f}".format(arr.count(-1)/n))
print("{0:.6f}".format(arr.count(0)/n))
