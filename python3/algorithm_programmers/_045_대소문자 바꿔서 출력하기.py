"""
코딩테스트 연습> 코딩 기초 트레이닝> 대소문자 바꿔서 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/181949
문제 설명
  영어 알파벳으로 이루어진 문자열 str이 주어집니다. 각 알파벳을 대문자는 소문자로 소문자는 대문자로 변환해서 출력하는 코드를 작성해 보세요.
제한사항
  1 ≤ str의 길이 ≤ 20
  str은 알파벳으로 이루어진 문자열입니다.
입출력 예
  입력 #1
  aBcDeFg
  출력 #1
  AbCdEfG
"""



# 23.12.12: 일일히 문자 하나하나를 검토하는 것이라 좋은 성능인지는 모르겠으나 한 번에 바꾸는 방법이 또 있을까도 싶다
str = input()
s = ''
for i in str:
    if i.upper() == i:
        s = s+i.lower()
    elif i.upper() != i:
        s = s+i.upper()
print(s)
