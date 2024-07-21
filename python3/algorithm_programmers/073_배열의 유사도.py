# 코딩테스트 연습> 코딩테스트 입문> 배열의 유사도
# https://school.programmers.co.kr/learn/courses/30/lessons/120903
#   두 배열이 얼마나 유사한지 확인해보려고 합니다. 문자열 배열 s1과 s2가 주어질 때 같은 원소의 개수를 return하도록 solution 함수를 완성해주세요.


# 24.07.22
def solution(s1, s2):
    l = [c for c in s1 for d in s2 if c==d]
    return len(l)

# 원래는 이런 방식이고 한 줄로 요약하였다.
def solution(s1, s2):
    answer = 0
    for c in s1:
        for d in s2:
            if c==d:
                answer +=1
    return answer
