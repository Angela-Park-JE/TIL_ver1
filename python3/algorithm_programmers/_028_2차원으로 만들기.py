"""
코딩테스트 연습> 코딩테스트 입문> 2차원으로 만들기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120842
문제 설명
  정수 배열 num_list와 정수 n이 매개변수로 주어집니다. num_list를 다음 설명과 같이 2차원 배열로 바꿔 return하도록 solution 함수를 완성해주세요.
  num_list가 [1, 2, 3, 4, 5, 6, 7, 8] 로 길이가 8이고 n이 2이므로 num_list를 2 * 4 배열로 다음과 같이 변경합니다. 
  2차원으로 바꿀 때에는 num_list의 원소들을 앞에서부터 n개씩 나눠 2차원 배열로 변경합니다.
    num_list	                    n	    result
    [1, 2, 3, 4, 5, 6, 7, 8]    	2	    [[1, 2], [3, 4], [5, 6], [7, 8]]
제한사항
  num_list의 길이는 n의 배 수개입니다.
  0 ≤ num_list의 길이 ≤ 150
  2 ≤ n < num_list의 길이
"""


# 23.04.30
# 먼저 num_list를 인덱스를 활용할 생각으로, 인덱스를 n씩 나눌 계획으로 range(0부터 배열 길이-1 까지, n씩 증가하는) 만들어서,
# 벡터를 n 만큼씩 반복하며 num_list에서 가져와 만들고, 그 벡터를 answer에 넣어버린다.
def solution(num_list, n):
    answer = []
    
    for i in range(0, len(num_list)-1, n):
        v = [num_list[i+x] for x in range(n)]
        answer.append(v)
    
    return answer



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120842/solution_groups?language=python3

# 김재희 , Jessie , 이종혁 , bigtrader91 외 391 명
# 엥 맞네 그냥 리스트 슬라이싱 해와도 되네요. 바보였다 나는!
def solution(num_list, n):
    answer = []
    for i in range(0, len(num_list), n):
        answer.append(num_list[i:i+n])
    return answer

# Sehyeon Jeong , geppetto , miori , may74709699@gmail.com 외 94 명
# 인덱싱은 앞에서 하고, 반복을 리스트 안에서 돌게 만든... 대단하군
def solution(num_list, n):
    return [num_list[ix-n:ix] for ix in range(n, len(num_list)+1, n)]

# 김종도 , 김정훈 , posky , kti0940 외 16 명
# 넘파이를 활용해도 된다. 후음. 하지만 이건... ㅎㅅㅎ
import numpy as np
def solution(num_list, n):
    return np.array(num_list).reshape(-1, n).tolist()
