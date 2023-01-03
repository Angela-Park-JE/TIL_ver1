"""
Prepare> Algorithms> Warmup> Simple Array Sum
https://www.hackerrank.com/challenges/simple-array-sum/problem?isFullScreen=true
Given an array of integers, find the sum of its elements.
Complete the simpleArraySum function in the editor below. It must return the sum of the array elements as an integer.
simpleArraySum has the following parameter(s):
ar: an array of integers

Output Format
Print the sum of the array's elements as a single integer.
  Sample Input
  6
  1 2 3 4 10 11
  Sample Output
  31
"""


#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'simpleArraySum' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY ar as parameter.
#

def simpleArraySum(ar):
    # Write your code here
    s = 0
    for i in ar:
        s = s + i
    return s

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    ar_count = int(input().strip())

    ar = list(map(int, input().rstrip().split()))

    result = simpleArraySum(ar)

    fptr.write(str(result) + '\n')

    fptr.close()

    
# 뭐 대충 이런 쿨한 방법도 있을 수 있다.
def simpleArraySum(ar):
    # Write your code here
    s = sum(ar)
    return s

# 있어보이는 척도 가능하다.
def simpleArraySum(ar):
    # Write your code here
    s = sum([0 + i for i in ar])
    return s
