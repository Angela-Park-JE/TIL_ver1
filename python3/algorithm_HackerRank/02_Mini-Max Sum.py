"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 1> Mini-Max Sum
https://www.hackerrank.com/challenges/one-week-preparation-kit-mini-max-sum/
Given five positive integers, find the minimum and maximum values that can be calculated by summing exactly four of the five integers. 
Then print the respective minimum and maximum values as a single line of two space-separated long integers.
"""

# 원래대로라면 arr.sort() 한 후 첫 번째를 지우고, 마지막을 지운 것으로 최대와 최소 값을 구하려 했다.
# max 와 min, 그리고 sum 을 사용할 수 있기 때문에 간단해졌다.

#!/bin/python3
import math
import os
import random
import re
import sys

def miniMaxSum(arr):
    arrmin, arrmax = arr.copy(), arr.copy()
    arrmin.remove(max(arr))
    arrmax.remove(min(arr))
    min_sum, max_sum = sum(arrmin), sum(arrmax)
    print(min_sum, max_sum)

if __name__ == '__main__':
    arr = list(map(int, input().rstrip().split()))
    miniMaxSum(arr)

    
"""
같은 문제인데 정말 깔끔하게 이 과정을 정리하신 분이 계셨다...
그냥 합을 구해놓고 한쪽은 가장 큰 것을 지우고, 한쪽은 가장 작은 것을 지우면 될 일을...
https://www.hackerrank.com/challenges/mini-max-sum/problem
"""

# by. for_andrey_luky1 - https://www.hackerrank.com/challenges/mini-max-sum/forum/comments/1266345
# Pythonista. Sorting has O( n*log(n) ) time complexity in compare with O( n ) for min() and max() funcitons. It make sence for big data.
def miniMaxSum(arr):
    s = sum(arr)
    print(f"{s-max(arr)} {s-min(arr)}")
