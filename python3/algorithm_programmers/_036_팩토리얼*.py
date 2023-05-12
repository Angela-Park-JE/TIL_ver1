"""
코딩테스트 연습> 코딩테스트 입문> 팩토리얼(lv0)
문제 설명
  i팩토리얼 (i!)은 1부터 i까지 정수의 곱을 의미합니다. 예를들어 5! = 5 * 4 * 3 * 2 * 1 = 120 입니다. 
  정수 n이 주어질 때 다음 조건을 만족하는 가장 큰 정수 i를 return 하도록 solution 함수를 완성해주세요. 
            i! ≤ n
제한사항
  0 < n ≤ 3,628,800
"""


# 23.05.07
# m은 팩토리얼 값, d는 해당 팩토리얼 떄의 정수 i이다. 
# d-1을 하지 않게 되면 한 번 더 while 문이 돌게 된다. 
# 다른 사람들이 푼 것보고 깨달았는데 수학공부했던 보람이 확실히 있었다. 다른 더 좋은 방법이 있나? 했는데, 조건을 잘 이용한 문제들 말고는 딱히 눈에 들어오는 해답이 없었다.
# 물론 글자 개수가 얼마 안되는게 무조건 좋은 코드는 아니지만, 그래도 알고리즘 공부를 따로 하지 않고도 이정도 만큼 해냈다는 것에서 조금 뿌듯함이 느껴진다.
def solution(n):
    m, d = 1, 0
    while m <= n:
        d += 1 
        m *= d
    return d-1

# 이렇게 해도 같은 결과가 나온다. 1*1은 1이니까.
def solution(n):
    m, d = 1, 1
    while m <= n:
        d += 1 
        m *= d
    return d-1



"""오답노트"""

# 23.05.07
# 바보였다. 나는 해당 정수 미만의 정수들을 곱하는데, 그 곱의 결과가 해당 정수(n) 이하인 값을 찾는 일이라고 착각을 해버렸다. 그래서 해당정수 넣고 인덱스 돌려버렸음.
# 팩토리얼을 했을 때 해당 정수 이하의 값이 나오는 수를 찾는 일인데 말이다.
def solution(n):
    nlist = [j*j for j in [i for i in range(1,n+1)]]
    nlist.append(n)
    nlist.sort()
    
    return nlist[nlist.index(n)-1]



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120848/solution_groups?language=python3

# 김현우 , kti0940 , 강윤수 , 강예빈 외 121 명
# 팩퇴리얼 라이브러리를 가져온 코드
from math import factorial

def solution(n):
    k = 10
    while n < factorial(k):
        k -= 1
    return k

# 차선욱 , 최예주 , cyk122893@gmail.com , 황현근 외 6 명
# 유달리 눈에 띄는 코드. 문제의 조건을 잘 활용했다. 왜냐하면 n은 3,628,800과 같거나 작기 때문에 최대 10!일 수밖에 없다. 그래서 range(1, 12)로 11까지 검사하도록 두었다.
import math

def solution(n):
    answer = 0
    for i in range(1, 12):
        if n < math.factorial(i):
            return i - 1
    return answer

# 김재희
# 맞다 이것도 맞다. 조건을 10! 까지 두었기 때문에 만약 나누었을때 1보다 작으면 중단하고 분모를 1씩 더해간다. 그러다가 나누어지게 되면 해당 분모 -1을 하여 return 다.
def solution(n):
    divider=0
    while 1:
        divider+=1
        if n/divider < 1:
            break
        else:
            n/=divider
    return divider-1
