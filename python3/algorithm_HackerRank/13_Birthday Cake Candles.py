"""
Prepare> Algorithms> Warmup> Birthday Cake Candles
https://www.hackerrank.com/challenges/birthday-cake-candles/problem?isFullScreen=true
You are in charge of the cake for a child's birthday. 
You have decided the cake will have one candle for each year of their total age. 
They will only be able to blow out the tallest of the candles. Count how many candles are tallest.
Example 
  `candles = [4, 4, 1, 3]`
  The maximum height candles are `4` units high. There are `2` of them, so return `2`.
"""


# max나 count를 쓰고 싶지 않았던 것이다. max는 써버렸다...

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'birthdayCakeCandles' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY candles as parameter.
#

def birthdayCakeCandles(candles):
    # Write your code here
    m = max(candles) # 가장 큰 값 꺼내놓고
    hlist = [n for n in candles if n==m] # 큰 값과 같은 것 list comprehension으로 추리고
    return len(hlist) # 길이!
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    candles_count = int(input().strip())

    candles = list(map(int, input().rstrip().split()))

    result = birthdayCakeCandles(candles)

    fptr.write(str(result) + '\n')

    fptr.close()
