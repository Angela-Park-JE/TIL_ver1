"""
Prepare> Data Structures> Arrays> Sparse Arrays
https://www.hackerrank.com/challenges/sparse-arrays/problem?isFullScreen=true
There is a collection of input strings and a collection of query strings. 
For each query string, determine how many times it occurs in the list of input strings. Return an array of the results.

Function Description
Complete the function matchingStrings in the editor below. 
The function must return an array of integers representing the frequency of occurrence of each query string in stringList.
  matchingStrings has the following parameters:
  - string stringList[n] - an array of strings to search
  - string queries[q] - an array of query strings
Returns
  int[q]: an array of results for each query
"""


# 이렇게 하면 될 것이라는 생각을 먼저 해두고, 몇 번의 시도를 한 후에 test case를 통과하여 submit을 했으나 다른 여러 10/13개가 실패했다.
# 그리고 설마? 해서 출력값을 딕셔너리의 values가 아니라, 리스트로 저장한 후 리스트를 return하도록 했더니 다른 테스트 케이스에서도 되었다.
#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'matchingStrings' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. STRING_ARRAY stringList
#  2. STRING_ARRAY queries
#

def matchingStrings(stringList, queries):
    # Write your code here
    
    # 방법1. queries를 키로 가지는 딕셔너리를 만든 다음 값들을 0이 되도록 두었다. 그리고 값을 순회하면서 count를 올리도록 한다. return은 딕셔너리.values()
    # test case에서는 되었지만 submit에서 실패한다.
    # queDict = dict.fromkeys(queries, 0)
    # for i in queries:
    #     for j in stringList:
    #         if j == i:
    #             queDict[i] += 1
    #         else:
    #             pass
    # return queDict.values()
    
    # 방법2. queries를 키로 가지는 딕셔너리를 만드는 것 까지는 방법1과 같지만, 리스트 내 개수를 세는 리스트.count() 함수를 써서, 딕셔너리 값으로 저장하고 return 딕셔너리.values()
    # 이것도 test case에서는 되었지만 submit에서는 실패했다.
#     counter = dict.fromkeys(queries, 0)
#     for v in queries:
#         cnt = stringList.count(v)
#         counter[v] = cnt
#     return counter.values()

    # 방법3. queries 요소 개수 만큼 0을 원소로 가지는 counter라는 리스트를 만든다. (count가 0이면 0을 출력해주면 좋겠지만 오류가 날 수도 있기 때문에)
    # 실제로 counter = [] 라고만 지정하면 런타임에러가 난다.
    # queries로 range를 만든 다음, queries의 각 원소의 인덱스와 counter의 인덱스가 일치하는 위치에 count(queries 원소)를 저장하도록 했다.
    # why this works?
    counter = [0] * len(queries)
    for i in range(len(queries)):
        v = queries[i]
        counter[i] = stringList.count(v)       
    return counter    
            

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    stringList_count = int(input().strip())

    stringList = []

    for _ in range(stringList_count):
        stringList_item = input()
        stringList.append(stringList_item)

    queries_count = int(input().strip())

    queries = []

    for _ in range(queries_count):
        queries_item = input()
        queries.append(queries_item)

    res = matchingStrings(stringList, queries)

    fptr.write('\n'.join(map(str, res)))
    fptr.write('\n')

    fptr.close()

"""다른 풀이"""

# by.hemayatullahari1 : https://www.hackerrank.com/challenges/sparse-arrays/forum/comments/1248775
# 나와 비슷하지만(?) 더 심플하게 줄인 형태. 배울점이 많다.
def matchingStrings(stringList, queries):
    result = []
    
    for i in queries:
        result.append(stringList.count(i))
    
    return result


# by.ndaterao2 : https://www.hackerrank.com/challenges/sparse-arrays/forum/comments/1249812
# Counter함수를 썼다.
# supersimple이라는데 이정도면 supersimple 맞다고 생각. 
# 하지만 Counter는 따로 import 해야하는 함수이다. 런타임에러가 나오는 것으로 보아하니 그런 문제를 간과한 것 같다.
# 앞에 `from collections import Counter`를 해주어야 한다. 
def matchingStrings(stringList, queries):
 
    yup = Counter(stringList)
    
    results = []
    for q in queries:
        results.append(yup[q])
    return results 
