"""
코딩테스트 연습> 코딩테스트 입문> 최빈값 구하기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120812#
문제 설명
  최빈값은 주어진 값 중에서 가장 자주 나오는 값을 의미합니다. 정수 배열 array가 매개변수로 주어질 때, 최빈값을 return 하도록 solution 함수를 완성해보세요. 최빈값이 여러 개면 -1을 return 합니다.
제한사항
  0 < array의 길이 < 100
  0 ≤ array의 원소 < 1000
"""


# 23.04.18
# '최빈값'을 구하라니까, '최빈값'의 빈도수를 뱉고있었다. (max(cnts)) 바보였다. (처음 문제 접했을 떄 썼던 코드는 오답노트로 올릴 필요도 없다.)
# 웃긴건 그렇게 구해놨는데 테스트 케이스가 다 통과가 되었었음... 3이 3개있고 그랬다고 함... 일부러 테스트 케이스 그렇게 둔게 아닐까 합리적 의심이 들정도로!

# 1. array를 list(set()) 해서 unique 값들로 만들어둔다. (물론 dictionary를 이용하는 방법도 있을 것이라 생각이 드는데, 나중에 심심할 때 바꿔봐야 겠다.)
# 2. 각 unique 값들이 알아서 정렬되어 있으므로, 각각의 빈도수가 리스트로 만들어지도록 list comprehension을 사용.
# 3. 만약 카운트들 중 가장 큰 값을 카운트들에서 셌을 때 1개 초과이면 (빈도수 자체만 비교하면 되니 최빈도수가 1이 아니면으로 간단히 세버렸음) -1을 반환
# 4. 만약 최빈도수가 1개로 유일하면 최빈도수로 cnts에서 인덱스를 찾은 값을 tmp 인덱스로 넣어서 찾아버림.
def solution(array):
    answer = 0
    tmp = list(set(array))
    cnts = [array.count(i) for i in tmp]
    
    if cnts.count(max(cnts)) != 1:
        answer = -1
    else:
        answer = tmp[cnts.index(max(cnts))]
    
    return answer
