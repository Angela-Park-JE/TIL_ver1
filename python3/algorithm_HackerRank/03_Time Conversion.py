"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 1> Time Conversion
https://www.hackerrank.com/challenges/one-week-preparation-kit-time-conversion/problem
Given a time in -hour AM/PM format, convert it to military (24-hour) time.
Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
- 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.
"""
# 런타임 오류라면서 두 개의 케이스에서 안되고 나머지는 다 된다. 
# 심지어 두 개의 케이스 인풋은 `06:40:03AM`, `04:59:59AM` 로 평범하다.

#!/bin/python3
import math
import os
import random
import re
import sys

#
# Complete the 'timeConversion' function below.
# The function is expected to return a STRING.
# The function accepts STRING s as parameter.

def timeConversion(s):
    daypart = s[-2:]
    if (daypart == 'PM')&(s[:2] == '12'):      # 오후 12시
        timepart = s[:-2]
    elif (daypart == 'PM')&(s[:2] != '12'):    # 나머지 오후
        timepart = str(int(s[:2])+12) + s[2:-2]
    elif (daypart == 'AM')&(s[:2] == '12'):    # 오전 12시
        timepart = '00' + s[2:-2]
    else:
        timepart == s[:-2]
    return timepart

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')
    s = input()
    result = timeConversion(s)
    fptr.write(result + '\n')
    fptr.close()
