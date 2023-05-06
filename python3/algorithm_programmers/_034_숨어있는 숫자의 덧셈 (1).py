"""
코딩테스트 연습> 코딩테스트 입문> 숨어있는 숫자의 덧셈 (1)(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120851
문제 설명
  문자열 my_string이 매개변수로 주어집니다. my_string안의 모든 자연수들의 합을 return하도록 solution 함수를 완성해주세요.

제한사항
  1 ≤ my_string의 길이 ≤ 1,000
  my_string은 소문자, 대문자 그리고 한자리 자연수로만 구성되어있습니다.
"""


# 23.05.06
# num_list를 정해주지 않아도 되긴 하지만... 왜인지 모르게 바로 return으로 돌려버리는 일은 뭔가 불안하다.
def solution(my_string):
    num_list = sum([int(i) for i in list(my_string) if i.isdigit()])
    return num_list

"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120851/solution_groups?language=python3

# 노력형범재 , gusjo , 김진영 , 조창범 외 308 명
# list를 만들지도 않고 sum안에 넣어버렸다. 이렇게도 가능하구나 싶었다...
def solution(my_string):
    return sum(int(i) for i in my_string if i.isdigit())

# 아이코홍 , cjswoxorb@gmail.com , 코딩하니 , kunha98 외 6 명
# int로 바꾸어진다면 더하고, 그렇지 않다면 pass한다. 오류에 대해 명시를 해주는 이런 코드가 좋다.
def solution(my_string):
    answer = 0
    for i in my_string:
        try:
            answer = answer + int(i)
        except:
            pass

    return answer
