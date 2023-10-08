
# https://www.hackerrank.com/challenges/breaking-best-and-worst-records/problem?isFullScreen=true



#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'breakingRecords' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts INTEGER_ARRAY scores as parameter.
#

def breakingRecords(scores):
    # Write your code here : return jebal please return not print!
    min, max = [scores[0]], [scores[0]]
    for i in scores:
        if i < min[-1]:
            min.append(i)
        if i > max[-1]:
            max.append(i)
    # most and least
    return (len(max)-1, len(min)-1)
    
    # also this works
    # min, max = [scores[0]], [scores[0]]
    # m, M = 0, 0
    # for i in scores:
    #     if i < min[-1]:
    #         min = [i]
    #         m += 1
    #     if i > max[-1]:
    #         max = [i]
    #         M += 1
    # return(M, m)
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    scores = list(map(int, input().rstrip().split()))

    result = breakingRecords(scores)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
