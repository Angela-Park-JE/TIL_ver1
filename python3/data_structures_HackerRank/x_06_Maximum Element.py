"""
Prepare> Data Structures> Stacks> Maximum Element
https://www.hackerrank.com/challenges/maximum-element/problem?isFullScreen=true
You have an empty sequence, and you will be given  queries. Each query is one of these three types:
    1 x  -Push the element x into the stack.
    2    -Delete the element present at the top of the stack.
    3    -Print the maximum element in the stack.
Function Description
    Complete the getMax function in the editor below.
    getMax has the following parameters:
    - string operations[n]: operations as strings
Returns
    - int[]: the answers to each type 3 query
"""



"""해결중"""
# 240205
# 살짝 바꾸어보았는데 (주어진 문자열을 다 숫자형으로 바꾸지 않고 바로 검사) 이래도 time out이 된다...
def getMax(operations):
    # Write your code here
    thelist = []
    printit = []
    for i in operations:
        if i[0] == '1':
            thelist.append(int(i[2:]))
        elif i[0] == '2':
            del thelist[-1]
        elif i[0] == '3':
            printit.append(max(thelist))

    return printit



# 처음(23.02.28)
# 기본적인 예제 데이터에 대해서는 해결이되었으나, 10000개 이상의 데이터에 대해서는 느리게 작동하여 Time out이 적용되었다.
# 코드를 조금 더 효율적으로 짜라고 하는데 어떻게 해야할지 조금 더 고민해봐야겠다.

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'getMax' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts STRING_ARRAY operations as parameter.
#

def getMax(operations):
    # Write your code here
    thelist = []
    printit = []
    for i in operations:
        numbers = list(map(int, i.split(" ")))
        if numbers[0] == 1:
            thelist.append(numbers[1])
        elif numbers[0] == 2:
            if len(thelist) > 0: 
                del thelist[-1]
            else:
                pass
        elif numbers[0] == 3:
            if len(thelist) > 0: 
                printit.append(max(thelist))
            else:
                pass
    return printit
            

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    ops = []

    for _ in range(n):
        ops_item = input()
        ops.append(ops_item)

    res = getMax(ops)

    fptr.write('\n'.join(map(str, res)))
    fptr.write('\n')

    fptr.close()




"""연습장"""
# 리스트에 숫자를 맵핑하는 함수로 여기를 참고했다.
# https://www.hackerrank.com/challenges/maximum-element/forum/comments/1225177

# 첫번째 if문에서 새로 들어온게 맥스인가 미리 검사하려고 해도 미리 검사하면 미리 검사하는대로 문제가 생긴다.
        if numbers[0] == 1:
            thelist.append(numbers[1])
            if numbers[1] > maxone: # set the max in advance.
                maxone = numbers[1] 
            # thelist.sort(reverse = True)
        elif numbers[0] == 2:
            if len(thelist) > 0: 
                del thelist[-1]
            else:
                pass
        elif numbers[0] == 3:
            if len(thelist) > 0: 
                printit.append(maxone)
                # printit.append(max(thelist))
