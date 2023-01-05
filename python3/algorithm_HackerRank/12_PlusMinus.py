"""
Prepare> Algorithms> Warmup> Plus Minus
https://www.hackerrank.com/challenges/plus-minus/problem?isFullScreen=true
Given an array of integers, calculate the ratios of its elements that are positive, negative, and zero. 
Print the decimal value of each fraction on a new line with `6` places after the decimal.
Note: This challenge introduces precision problems. The test cases are scaled to six decimal places, 
    though answers with absolute error of up to `10^(-4)` are acceptable.
"""


# n입력이 따로 없기에 `n = len(arr)`을 정해주었다.
# 비율이고, 총 6자리이기 떄문에 round 함수로 5자리까지 지정해주었다. 

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'plusMinus' function below.
#
# The function accepts INTEGER_ARRAY arr as parameter.
#

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

if __name__ == '__main__':
    n = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    plusMinus(arr)



"""다른 풀이"""

# by.reddyjahnavi : n을 이렇게 지정해주었다. 이게맞나...? 아무튼 len()안쓰고 카운트를 올리는 형식으로, 아래 부분을 안돌려도되는 형식이다... 호오...
n = int(input().strip())
arr = [1 if int(temp)>0 else -1 if int(temp)<0 else 0 for temp in input().strip().split(' ') ]
print("{0:.6f}".format(arr.count(1)/n))
print("{0:.6f}".format(arr.count(-1)/n))
print("{0:.6f}".format(arr.count(0)/n))
