# 코딩테스트 연습> 코딩테스트 입문> n의 배수 고르기
# https://school.programmers.co.kr/learn/courses/30/lessons/120905
#   정수 n과 정수 배열 numlist가 매개변수로 주어질 때, numlist에서 n의 배수가 아닌 수들을 제거한 배열을 return하도록 solution 함수를 완성해주세요.


# 24.07.21:
def solution(n, numlist):
    answer = [i for i in numlist if i%n ==0]
    return answer



# --------------------------------- #
# 코딩테스트 연습> 코딩테스트 입문> 숫자 찾기
# https://school.programmers.co.kr/learn/courses/30/lessons/120904
#   정수 num과 k가 매개변수로 주어질 때, num을 이루는 숫자 중에 k가 있으면 num의 그 숫자가 있는 자리 수를 return하고 
#   없으면 -1을 return 하도록 solution 함수를 완성해보세요.


# 24.07.25: 발견하면 바로 자리수 리턴 (best) 
# 만약 answer 로 따로 저장하지 않고 i+1이나 -1에 return을 사용하게 되면, 무조건 -1이 된다.
# 첫번째 자리에 k와 같은 수가 운좋게 있다면 1이 정상적으로 반환되지만 그렇지 않은 경우 else로 넘어가면서 바로 return을 실행해버리게 되기 때문이다.
def solution(num, k):
    for i in range(len(str(num))):
        if str(num)[i] == str(k):
            answer = i+1
            break
        else:
            answer = -1
    return answer

# 24.07.21: 다 도는 방식
def solution(num, k):
    answer = [i+1 for i in range(len(str(num))) if str(num)[i] == str(k)]
    if len(answer) == 0:
        return -1
    else:
        return min(answer)

# 24.07.25:
# 한 줄로 줄이는것 재미들려서 썼지만 결국 다 순회하는 방식이라 효용성은 없다. (다양하게 풀어보고 싶었을 뿐)
def solution(num, k):
    l = [i+1 if str(num)[i] == str(k) else -1 for i in range(len(str(num)))]
    if len(set(l)) == 1:  # -1뿐이라면 -1
        return -1
    else:
        while -1 in l:    # -1뿐이 아니라면 -1을 다 지우고 min(가장 처음 나타나는 자리 return)
            l.remove(-1)
        return min(l)



# 다른 풀이 #
# 출처 : https://school.programmers.co.kr/learn/courses/30/lessons/120904/solution_groups?language=python3 

# 최다 likes 받은 코드. 정말 깔끔하다. 기본적으로 k가 num에 없으면 -1을 반환하고, 있다면 find로 index를 찾아 +1 한다.
# find를 썼을 때 가장 처음 나온 자리를 반환하기 때문인 것 같다.
def solution(num, k):
    return -1 if str(k) not in str(num) else str(num).find(str(k)) + 1
  
# 그 다음으로 likes가 높은 코드. i는 index, n은 해당 value로 깔끔하게 비교하면서 지나갈 수 있다.
def solution(num, k):
    for i, n in enumerate(str(num)):
        if str(k) == n:
            return i + 1
    return -1

# 이런 코드도 있다. k의 index를 추출하도록 시도하되, k가 없어서 ValueError가 뜨는 경우에 대해 -1을 출력하도록 한다.
def solution(num, k):
    try:
        return str(num).index(str(k)) + 1
    except ValueError:
        return -1
