"""
코딩테스트 연습> 코딩테스트 입문> 가까운 수
문제 설명
  정수 배열 array와 정수 n이 매개변수로 주어질 때, array에 들어있는 정수 중 n과 가장 가까운 수를 return 하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ array의 길이 ≤ 100
  1 ≤ array의 원소 ≤ 100
  1 ≤ n ≤ 100
  가장 가까운 수가 여러 개일 경우 더 작은 수를 return 합니다.
"""



# 24.02.17
def solution(array, n):
    # array에 n을 넣고 찾기
    array.append(n)
    array.sort()
    # n이 가장 작은/큰 수의 경우 가장 가까운 값
    if array.index(n) == 0:
        return array[1]
    elif array.index(n) == len(array)-1:
        return array[-2]
    else:
        # 주변의 값들로 비교 후 반환
        neighbours = [array[array.index(n)-1], array[array.index(n)+1]]
        s = [abs(i-n) for i in neighbours]
        if s[0] == s[1]:
            return neighbours[0]
        else:
            return neighbours[s.index(min(s))]



"""오답노트"""

def solution(array, n):
    # 절댓값으로 차이 걸러서 찾으려고 한것... 위의 시간을 줄인다고 생각했지만 이걸로 주변 값 비교 후 반환하는게 나을지도 모른다.
    array.sort()
    ar1 = [i-n for i in sorted(array)]
    answer = array[ar1.index(min([abs(i) for i in ar1]))]
    return answer
