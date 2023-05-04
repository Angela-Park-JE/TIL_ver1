"""
코딩테스트 연습> 코딩테스트 입문> 문자열 정렬하기 (1)(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120850
문제 설명
  문자열 my_string이 매개변수로 주어질 때, my_string 안에 있는 숫자만 골라 오름차순 정렬한 리스트를 return 하도록 solution 함수를 작성해보세요.

제한사항
  1 ≤ my_string의 길이 ≤ 100
  my_string에는 숫자가 한 개 이상 포함되어 있습니다.
  my_string은 영어 소문자 또는 0부터 9까지의 숫자로 이루어져 있습니다. 
    입출력 예
      my_string	    result
      "hi12392"	    [1, 2, 2, 3, 9]
      "p2o4i8gj2"	  [2, 2, 4, 8]
      "abcde0"	    [0]
"""



# 23.05.04
# .isdigit() | .isalpha() : 해당 문자가 숫자인지 알파벳인지 불타입을 반환함.
# 정렬: 
  # 뒤집기 : x.reverse()
  # 정렬 : x.sort(reverse = False|True)
# 정렬, 본체 변형 X : y = sorted(x), y = reversed(x) 
def solution(my_string):
    my = [int(x) for x in list(my_string) if x.isdigit()]
    my.sort()
    return my


"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120850/solution_groups?language=python3

# 김현우 , 김종도 , 노력형범재 , gusjo 외 308 명
# 맞네 sorted() 안에 리스트를 넣어버리면 끝이었던 것이었어요.
def solution(my_string):
    return sorted([int(c) for c in my_string if c.isdigit()])

# Sehyeon Jeong , 김동우 , 김태호 , bkang 외 8 명사용 언어: Python3
# filter를 사용하여 my_string에서 하나씩 검사해서 True인 애들을 int로 바꾸어 map으로 반복함.
def solution(my_string):
    return sorted(map(int, filter(lambda s: s.isdigit(), my_string)))
