# 코딩테스트 연습> 코딩테스트 입문> n의 배수 고르기
# https://school.programmers.co.kr/learn/courses/30/lessons/120905
#   정수 n과 정수 배열 numlist가 매개변수로 주어질 때, numlist에서 n의 배수가 아닌 수들을 제거한 배열을 return하도록 solution 함수를 완성해주세요.


# 24.07.21:
def solution(n, numlist):
    answer = [i for i in numlist if i%n ==0]
    return answer



# 코딩테스트 연습> 코딩테스트 입문> 숫자 찾기
# https://school.programmers.co.kr/learn/courses/30/lessons/120904
#   정수 num과 k가 매개변수로 주어질 때, num을 이루는 숫자 중에 k가 있으면 num의 그 숫자가 있는 자리 수를 return하고 
#   없으면 -1을 return 하도록 solution 함수를 완성해보세요.


# 24.07.21: 다 도는 방식
def solution(num, k):
    answer = [i+1 for i in range(len(str(num))) if str(num)[i] == str(k)]
    if len(answer) == 0:
        return -1
    else:
        return min(answer)
