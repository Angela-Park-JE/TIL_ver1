"""
Prepare> Data Structures> Stacks> Maximum Element
https://www.hackerrank.com/challenges/maximum-element/problem?isFullScreen=true
"""

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'getMax' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts STRING_ARRAY operations as parameter.
#

def getMax(operations):
    # Write your code here
    operations = list(operations)
    thelist = []
    for i in operations:
        if i[0] ==1:
            number = i.split(' ')
            thelist.append(number[1])
            thelist.sort(reverse = True)
        elif i[0] ==2:
            del thelist[0]
        elif i[0] ==3:
            print(thelist[0])
            

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    ops = []

    for _ in range(n):
        ops_item = input()
        ops.append(ops_item)

    res = getMax(ops)

    fptr.write('\n'.join(map(str, res)))
    fptr.write('\n')

    fptr.close()
