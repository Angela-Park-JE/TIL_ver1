"""
코딩테스트 연습> 코딩테스트 입문> k의 개수
https://school.programmers.co.kr/learn/courses/30/lessons/120887?language=python3
"""


# 24.05.24 : 처음에는 숫자 리스트를 만들어서 수를 세려했는데 11 은 1이 두 번 등장하는 것으로 세야 한다는 것이다.
    # answer = 0
    # num_list = [str(n) for n in range(i, j+1)]
    # char = str(k)
    # for num in num_list:
    #     if char in num:
    #         answer+=1
    #     else:
    #         continue
    # return answer

def solution(i, j, k):
    longnumber = ''
    for n in range(i, j+1):
        longnumber = longnumber + str(n)
    from collections import Counter
    cnt = Counter(longnumber)
    return cnt[f'{k}']
