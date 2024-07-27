# 코딩테스트 연습> 코딩 기초 트레이닝> 공배수
# https://school.programmers.co.kr/learn/courses/30/lessons/181936
#   정수 number와 n, m이 주어집니다. number가 n의 배수이면서 m의 배수이면 1을 아니라면 0을 return하도록 solution 함수를 완성해주세요.


# 24.07.27: 쉬운 문제이다. 하지만 이와 비슷한 어려운 문제가 있었다. 
def solution(number, n, m):
    if (number%n == 0) and (number%m == 0):
        answer = 1
    else:
        answer = 0
    return answer
