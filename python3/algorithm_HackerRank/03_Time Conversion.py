"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 1> Time Conversion
https://www.hackerrank.com/challenges/one-week-preparation-kit-time-conversion/problem
Given a time in -hour AM/PM format, convert it to military (24-hour) time.
Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
- 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.
"""


#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'timeConversion' function below.
#
# The function is expected to return a STRING.
# The function accepts STRING s as parameter.
#


"""
same problem: 
"""


def timeConversion(s):
    if ('AM' in s)&(s[:2] == '12'):
        time24 = '00' + s[2:8]
    elif ('PM' in s)&(s[:2] != '12'):
        time24 = str(int(s[:2]) + 12) + s[2:8]
    else:
        time24 = s[:8]
    return time24

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    s = input()

    result = timeConversion(s)

    fptr.write(result + '\n')

    fptr.close()


"""오답노트"""

#1
# 런타임 오류라면서 두 개의 케이스에서 안되고 나머지는 다 된다. 
# 심지어 두 개의 케이스 인풋은 `06:40:03AM`, `04:59:59AM` 로 평범하다.
def timeConversion(s):
    daypart = s[-2:]
    if (daypart == 'PM')&(s[:2] == '12'):      # 오후 12시 (이부분을 else와 합쳐버리면 runtime 오류가 하나 더 생긴다.)
        timepart = s[:-2]
    elif (daypart == 'PM')&(s[:2] != '12'):    # 나머지 오후
        timepart = str(int(s[:2])+12) + s[2:-2]
    elif (daypart == 'AM')&(s[:2] == '12'):    # 오전 12시
        timepart = '00' + s[2:-2]
    else:
        timepart == s[:-2]
    return timepart

#1-1 검사 덜쓰기
def timeConversion(s):
    daypart = s[-2:]
    if (daypart == 'PM')&(s[:2] != '12'):
        timepart = str(int(s[:2])+12) + s[2:-2]
    elif (daypart == 'AM')&(s[:2] == '12'):
        timepart = '00' + s[2:-2]
    else:
        timepart == s[:-2]
    return timepart

#2
def timeConversion(s):
    s = str(s)
    daypart = s[-2:]
    if (daypart == 'PM'):
        if (s[:2] == '12'):
            timepart = s[:-2]
        else:
            timepart = str(int(s[:2])+12) + s[2:-2]
    elif (daypart == 'AM'):
        if (s[:2] == '12'):
            timepart = '00' + s[2:-2]
        else:
            timepart == s[:-2]
    return timepart

#3 다 같은 말인데 명시를 해주었다.
def timeConversion(s):
    s = str(s)
    daypart = s[-2:]
    if (daypart == 'PM'):
        if (s[:2] == '12'):
            timepart = s[:-2]
        elif (s[:2] != '12'):
            timepart = str(int(s[:2])+12) + s[2:-2]
    elif (daypart == 'AM'):
        if (s[:2] == '12'):
            timepart = '00' + s[2:-2]
        elif (s[:2] != '12'):
            timepart == s[:-2]
    return timepart

#4 다른 케이스에서 오류가 생기는 오류를 더 만든 마법의 코드... 이지만 바보가 12인지 검사에서 type을 생각을 안했었다.
def timeConversion(s):
    # I teared all elements :( I'm angry!
    hh, mm, sec, daytime = s[0:2], s[3:5], s[6:8], s[8:10]
    if ('AM' in s)&(s[:2] == 12):
        time24 = '00' + s[2:8]
    elif ('PM' in s)&(s[:2] != 12):
        time24 = str(int(s[:2]) + 12) + s[2:8]
    else:
        time24 = s[:8]
    return time24
