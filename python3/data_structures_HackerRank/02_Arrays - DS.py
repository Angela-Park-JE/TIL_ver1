"""
Prepare> Data Structures> Arrays> Arrays - DS
https://www.hackerrank.com/challenges/arrays-ds/problem
An array is a type of data structure that stores elements of the same type in a contiguous block of memory. 
Reverse an array of integers.
* Example
  A = [1,2,3]
  Return [3,2,1].
"""

# easy peasy :3

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'reverseArray' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts INTEGER_ARRAY a as parameter.
#

def reverseArray(a):
    # Write your code here
    starts = list(a)
    ends = []
    for i in range(len(starts)):
        end_number = starts.pop(-1)
        ends.append(end_number)
    return ends

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    arr_count = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    res = reverseArray(arr)

    fptr.write(' '.join(map(str, res)))
    fptr.write('\n')

    fptr.close()

    
"""다른 방법"""

# by.mikecwikielnik : so... easy peasy lemon squeezy for him...
def reverseArray(a):
    return a[::-1]
