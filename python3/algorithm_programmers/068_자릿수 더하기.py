# 코딩테스트 연습> 코딩테스트 입문> 자릿수 더하기
# https://school.programmers.co.kr/learn/courses/30/lessons/120906?language=python3
# 정수 n이 매개변수로 주어질 때 n의 각 자리 숫자의 합을 return하도록 solution 함수를 완성해주세요


# 24.07.15
def solution(n):
    answer = sum([int(i) for i in str(n)])
    return answer
