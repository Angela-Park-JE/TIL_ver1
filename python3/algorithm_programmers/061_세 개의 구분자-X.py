"""
코딩테스트 연습> 코딩 기초 트레이닝> 세 개의 구분자
https://school.programmers.co.kr/learn/courses/30/lessons/181862
문제 설명
  임의의 문자열이 주어졌을 때 문자 "a", "b", "c"를 구분자로 사용해 문자열을 나누고자 합니다.
  예를 들어 주어진 문자열이 "baconlettucetomato"라면 나눠진 문자열 목록은 ["onlettu", "etom", "to"] 가 됩니다.
  문자열 myStr이 주어졌을 때 위 예시와 같이 "a", "b", "c"를 사용해 나눠진 문자열을 순서대로 저장한 배열을 return 하는 solution 함수를 완성해 주세요.
  단, 두 구분자 사이에 다른 문자가 없을 경우에는 아무것도 저장하지 않으며, return할 배열이 빈 배열이라면 ["EMPTY"]를 return 합니다.
제한사항
  1 ≤ myStr의 길이 ≤ 1,000,000
  myStr은 알파벳 소문자로 이루어진 문자열 입니다.
"""



# 24.03.03: 드디어 되었다. abc를 모두 한 가지 구분자로 바꾼다음 한번에 자른 뒤 빈문자열 버리고 빈건지 아닌지 고르기!
def solution(myStr):
    # 이 부분은 아래로 대체 될 수 있다. ㅎㅎ
    # strlist = myStr.replace('a', ' ').replace('b', ' ').replace('c', ' ').split(' ')
    for i in range(len(myStr)):
        if myStr[i] in ['a', 'b', 'c']:
            myStr = myStr.replace(myStr[i], '.')
    strlist = myStr.split('.')
  
    strlist[:] = [v for v in strlist if v != ""] # "" 가 아닌 것들만 남기도록 [:] 슬라이싱으로 inplace함
    if len(strlist) != 0:
        return strlist
    else:
        return ['EMPTY']



"""다른 답"""
# 나는 split을 연이어 쓸 순 없지만 replace를 연이어서는 쓸 수 있다는 점을 간과했었다. 
# 김종도 , 김은성 , 탈퇴한 사용자
def solution(myStr):
    answer = [x for x in myStr.replace('a', ' ').replace('b', ' ').replace('c', ' ').split() if x]
    return answer if answer else ['EMPTY']

# 이게 정답이겠다 싶었다.
# LeeShinwon
import re
def solution(myStr):
    answer = [m for m in re.split('a|b|c',myStr) if m]
    if len(answer)==0:
        answer=["EMPTY"]

    return answer



"""오답노트"""
# 24.02.14 : 시간초과가 나온다. a한 것을 또 b를 돌리고 또 c를 돌리는데 당연히 비효율적이라는 것은 예상했지만...
# 어떻게 푸는 게 좋을까
def solution(myStr):
    answer = myStr.split('a')    # 리스트 반환
    
    lists = []
    for i in answer:             # 하나씩 꺼내서 잘라야하기에 for문을 썼는데..
        s = i.split('b')
        lists = lists + s
    
    lists2 = []
    for j in lists:
        s = j.split('c')
        lists2 = lists2 + s
    
    lists2[:] = [value for value in lists2 if value != ""] # "" 가 아닌 것들만 남기도록 [:] 슬라이싱으로 inplace함
    if len(lists2) != 0:
        return lists2
    else:
        return ['EMPTY']
