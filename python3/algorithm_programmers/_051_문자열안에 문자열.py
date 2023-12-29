"""
코딩테스트 연습> 코딩테스트 입문> 문자열안에 문자열
https://school.programmers.co.kr/learn/courses/30/lessons/120908
문제 설명
  문자열 str1, str2가 매개변수로 주어집니다. str1 안에 str2가 있다면 1을 없다면 2를 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ str1의 길이 ≤ 100
  1 ≤ str2의 길이 ≤ 100
  문자열은 알파벳 대문자, 소문자, 숫자로 구성되어 있습니다.
"""



# 23.12.29: 특별할 것 없는 문제이긴 한데 나의 뉴비스러운 코드가 너무나 귀엽기도 하고... 풀이가 너무 멋진 것이 있어 가져왔다.
def solution(str1, str2):
    if str2 in str1:
        answer = 1
    else:
        answer = 2
    return answer



# 기본이라면 이러하다
def solution(str1, str2):
    return 1 if str2 in str1 else 2
# 그런데 이걸 이렇게 만들어 버렸다: 김현우 , 탈퇴한 사용자
# 기본으로 1을 반환하지만, 없는 경우에는 int(True)를 더해버린다. 와 멋져...
def solution(str1, str2):
    return 1 + int(str2 not in str1)
