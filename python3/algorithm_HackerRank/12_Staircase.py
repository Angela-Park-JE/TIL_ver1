"""
Prepare> Algorithms> Warmup> Staircase
https://www.hackerrank.com/challenges/staircase/problem
This is a staircase of size `n = 4`:
   #
  ##
 ###
####
Its base and height are both equal to `n`. It is drawn using # symbols and spaces. The last line is not preceded by any spaces.
Write a program that prints a staircase of size `n`.
"""


# 처음에 로직 짤 때 i를 그대로 사용하고 아래에는 `# * (i+1)` 을 했었는데 한 칸이 더 비는 문제가 자꾸 생겼다.
# 재미있는 건 공백 부분을 고정을 해두면 반대 모양 별이 생겨~

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'staircase' function below.
#
# The function accepts INTEGER n as parameter.
#

def staircase(n):
    # Write your code here
    for i in range(0, n):
        i = i+1
        print(' '*(n-i)+'#'*(i))

if __name__ == '__main__':
    n = int(input().strip())

    staircase(n)
