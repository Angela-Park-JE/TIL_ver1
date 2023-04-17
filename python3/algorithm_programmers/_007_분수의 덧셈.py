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



  # 23.04.17
  # 이번에는 왜 안되는지 다양한 테스트 케이스를 넣어보았다. 
  # 일단 분자가 분모의 배수일 때를 넣었다가 점수가 33->47 로 상승했고, (case1)
  # 그리고 주어지는 분수 자체가 기약분수가 아닐 때가 있었다. 그래서 100, 10, 10, 100 을 넣어 테스트 하도록 하여 걸러졌다. (case2)
  # case2에서 case1이 걸러지므로 주석으로 지워뒀다.
  def solution(numer1, denom1, numer2, denom2):
    
    ## Greatest Common Divisor : Euclidean algorithm
    d2, d1 = denom2, denom1
    # reminder = d2 % d1
    while 1==1:
        d3 = d2 % d1
        if d3 == 0:
            break
        else:
            d2, d1 = d1, d3
    
    ## d1 is GCD
    answer = [(numer1*denom2 + numer2*denom1)/d1, (denom1*denom2)/d1]
    
    # ## case1: Numerator is denominator's multiple.
    # if answer[0] % answer[1] == 0:
    #     answer = [answer[0]/answer[1], 1]
    # else:
    #     pass
    
    ## case2: Numerator and denominator has other common multiple
    if answer[0] > answer[1]:
        d2, d1 = answer[0], answer[1]
    else:
        d2, d1 = answer[1], answer[0]

    # d2, d1 = denom2, denom1
    while 1==1:
        d3 = d2 % d1
        if d3 == 0:
            break
        else:
            d2, d1 = d1, d3
    answer = [answer[0]/d1, answer[1]/d1]
    return answer
