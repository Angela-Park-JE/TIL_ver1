"""
코딩테스트 연습> 코딩테스트 입문> 분수의 덧셈
https://school.programmers.co.kr/learn/courses/30/lessons/120808#
문제 설명
  첫 번째 분수의 분자와 분모를 뜻하는 numer1, denom1, 두 번째 분수의 분자와 분모를 뜻하는 numer2, denom2가 매개변수로 주어집니다. 
  두 분수를 더한 값을 기약 분수로 나타냈을 때 분자와 분모를 순서대로 담은 배열을 return 하도록 solution 함수를 완성해보세요.

제한사항
  0 <numer1, denom1, numer2, denom2 < 1,000
"""



"""오답노트"""

# 23.04.14
# 유클리드호제법을 이용하였다. 주어진 분모들의 최대공약수를 찾은 다음, 일반적으로 분수의 덧셈을 한 후 최대공약수로 나누는 형태이다.
# 테스트 케이스는 다 되었으나 문제는 실제 제출 했을때 제대로 되지 않았다. 왜인지 아직 깨닿지 못했다. d1, d2, d3 전부 확인해보았는데...
def solution(numer1, denom1, numer2, denom2):
    # Greatest Common Divisor : Euclidean algorithm
    d2, d1 = denom2, denom1
    # reminder = d2 % d1
    while 1==1:
        d3 = d2 % d1
        if d3 == 0:
            break
        else:
            d2, d1 = d1, d3
    # d1 is GCD
    answer = [(numer1*denom2 + numer2*denom1)/d1, (denom1*denom2)/d1]
    return answer
