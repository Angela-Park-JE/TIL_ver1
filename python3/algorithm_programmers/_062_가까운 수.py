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



"""다른 풀이"""
#...
# youngcheon , DoubleDeltas , okanekudasai , 도규탁 외 51 명
solution=lambda a,n:sorted(a,key=lambda x:(abs(x-n),x))[0]

# sort를 사용할때 key를 정해줄 수 있는 것을 했었는데 까먹었다. 정렬기준을 만들어줄 수 있는건데.
#  pgstter , ccc , kti0940 , lisayang011@gmail.com 외 8 명
def solution(array, n):
    array.sort(key = lambda x : (abs(x-n), x-n))
    answer = array[0]
    return answer
# 이것도 마찬가지다. 같은 방식 다른 코드.
# 노력형범재
def solution(array, n):
    arr = {i:abs(n-i) for i in array}
    return sorted(arr.items(),key=lambda x: [x[1],x[0]])[0][0]

# 처음에 생각했던(그러나 구현?하지 못해서 쓰지 못한)방법!
# 봉글봉글 , 정승현 , purpleong1104@gmail.com , 강예빈 외 35 명
def solution(array, n):
    array.sort()
    temp = []

    for i in array :
        temp.append( abs(n-i) )

    return array[temp.index(min(temp))]



"""오답노트"""
def solution(array, n):
    # 절댓값으로 차이 걸러서 찾으려고 한것... 위의 시간을 줄인다고 생각했지만 이걸로 주변 값 비교 후 반환하는게 나을지도 모른다.
    array.sort()
    ar1 = [i-n for i in sorted(array)]
    answer = array[ar1.index(min([abs(i) for i in ar1]))]
    return answer
