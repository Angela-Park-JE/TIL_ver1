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
