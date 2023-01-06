"""
Prepare> Algorithms> Implementation> Apple and Orange
https://www.hackerrank.com/challenges/apple-and-orange/problem?isFullScreen=true
Sam's house has an apple tree and an orange tree that yield an abundance of fruit. 
Using the information given below, determine the number of apples and oranges that land on Sam's house.
  In the diagram below:
  - The red region denotes the house, where `s` is the start point, and `t` is the endpoint. 
    The apple tree is to the left of the house, and the orange tree is to its right.
  - Assume the trees are located on a single point, where the apple tree is at point `a`, and the orange tree is at point `b`.
  - When a fruit falls from its tree, it lands `d` units of distance from its tree of origin along the `x`-axis. 
    *A negative value of `d` means the fruit fell `d` units to the tree's left, and a positive value of `d` means it falls `d` units to the tree's right.*
"""


# 문제가 복잡한 경향이 있긴 하지만 간단히 생각했다. 미리 더해놓고 검증하는 것 보다, 각 나무에서 떨어진 정도를 for 문에서 더하기로 하고.
# 한 가지 마음에 걸린건 `for i, j in apples, oranges` 로 쓰고 싶었는데 능력이 딸려서 자꾸 에러가 났다.

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'countApplesAndOranges' function below.
#
# The function accepts following parameters:
#  1. INTEGER s
#  2. INTEGER t
#  3. INTEGER a
#  4. INTEGER b
#  5. INTEGER_ARRAY apples
#  6. INTEGER_ARRAY oranges
#

def countApplesAndOranges(s, t, a, b, apples, oranges):
    # Write your code here
    alist, olist = [], []   # 집으로 떨어졌을 과실의 위치를 담는 리스트
    for i in apples:
        if (i+a >= s) and (i+a <= t):
            alist.append(i)
    for j in oranges:
        if (j+b >= s) and (j+b <= t):
            olist.append(j)
    print(len(alist))
    print(len(olist))
    

if __name__ == '__main__':
    first_multiple_input = input().rstrip().split()

    s = int(first_multiple_input[0])

    t = int(first_multiple_input[1])

    second_multiple_input = input().rstrip().split()

    a = int(second_multiple_input[0])

    b = int(second_multiple_input[1])

    third_multiple_input = input().rstrip().split()

    m = int(third_multiple_input[0])

    n = int(third_multiple_input[1])

    apples = list(map(int, input().rstrip().split()))

    oranges = list(map(int, input().rstrip().split()))

    countApplesAndOranges(s, t, a, b, apples, oranges)



"""다른 풀이"""

# by.riccardovarrazza : 난 언제쯤 이런 풀이를 할 수 있나..ㅠ
print(len([x for x in apples if x >= s-a and x <= t-a]))
print(len([x for x in oranges if x <= t-b and x >= s-b]))


# by.brewjunk : 나와 방식은 같지만 count + 1을 올리는 방식으로 풀이했다.
def countApplesAndOranges(s, t, a, b, apples, oranges):
    apple_count = 0
    orange_count = 0
    for i in apples:
        if (a+i) >=s and (a+i) <=t:
            apple_count += 1
    for i in oranges:
        if (b+i) >=s and (b+i) <= t:
            orange_count += 1
    print(apple_count)
    print(orange_count)


# by.hafiz_muhammad01 : 방식은 역시 같은 로직이지만 lambda 를 활용하여 미리 더하는 과정을 거쳤다.
def countApplesAndOranges(s, t, a, b, apples, oranges):
    a_cord = list(map(lambda x: x + a, apples))
    b_cord = list(map(lambda x: x + b, oranges))
    
    a_count =0
    b_count=0
    for i in a_cord:
        if i in range(s,t+1):
            a_count +=1
    for i in b_cord:
        if i in range(s,t+1):
            b_count +=1
    print(a_count)
    print(b_count)
