"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 2> Counting Sort 1
https://www.hackerrank.com/challenges/one-week-preparation-kit-countingsort1/problem
* Comparison Sorting
  Quicksort usually has a running time of `n * log n`, but is there an algorithm that can sort even faster? 
  In general, this is not possible. Most sorting algorithms are comparison sorts, i.e. they sort a list just by comparing the elements to one another. 
  A comparison sort algorithm cannot beat `n * log n` (worst-case) running time, since `n * log n` represents the minimum number of comparisons needed to know where to place each element. 
  For more details, you can see these notes (PDF).
* Alternative Sorting
  Another sorting method, the counting sort, does not require comparison. 
  Instead, you create an integer array whose index range covers the entire range of values in your array to sort. 
  Each time a value occurs in the original array, you increment the counter at that index. 
  At the end, run through your counting array, printing the value of each non-zero valued index that number of times.
* Example
  `arr = [1,1,3,2,1]`
  All of the values are in the range `[0,...,3]`, so create an array of zeros, `result = [0,0,0,0]`. 
  The results of each iteration follow:
  --i	arr[i]	result--
    0	  1	    [0, 1, 0, 0]
    1	  1	    [0, 2, 0, 0]
    2	  3	    [0, 2, 0, 1]
    3	  2	    [0, 2, 1, 1]
    4	  1	    [0, 3, 1, 1]
  The frequency array is . These values can be used to create the sorted array as well: `sorted = [1,1,1,2,3] `.
* Note
  For this exercise, always return a frequency array with 100 elements. 
  The example above shows only the first 4 elements, the remainder being zeros.

* Challenge
  Given a list of integers, count and return the number of times each value appears as an array of integers.

* Function Description
  Complete the countingSort function in the editor below.
  countingSort has the following parameter(s):
  - arr[n]: an array of integers
* Returns
  - int[100]: a frequency array
"""

# Don't worry about the explanation. The longer words, the simpler problem. 
# 문제를 읽으며 우려했던것과 달리, 다음날 앉아서 막상 보니 어렵지 않게 풀었다.
# n의 역할에 대해 잠시 헷갈렸으나 바로 어디서 틀렸는지 확인하고 해결.
# 딕셔너리를 이용하는 방법이다. 요소가 숫자가 아닐 때에도-인덱스를 그대로 이용할 수 없는 상황- 사용할 수 있다.


#!/bin/python3
import math
import os
import random
import re
import sys


def countingSort(arr):
    # n is numbers, and elements is 0~99.
    range_ele = range(0, 100, 1)
    dic_arr = dict.fromkeys(range_ele, 0)  # can switch like this: dic_arr = {i : 0 for i in arr_range}
    for j in arr:
        dic_arr[j] = dic_arr[j] + 1
    return dic_arr.values()

  
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    result = countingSort(arr)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()

    
""" 다른 풀이들 """

# by.bmacho
# 인덱스를 요소 그대로 이용할 수 있는 점을 착안하여 0으로 된 리스트를 만들어놓고 사용
# 매우 간단하게 해결할 수 있다는 장점이 있지만 숫자가 아닌 인덱스의 경우 어렵다.
def countingSort(arr):
    sol=[0]*100  # creates an array filled with 0s
    for a in arr : 
        sol[a] += 1
    return sol


# by.kartheekanand
# 리스트 컴프리헨션으로 count()를 하는 방식이다.
# if문으로 결점을 검사할 수도 있도록 되어있다. 어차피 숫자 어레이의 길이는 n과 같고 즉 그것은 len(arr)과 같기 때문에 간단한 방식인듯.
# 리스트 컴프리헨션이 아직도 익숙하지 않기 때문에 신기한 풀이.
def countingSort(arr):
  # Write your code here
  a=[ arr.count(i) for i in range(len(arr)) if i>=0 and i<100 ]
  return a
