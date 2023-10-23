"""
Prepare> Algorithms> Implementation> Subarray Division
https://www.hackerrank.com/challenges/the-birthday-bar/problem?isFullScreen=true
Two children, Lily and Ron, want to share a chocolate bar. Each of the squares has an integer on it.
> Lily decides to share a contiguous segment of the bar selected such that:
  The length of the segment matches Ron's birth month, and,
  The sum of the integers on the squares is equal to his birth day.
Determine how many ways she can divide the chocolate.
> Function Description
  `birthday()` has the following parameter(s):
  int s[n]: the numbers on each of the squares of chocolate
  int d: Ron's birth day
  int m: Ron's birth month
> Returns
  int: the number of ways the bar can be divided
"""



#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'birthday' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER_ARRAY s
#  2. INTEGER d
#  3. INTEGER m
#

"""
# 231022
def birthday(s, d, m):
    # Write your code here

    # the choco length is month m : 초코나눈 길이는 m이고
    # the choco square number's sum is day d : 초코에 그려진 숫자 합은 d인 케이스를 찾아야 한다.
    
    for i in range(len(s)-(m-1)):
        # repeate m times s[i+ ...]
        # s[i] m부터 번만큼 하나씩 인덱스 이동해서 더한 값이 choco인데 이게 d와 같으면 count를 하나씩 올리는 식으로 하면 된다.
        choco = s[i]+s[i+...] # repeate m times s[i+ ...]
"""

"""# 231023"""
def birthday(s, d, m):

    cnt = 0
    for i in range(len(s)-(m-1)):
        choco_num = 0
        choco_num += s[i]
        for times in range(1, m):
            choco_num += s[i+times]
        if choco_num == d:
            cnt += 1
        else:
            continue
    
    return cnt


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = list(map(int, input().rstrip().split()))

    first_multiple_input = input().rstrip().split()

    d = int(first_multiple_input[0])

    m = int(first_multiple_input[1])

    result = birthday(s, d, m)

    fptr.write(str(result) + '\n')

    fptr.close()
