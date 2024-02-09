"""
코딩테스트 연습> 코딩테스트 입문> 최댓값 만들기 (2)
https://school.programmers.co.kr/learn/courses/30/lessons/120862#
문제 설명
  정수 배열 numbers가 매개변수로 주어집니다. numbers의 원소 중 두 개를 곱해 만들 수 있는 최댓값을 return하도록 solution 함수를 완성해주세요.
제한사항
  -10,000 ≤ numbers의 원소 ≤ 10,000
  2 ≤ numbers 의 길이 ≤ 100
"""



# 24.02.10: 결국 최대가 음수라면 0이 최댓값으로 배출되어서는 아니된다! 그리고 변수 정의 안하려고 안간힘 썼다.
def solution(numbers):
    # 음수 양수 둘 뿐이라면 답은 음수가 된다.
    if (len(numbers) == 2)&(numbers[0] * numbers[1] <0):
        return numbers[0]*numbers[1]
    else:   # 일반적 양수일때, 음수끼리의 곱이 클떄, 0이 최대일때
        return max([sorted(numbers)[-1] * sorted(numbers)[-2], sorted(numbers)[0] * sorted(numbers)[1], 0])



"""오답노트"""

# 24.01.24: 가볍게 풀려고 시작했는데 생각보다 안풀렸다. 일일히 해보는 방식이 싫어서 했는데 케이스를 나누는게 잘못된 것 같다.
def solution(numbers):
    s1 = sorted(numbers)[-1] * sorted(numbers)[-2] # 일반적 순서로 곱한 답
    
    minus = []
    for i in numbers:
        if i < 0:
            minus.append(i*(-1))            # 음수 추출
    s2 = 0
    if len(minus)>=2:
        s2 = sorted(minus)[-1] * sorted(minus)[-2]  # 음수가 2개이상일 때 음수의 절댓값이 가장 큰 값끼리 곱한 답
    else:
        if 0 in numbers:    # [양수, 0, 음수], [양수, 0]
            pass
        else:
            s2 = s1         # [양수, 음수]
    
    # 생각해보니 [320, 0, -2, -4] 뭐 이런 거있을 수 있을텐데
    return max([s1, s2, 0])
