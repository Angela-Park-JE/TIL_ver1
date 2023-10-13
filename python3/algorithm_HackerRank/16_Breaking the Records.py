"""
Prepare> Algorithms> Implementation> Breaking the Records
https://www.hackerrank.com/challenges/breaking-best-and-worst-records/problem?isFullScreen=true
Maria plays college basketball and wants to go pro. Each season she maintains a record of her play. 
She tabulates the number of times she breaks her season record for most points and least points in a game. 
Points scored in the first game establish her record for the season, and she begins counting from there.
> Example
    Scores are in the same order as the games played. She tabulates her results as follows:
    
                                         Count
        Game  Score  Minimum  Maximum   Min Max
         0      12     12       12       0   0
         1      24     12       24       0   1
         2      10     10       24       1   1
         3      24     10       24       1   1
    Given the scores for a season, determine the number of times Maria breaks her records for most and least points scored during the season.
> Returns
    int[2]: An array with the numbers of times she broke her records. Index  is for breaking most points records, and index  is for breaking least points records.
"""


# 231009: 리턴논타입 때문에 잠깐 패닉빠졌던 나를 반성하며... 시간 날때 다시 깔끔하게 리스트 컴프리핸션으로 만들어보기
#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'breakingRecords' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts INTEGER_ARRAY scores as parameter.
#

def breakingRecords(scores):
    # Write your code here : return jebal please return not print!
    min, max = [scores[0]], [scores[0]]
    for i in scores:
        if i < min[-1]:
            min.append(i)
        if i > max[-1]:
            max.append(i)
    # most and least
    return (len(max)-1, len(min)-1)
    
    # also this works
    # min, max = [scores[0]], [scores[0]]
    # m, M = 0, 0
    # for i in scores:
    #     if i < min[-1]:
    #         min = [i]
    #         m += 1
    #     if i > max[-1]:
    #         max = [i]
    #         M += 1
    # return(M, m)
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    scores = list(map(int, input().rstrip().split()))

    result = breakingRecords(scores)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
