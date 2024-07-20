# 코딩테스트 연습> 코딩테스트 입문> 잘라서 배열로 저장하기
# 문자열 my_str과 n이 매개변수로 주어질 때, my_str을 길이 n씩 잘라서 저장한 배열을 return하도록 solution 함수를 완성해주세요.
# https://school.programmers.co.kr/learn/courses/30/lessons/120913


# 24.07.15:
def solution(my_str, n):
    answer = []
    while 1 <= len(my_str)//n:  # 몫이 1보다 작게되면(n이 남은 길이보다 길 경우) 종료한다.
        c = my_str[:n]
        answer.append(c)
        my_str = my_str[n:]
    answer.append(my_str)       # 몫이 1보다 작은 경우 마지막 것을 더한다.
    if answer[-1] == '': answer = answer[:-1]  # 나누어 떨어지는 경우 마지막 빈 것이 더해지므로 제거한다.
    return answer



### 다른 풀이 ###
# https://school.programmers.co.kr/learn/courses/30/lessons/120913/solution_groups?language=python3
# 처음에 더해가는 식으로 잘라내고 싶었는데 마음처럼 잘 짜지지가 않았다. 이렇게 하면 되는구나...
def solution(my_str, n):
    return [my_str[i: i + n] for i in range(0, len(my_str), n)]
# 위를 풀어쓰면 이런식이 된다.
def solution(my_str, n):
    answer = []
    for i in range(0, len(my_str), n):
        answer.append(my_str[i:i+n])
    return answer
