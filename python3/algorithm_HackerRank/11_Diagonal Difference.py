"""
Prepare> Algorithms> Warmup> Diagonal Difference
https://www.hackerrank.com/challenges/diagonal-difference/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen
Given a square matrix, calculate the absolute difference between the sums of its diagonals.
For example, the square matrix `arr` is shown below:
1 2 3
4 5 6
9 8 9  
Function description
  Complete the `diagonalDifference` function in the editor below.
  diagonalDifference takes the following parameter:
  int arr[n][m]: an array of integers
Sample Input
  3
  11 2 4
  4 5 6
  10 8 -12
Sample Output
  15
"""



# 개발자가 아니니 로직만 연습한다는 생각으로 풀고, sum을 사용했다.


#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'diagonalDifference' function below.
#
# The function is expected to return an INTEGER.
# The function accepts 2D_INTEGER_ARRAY arr as parameter.
#

def diagonalDifference(arr):
    # Write your code here
    # for i in range(len(arr)**(1/2)) : arr is list of list. 몇 행렬이든 상관없이 가능하다.
    ltr, rtl, k = [], [], len(arr)
    for i in range(k):
        ltr.append(arr[i][i])
        rtl.append(arr[i][k-1-i])
    return abs(sum(ltr)-sum(rtl))

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    arr = []

    for _ in range(n):
        arr.append(list(map(int, input().rstrip().split())))

    result = diagonalDifference(arr)

    fptr.write(str(result) + '\n')

    fptr.close()
