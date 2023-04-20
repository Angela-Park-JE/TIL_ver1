"""
코딩테스트 연습> 코딩테스트 입문> 짝수 홀수 개수
https://school.programmers.co.kr/learn/courses/30/lessons/120824
문제 설명
  정수가 담긴 리스트 num_list가 주어질 때, num_list의 원소 중 짝수와 홀수의 개수를 담은 배열을 return 하도록 solution 함수를 완성해보세요.
제한사항
  1 ≤ num_list의 길이 ≤ 100
  0 ≤ num_list의 원소 ≤ 1,000
"""



# 23.04.20
def solution(num_list):
    e, o = 0, 0
    for i in num_list:
        if i%2 ==0:
            e += 1
        else:
            o += 1
    return [e, o]
