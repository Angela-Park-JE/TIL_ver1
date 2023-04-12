"""
코딩테스트 연습> 연습문제> 크기가 작은 부분 문자열
https://school.programmers.co.kr/learn/courses/30/lessons/147355
문제 설명
  숫자로 이루어진 문자열 t와 p가 주어질 때, t에서 p와 길이가 같은 부분문자열 중에서, 이 부분문자열이 나타내는 수가 p가 나타내는 수보다 작거나 같은 것이 나오는 횟수를 return하는 함수 solution을 완성하세요.
  예를 들어, t="3141592"이고 p="271" 인 경우, t의 길이가 3인 부분 문자열은 314, 141, 415, 159, 592입니다. 이 문자열이 나타내는 수 중 271보다 작거나 같은 수는 141, 159 2개 입니다.
제한사항
  1 ≤ p의 길이 ≤ 18
  p의 길이 ≤ t의 길이 ≤ 10,000
  t와 p는 숫자로만 이루어진 문자열이며, 0으로 시작하지 않습니다.
"""

# 난 바보였어 왜 i:i+2 해놓고 멍때리고 있었지 n을 더하려고 일부러 구해놓고...
def solution(t, p):
    answer = 0
    n = len(p)
    if n == 1:
        for i in range(len(t)):
            if t[i] <= p:
                answer += 1
    else:
        for i in range(len(t)-n+1):
            parts = t[i:i+n]
            if parts <= p:
                answer += 1
    return answer


"""오답노트"""

# 1
# 4분 만에 풀은 방식인데, p의 길이대로 슬라이싱한 후, 슬라이싱된 해당 수가 p보다 작은지 검사하여 카운트를 올린다.
# 문제는 p가 1개일때 제대로 되지 않았다. 
def solution(t, p):
    answer = 0
    n = len(p)
    for i in range(len(t)-n+1):
        parts = t[i:i+2]
        if parts <= p:
            answer +=1
    return answer

# 2
# if로 n ==1 일 때를 검사해서 따로 검사했는데 이것도 제대로 되지 않았다 ㅎㅎ....
def solution(t, p):
    answer = 0
    n = len(p)
    if n == 1:
        for i in range(len(t)):
            if t[i] <= p:
                answer += 1
    else:
        for i in range(len(t)-n+1):
            parts = t[i:i+2]
            if parts <= p:
                answer += 1
    return answer
