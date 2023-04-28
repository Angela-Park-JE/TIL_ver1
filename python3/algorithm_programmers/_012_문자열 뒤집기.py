"""
코딩테스트 연습> 코딩테스트 입문> 문자열 뒤집기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120822
문제 설명
  문자열 my_string이 매개변수로 주어집니다. my_string을 거꾸로 뒤집은 문자열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ my_string의 길이 ≤ 1,000
"""



# 23.04.17
# 이번엔 직관적으로 인덱스를 직접 음수로 돌도록 하여, string을 붙이도록 해두었다.
 def solution(my_string):
    answer = ''
    for i in range(1, len(my_string)+1):
        answer = answer + my_string[-i]
    return answer
