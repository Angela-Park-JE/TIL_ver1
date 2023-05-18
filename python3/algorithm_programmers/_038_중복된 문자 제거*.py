"""
코딩테스트 연습> 코딩테스트 입문> 중복된 문자 제거(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120888
문제 설명
  문자열 my_string이 매개변수로 주어집니다. my_string에서 중복된 문자를 제거하고 하나의 문자만 남긴 문자열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ my_string ≤ 110
  my_string은 대문자, 소문자, 공백으로 구성되어 있습니다.
  대문자와 소문자를 구분합니다.
  공백(" ")도 하나의 문자로 구분합니다.
  중복된 문자 중 가장 앞에 있는 문자를 남깁니다.
"""



"""풀이"""
# 23.05.18
# set을 이용하는 방법은 안됨. 순서가 보존되지 않는다.
# 내가 효율적인 방법으로 쉽게 풀 수 있을거란 생각이 안들어서, 잠시 시도하다가 빠르게 찾아봄: [https://11001.tistory.com/81]
# 라이브러리를 불러오지 않고 그대로 쓸 수 있는 방법은 이것으로, my_string의 문자열 하나하나를 key로 하여 딕셔너리를 만드는데, 
# 딕셔너리를 만들때 순서가 보존되기 때문에 쓸 수 있다. 
def solution(my_string):
    strings = ''.join(dict.fromkeys(my_string))
    return strings
