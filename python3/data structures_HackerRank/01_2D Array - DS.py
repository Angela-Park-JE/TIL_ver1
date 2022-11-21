"""
Prepare> Data Structures> Arrays> 2D Array - DS
https://www.hackerrank.com/challenges/2d-array/problem
There are 16 hourglasses in `arr`. An hourglass sum is the sum of an hourglass' values. 
Calculate the hourglass sum for every hourglass in `arr`, then print the maximum hourglass sum. The array will always be 6*6.
* Example
  arr = 
  -9 -9 -9  1 1 1 
   0 -9  0  4 3 2
  -9 -9 -9  1 2 3
   0  0  8  6 6 0
   0  0  0 -2 0 0
   0  0  1  2 4 0
  The 16 hourglass sums are:
  -63, -34, -9, 12, 
  -10,   0, 28, 23, 
  -27, -11, -2, 10, 
    9,  17, 25, 18
  The highest hourglass sum is 28 from the hourglass beginning at row 1, column 2:
  0 4 3
    1
  8 6 6
* Function Description
  Complete the function hourglassSum in the editor below.
  hourglassSum has the following parameter(s): int arr[6][6]: an array of integers
"""

# omg, I solved it too easily. :) Let's keep care about the `range(len(arr) - hourglass_size +1 )` 

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'hourglassSum' function below.
#
# The function is expected to return an INTEGER.
# The function accepts 2D_INTEGER_ARRAY arr as parameter.
# example hourglass structure: arr[0][0], arr[0][1], arr[0][2], arr[1][1], arr[2][0], arr[2][1], arr[2][2]

def hourglassSum(arr):
    # Write your code here
    array = arr.copy()
    hourglass_size = 3      # size of hourglass = 3x3
    for i in range(len(array[0])- hourglass_size +1):
        for j in range(len(array[0]) - hourglass_size +1):
            x1, x2, x3 = array[i][j], array[i][j+1], array[i][j+2]
            x4 = array[i+1][j+1]
            x5, x6, x7 = array[i+2][j], array[i+2][j+1], array[i+2][j+2]
            total = sum([x1, x2, x3, x4, x5, x6, x7])
            if (i,j) == (0,0):
                t = total
            else:
                if total>= t:
                    t = total
                else:
                    t = t
    return t

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    arr = []

    for _ in range(6):
        arr.append(list(map(int, input().rstrip().split())))

    result = hourglassSum(arr)

    fptr.write(str(result) + '\n')

    fptr.close()
