"""
코딩테스트 연습> 코딩테스트 입문> 두 수의 나눗셈
https://school.programmers.co.kr/learn/courses/30/lessons/120806
문제 설명
  정수 num1과 num2가 매개변수로 주어질 때, num1을 num2로 나눈 값에 1,000을 곱한 후 정수 부분을 return 하도록 soltuion 함수를 완성해주세요.
제한사항
  0 < num1 ≤ 100
  0 < num2 ≤ 100
"""



# 23.04.13
# 별건 아닌데 적은 이유는 정수 부분을 return 하도록 해서 round(, 0) 함수를 썼었으나 이건 일부에서 실패했다.
# 그도 그럴게, round는 소수점 첫째 자리의 수를 반올림하게 되기 때문에 일부는 정수 부분이 +1이 되어버린다.
# 정수 부분만 잘라서 내놓으라는 것과 같으므로 `TRUNCATE()처럼` int로 잘라버리는 것이 마땅했다. 

def solution(num1, num2):
    answer = int(num1/num2*1000)
    return answer
