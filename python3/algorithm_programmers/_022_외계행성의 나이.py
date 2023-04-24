"""
코딩테스트 연습> 코딩테스트 입문> 외계행성의 나이(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120834
문제 설명
  우주여행을 하던 머쓱이는 엔진 고장으로 PROGRAMMERS-962 행성에 불시착하게 됐습니다. 
  입국심사에서 나이를 말해야 하는데, PROGRAMMERS-962 행성에서는 나이를 알파벳으로 말하고 있습니다. 
  a는 0, b는 1, c는 2, ..., j는 9입니다. 예를 들어 23살은 cd, 51살은 fb로 표현합니다. 
  나이 age가 매개변수로 주어질 때 PROGRAMMER-962식 나이를 return하도록 solution 함수를 완성해주세요.
제한사항
  age는 자연수입니다.
  age ≤ 1,000
  PROGRAMMERS-962 행성은 알파벳 소문자만 사용합니다.
"""



# 23.04.24
# 숫자와 알파벳 리스트를 각각 만들어두고서는 이용은 인덱스를 이용하고있다.
# TypeError: list indices must be integers or slices, not str
# 에러가 떴었다. 인덱스에 넣은 i가 위에서 str를 했었기 때문에 안됐던 것이다. 
def solution(age):
    answer = ''
    from string import ascii_lowercase
    nl, al = [n for n in range(0, 10)], list(ascii_lowercase)
    
    age = list(str(age))
    
    for i in age:
        a = al[int(i)]
        answer = answer + a
    return answer
