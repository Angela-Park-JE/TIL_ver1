"""
코딩테스트 연습> 코딩 기초 트레이닝> a와 b 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/181951
정수 a와 b가 주어집니다. 각 수를 입력받아 입출력 예와 같은 형식으로 출력하는 코드를 작성해 보세요.
제한사항
  -100,000 ≤ a, b ≤ 100,000
입력 #1
  4 5
출력 #1
  a = 4
  b = 5
"""



# 23.12.11: print(f{})를 배웠기 때문에 더 깔끔하고 쉽게 할 수 있었던 것. 간단한 문제이지만 간단할 수록 잊으면 안된다.
a, b = map(int, input().strip().split(' '))
# your code
print(f'a = {a}\nb = {b}')




"""
코딩테스트 연습> 코딩 기초 트레이닝> 문자열 반복해서 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/181950
문자열 str과 정수 n이 주어집니다.
str이 n번 반복된 문자열을 만들어 출력하는 코드를 작성해 보세요.
제한사항
  1 ≤ str의 길이 ≤ 10
  1 ≤ n ≤ 5
입력 #1
  string 5
출력 #1
  stringstringstringstringstring
"""



# 23.12.11
a, b = input().strip().split(' ')
b = int(b)
# your code
print(a*b)
