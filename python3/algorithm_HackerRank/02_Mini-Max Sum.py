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
