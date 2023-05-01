"""
코딩테스트 연습> 코딩테스트 입문> 점의 위치 구하기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120841
문제 설명
  사분면은 한 평면을 x축과 y축을 기준으로 나눈 네 부분입니다. 사분면은 아래와 같이 1부터 4까지 번호를매깁니다.
    x 좌표와 y 좌표가 모두 양수이면 제1사분면에 속합니다.
    x 좌표가 음수, y 좌표가 양수이면 제2사분면에 속합니다.
    x 좌표와 y 좌표가 모두 음수이면 제3사분면에 속합니다.
    x 좌표가 양수, y 좌표가 음수이면 제4사분면에 속합니다.
  x 좌표 (x, y)를 차례대로 담은 정수 배열 dot이 매개변수로 주어집니다. 좌표 dot이 사분면 중 어디에 속하는지 1, 2, 3, 4 중 하나를 return 하도록 solution 함수를 완성해주세요.
제한사항
  dot의 길이 = 2
  dot[0]은 x좌표를, dot[1]은 y좌표를 나타냅니다
  -500 ≤ dot의 원소 ≤ 500
  dot의 원소는 0이 아닙니다.
"""


# 23.04.29
# x, y를 따로 정해주지 않아도 되긴 하지만 또 다른 데이터 형태가 주어질 경우 수정이 용이할 것이다. (여러 dot라던가)
def solution(dot):
    x, y = dot[0], dot[1]
    if x >0:
        if y >0:
            return 1
        else:
            return 4
    else:
        if y >0:
            return 2
        else:
            return 3

"""다른 풀이"""

# https://school.programmers.co.kr/learn/courses/30/lessons/120841/solution_groups?language=python3

# juu , DoubleDeltas , bhnvx , 김현성 외 9 명
# T/F 를 이용하여 값이 0 혹은 1로 나오는 것을 이용한 답이다. 엄청 현명하다...
def solution(dot):
    quad = [(3,2),(4,1)]
    return quad[dot[0] > 0][dot[1] > 0]


# ji , ch200203 , 좌타공인 , jhighllight
# 사분면 특성을 가지고 아예 수식을 만들었다. 
def solution(dot):
    a, b = 1, 0
    if dot[0]*dot[1] > 0:
        b = 1
    if dot[1] < 0:
        a = 2
    return 2*a-b


# 노력형범재 , 윤은지 , 황인섭 , 홍종민 외 10 명
# 일반적인 논리를 가지고 return 을 만들었는데, if else 문을 한 줄에 적어 넣는 기술이라니... 배워야한다.
def solution(dot):
    x,y = dot
    if x*y>0:
        return 1 if x>0 else 3
    else:
        return 4 if x>0 else 2
