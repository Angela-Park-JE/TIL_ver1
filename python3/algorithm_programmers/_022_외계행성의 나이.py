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
  
"""
테스트 1 〉	통과 (0.65ms, 10.4MB)
테스트 2 〉	통과 (47.23ms, 10.4MB)
테스트 3 〉	통과 (0.70ms, 10.6MB)
테스트 4 〉	통과 (1.05ms, 10.4MB)
테스트 5 〉	통과 (0.71ms, 10.5MB)
테스트 6 〉	통과 (1.05ms, 10.4MB)
"""


# 딕셔너리로 바꾼 형태이다. 확실히 전체적으로 속도가 빠르다.
def solution(age):
    answer = ''
    from string import ascii_lowercase
    dicts = dict(zip([n for n in range(0, 10)], list(ascii_lowercase)[:10]))
    for i in list(str(age)):
        answer = answer + dicts[int(i)]
    return answer

"""
테스트 1 〉	통과 (0.70ms, 10.4MB)
테스트 2 〉	통과 (0.67ms, 10.4MB)
테스트 3 〉	통과 (0.65ms, 10.4MB)
테스트 4 〉	통과 (0.66ms, 10.4MB)
테스트 5 〉	통과 (1.14ms, 10.4MB)
테스트 6 〉	통과 (0.69ms, 10.5MB)
"""



"""다른 풀이"""

# by. 봉글봉글 , 서병일 , 김진영 , le2dy 외 66 명
# age에서 가져온 숫자로 알파벳을 가져온다. 유니코드를 활용한 코드. 
def solution(age):

    return ''.join([chr(int(i)+97) for i in str(age)])


# by. Sehyeon Jeong
# string과 함께했지만 훨씬 깔끔하게, 딕셔너리 없이 map과 람다로 해결했다. 와.
import string

def solution(age):
    return "".join(map(lambda v: string.ascii_lowercase[int(v)], str(age)))


# by.김종도
# 훨씬 간단하게 딕셔너리를 만들고, 리스트 컴프리헨션 안에 for를 넣은뒤 바로 join으로 답을 내놓는 이상적인 답안이다.
# 게다가 string 라이브러리 없이, ord()라는 함수를 이용하여 'a'부터 시작하는 알파벳 리스트를 만들었다... 대단
def solution(age):
    answer = ''
    char_num = {str(i): chr(ord('a') + i) for i in range(26)}
    return ''.join([char_num[x] for x in str(age)])
