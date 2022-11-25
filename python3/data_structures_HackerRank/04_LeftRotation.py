"""
Prepare> Data Structures> Arrays> Left Rotation
https://www.hackerrank.com/challenges/array-left-rotation/problem
A left rotation operation on an array of size `n` shifts each of the array's elements 1 unit to the left. 
Given an integer, `d`, rotate the array that many steps left and return the result.
"""


# 문제를 대충 읽었다가, d 숫자로 부터 로테이션된다는 줄 알고 잠시 헤맸다가 다시 문제를 읽고 해결하였다. 바보.


#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'rotateLeft' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. INTEGER d
#  2. INTEGER_ARRAY arr
#

def rotateLeft(d, arr):
    # Write your code
    arr = list(arr)
    # loc = arr.index(d) +1  
    loc = d
    cutpart, remainpart = arr[:loc], arr[loc:]
    return remainpart + cutpart
    
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    first_multiple_input = input().rstrip().split()

    n = int(first_multiple_input[0])

    d = int(first_multiple_input[1])

    arr = list(map(int, input().rstrip().split()))

    result = rotateLeft(d, arr)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()

    
""" 다른 명답 """

# by.anishofficial16 : 사실 이렇게 줄일 수 있다는 것이다. ㅎ
def rotateLeft(d, arr):
    # Write your code here
    return arr[d:] + arr[:d]
