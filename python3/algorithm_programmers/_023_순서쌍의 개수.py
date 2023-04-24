"""
코딩테스트 연습> 코딩테스트 입문> 순서쌍의 개수(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120836
문제 설명
  순서쌍이란 두 개의 숫자를 순서를 정하여 짝지어 나타낸 쌍으로 (a, b)로 표기합니다. 
  자연수 n이 매개변수로 주어질 때 두 숫자의 곱이 n인 자연수 순서쌍의 개수를 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ n ≤ 1,000,000
"""


# 23.04.24
# 더 좋은 방법은 klist를 반절 잘라놓고 iteration을 하는 것인데....
def solution(n):
    klist = [int(k) for k in range(1, n+1)]
    dlist = []
    for i in klist:
        if n%i == 0:
            d = (i, n//i)
            dlist.append(d)
    answer = len(dlist)
    return answer
"""
테스트 1 〉	통과 (0.00ms, 10MB)
테스트 2 〉	통과 (0.00ms, 10.1MB)
테스트 3 〉	통과 (14.45ms, 13.7MB)
테스트 4 〉	통과 (0.00ms, 10.1MB)
테스트 5 〉	통과 (14.94ms, 13.7MB)
테스트 6 〉	통과 (145.15ms, 48.7MB)
테스트 7 〉	통과 (0.01ms, 10.1MB)
테스트 8 〉	통과 (0.02ms, 9.96MB)
테스트 9 〉	통과 (143.70ms, 47.1MB)
테스트 10 〉	통과 (148.42ms, 48.5MB)
"""


# 이건 klist를 반절 자른 코드이다. 마지막으로는 (n,1) 이 없게 되므로 +1을 해준다.
# 크기가 클 수록 빨리 되었다. 하지만 메모리는 더 잡아 먹는 것을 볼 수 있었다.
def solution(n):
    klist = [int(k) for k in range(1, n+1)]
    dlist = []
    if len(klist) % 2 == 0:
        klist = klist[:int(n/2)]
    else:
        klist = klist[:int((n+1)/2-1)] # 한개일 경우 오류가 날 수 있음을 인지하고 수정했었던 부분.
    for i in klist:
        if n%i == 0:
            d = (i, n//i)
            dlist.append(d)
    answer = len(dlist) + 1 # +1 is (n,1) 
    return answer
"""
테스트 1 〉	통과 (0.01ms, 10.1MB)
테스트 2 〉	통과 (0.01ms, 10.2MB)
테스트 3 〉	통과 (12.33ms, 14.3MB)
테스트 4 〉	통과 (0.01ms, 10.2MB)
테스트 5 〉	통과 (12.75ms, 14.4MB)
테스트 6 〉	통과 (123.19ms, 52.4MB)
테스트 7 〉	통과 (0.01ms, 10.2MB)
테스트 8 〉	통과 (0.02ms, 10.3MB)
테스트 9 〉	통과 (123.01ms, 50.7MB)
테스트 10 〉	통과 (126.99ms, 52.3MB)
"""



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120836/solution_groups?language=python3

# by. ji , 전수민 , 김지호 , 앵두오빠 외 127 명
# 나는 바보였다. 사실 순서쌍을 다 구하란 소리가 아니라 순서쌍 개수만 구하면 되는 것이어서 카운트를 해도 되는데...
def solution(n):
    answer =0 
    for i in range(n):
        if n % (i+1) ==0:
            answer +=1
    return answer

# by. Demi , goobano , yuls12 , Park-hanna 외 36 명
# 내가 하고싶었던 것에 가장 가까운 유형. 리스트 안에서 if 문까지 모두 해결하는 것이다. 이건 좀 외워야 겠다.
def solution(n):
    return len([number for number in range(1, n+1) if n%number == 0])

# by. Sehyeon Jeong , 박범수 , 리지홍 , minseok08@gmail.com 외 9 명
# 이게 가장 좋아요를 많이 받았던 코드이다. 이해를 못하겠다. 나중에 보고 이해하고자 적어두는 코드.
def solution(n):
    return len(list(filter(lambda v: n % (v+1) == 0, range(n))))
