"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 2> Diagonal Difference
https://www.hackerrank.com/challenges/one-week-preparation-kit-diagonal-difference/problem
Given a square matrix, calculate the absolute difference between the sums of its diagonals.
* Function Description
  int arr[n][m]: an array of integers
* Returns
  int: the absolute diagonal difference
"""

# numpy의 전치행렬을 이용하면 훨씬 쉬워지지만 그것을 사용하지 않기 위해선 어찌하는 게 좋을지 고민했다.
# 홀수 짝수를 나누는 것보다 각 경우를 연산으로 인덱스를 정하는게 좋았다. 
# 그리고 문제를 풀고 return 안쓰는 버릇 좀 고치세요?

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

def diagonalDifference(arr):
    l_to_r = []
    r_to_l = []
    for i in range(n):
        # left-to-right
        j = i
        l_to_r.append(arr[i][j])
        # right-to-left
        k = (n-1) - i
        r_to_l.append(arr[i][k])
    abs_value = abs(sum(l_to_r) - sum(r_to_l))
    return abs_value


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    arr = []

    for _ in range(n):
        arr.append(list(map(int, input().rstrip().split())))

    result = diagonalDifference(arr)

    fptr.write(str(result) + '\n')

    fptr.close()



"""오답노트"""

# n이 홀수일 때와 짝수일 때를 나누어서, 각각 left-to-right, right-to-left 를 나누어 리스트를 만들려고 했으나 right-to-left가 되지 않는다
def diagonalDifference(arr):
    l_to_r = []
    r_to_l = []
    for i in range(n):
        for j in range(n):
            if n%2 == 0:
                if i == j:
                    l_to_r.append(arr[i][j])
                elif i+j == n:
                    r_to_l.append(arr[j][i])
            elif n%2 == 1:
                if i == j:
                    l_to_r.append(arr[i][j])
                elif (i+j == n)|(i == j):
                    r_to_l.append(arr[j][i])


    
"""다른답안들"""
# 풀고나니 정말 좋은 답들이 많았다.

# by.rcpallavi2019
# 리스트를 활용하지 않고 바로 합을 만든다음 마지막에 abs로 연산을 끝낸다.
def diagonalDifference(arr):
    # Write your code here
    left, right = 0, 0
    for i in range(n):
        left += arr[i][i]
        right += arr[i][(n - 1) - i]  # arr[i][-i-1]로 한 풀이도 있었다.
    return abs(left - right)

# by. jleeee
# for문을 돌면서 연산을 바로 수행하도록 하는 코드. 오른쪽-왼쪽 대각선 행렬의 인덱스는 뒤에서 부터 찾도록 `-`를 사용했다. 정말 깔끔하다.
def diagonalDifference(arr):    
    output = 0         
    for x in range(len(arr)): 
        output += arr[x][x]
        output -= arr[x][-(x + 1)]
       
    return abs(output)
