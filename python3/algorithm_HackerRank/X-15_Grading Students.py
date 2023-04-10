"""
"""


# 나에게는 무슨 문제가 있는 걸까. 객체에 대한 이해가 안되어있어서 그런지도 모르겠는데
# 로직은 짜는게 가능한데, 코드에서 막힌다.

#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the 'gradingStudents' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts INTEGER_ARRAY grades as parameter.
#





"""다른 답안 참고"""
def gradingStudents(grades):
    # Write your code here
    # grades = list(grades)
    # for i in grades:
    #     if i%5>2 and i>=40:
    #         (i+5-(i%5))
    #     else:
    #         i 
    # what the..........
    
    
    # by.melodicdata
    r = []
    for grade in grades:
        diff = 5 - grade%5
        if grade >= 38 and diff < 3:
            grade += diff
        r.append(grade)
    return r
  
    # by. ovidiuborze
    return [(i+5-(i%5)) if (i%5>2 and i>=38) else i for i in grades]


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    grades_count = int(input().strip())

    grades = []

    for _ in range(grades_count):
        grades_item = int(input().strip())
        grades.append(grades_item)

    result = gradingStudents(grades)

    fptr.write('\n'.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
