"""
코딩테스트 연습> 연습문제> 추억 점수
https://school.programmers.co.kr/learn/courses/30/lessons/176963
문제 설명
  사진들을 보며 추억에 젖어 있던 루는 사진별로 추억 점수를 매길려고 합니다. 사진 속에 나오는 인물의 그리움 점수를 모두 합산한 값이 해당 사진의 추억 점수가 됩니다. 
  예를 들어 사진 속 인물의 이름이 ["may", "kein", "kain"]이고 각 인물의 그리움 점수가 [5점, 10점, 1점]일 때 해당 사진의 추억 점수는 16(5 + 10 + 1)점이 됩니다. 
  다른 사진 속 인물의 이름이 ["kali", "mari", "don", "tony"]이고 ["kali", "mari", "don"]의 그리움 점수가 각각 [11점, 1점, 55점]]이고, "tony"는 그리움 점수가 없을 때, 이 사진의 추억 점수는 3명의 그리움 점수를 합한 67(11 + 1 + 55)점입니다.
  그리워하는 사람의 이름을 담은 문자열 배열 name, 각 사람별 그리움 점수를 담은 정수 배열 yearning, 
  각 사진에 찍힌 인물의 이름을 담은 이차원 문자열 배열 photo가 매개변수로 주어질 때, 사진들의 추억 점수를 photo에 주어진 순서대로 배열에 담아 return하는 solution 함수를 완성해주세요.

제한사항
  3 ≤ name의 길이 = yearning의 길이≤ 100
  3 ≤ name의 원소의 길이 ≤ 7
  name의 원소들은 알파벳 소문자로만 이루어져 있습니다.
  name에는 중복된 값이 들어가지 않습니다.
  1 ≤ yearning[i] ≤ 100
  yearning[i]는 i번째 사람의 그리움 점수입니다.
  3 ≤ photo의 길이 ≤ 100
  1 ≤ photo[i]의 길이 ≤ 100
  3 ≤ photo[i]의 원소(문자열)의 길이 ≤ 7
  photo[i]의 원소들은 알파벳 소문자로만 이루어져 있습니다.
  photo[i]의 원소들은 중복된 값이 들어가지 않습니다.
"""


# 이름이 name에 없는 사람들도 있다는 것을 생각해야함!
# 딕셔너리로 만들어두고 v를 더하고, 해당 v를 answer 리스트에 넣어둔다.

def solution(name, yearning, photo):
    answer = []
    name_dic = dict(zip(name, yearning))
    for pic in photo:
        v = 0
        for n in pic:
            if n in name:
                v += name_dic[n]
            else:
                pass
        answer.append(v)
    return answer

  
"""다른 풀이"""

# 원리 자체는 같으나 점수를 구해올 때 name의 인덱스와 점수의 인덱스가 같다는 점을 이용한다. 와 좋은 방법.
# by.이범원님 https://school.programmers.co.kr/questions/46880
def solution(name, yearning, photo):
    answer = []
    for peoples in photo:
        result = 0
        for people in peoples:
            if people in name:
                result += yearning[name.index(people)]
        answer.append(result)

    return answer
