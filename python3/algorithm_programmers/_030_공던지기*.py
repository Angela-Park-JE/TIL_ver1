"""
코딩테스트 연습> 코딩테스트 입문> 공 던지기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120843
문제 설명
  머쓱이는 친구들과 동그랗게 서서 공 던지기 게임을 하고 있습니다. 
  공은 1번부터 던지며 오른쪽으로 한 명을 건너뛰고 그다음 사람에게만 던질 수 있습니다. 
  친구들의 번호가 들어있는 정수 배열 numbers와 정수 K가 주어질 때, k번째로 공을 던지는 사람의 번호는 무엇인지 return 하도록 solution 함수를 완성해보세요.

제한사항
  2 < numbers의 길이 < 100
  0 < k < 1,000
  numbers의 첫 번째와 마지막 번호는 실제로 바로 옆에 있습니다.
  numbers는 1부터 시작하며 번호는 순서대로 올라갑니다.
"""



# 23.05.01
# 던지는 애들은 한정되거나, 순서가 정해져있다는 점을 이용했다. 길이가 짝수일 경우 홀수번 친구만 던지고, 길이가 홀수일 경우 홀수번 친구가 다 던진 후 짝수번 친구가 던지게 된다. 
# 던지는 순서를 먼저 정했다.
# 그 다름 실제 그 횟수를 던지는 애들에서 찾았다. k번이니까 k번 안에서 len을 돌고 찾으면, 제로부터 시작하니까 -1로 빼주었다.
# 나는 멀었다...
def solution(numbers, k):
    # 던지는 순서
    if len(numbers) %2 == 0:
        nums = [s for s in numbers if s%2 != 0]
    else:
        nums = [s for s in numbers if s%2 != 0] + [s for s in numbers if s%2 == 0]
    # 실제 횟수에 맞는 사람 찾기
    p = nums[k%len(nums)-1]
    return p



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120843/solution_groups?language=python3

# 김종도 , 이종혁 , gusjo , 조창범 외 321 명
# 그렇게 찾을 수 있구나... 싶었던 거지...
def solution(numbers, k):
    return numbers[2 * (k - 1) % len(numbers)]

# Demi
# 찾는 건 위와 같은데, numbers를 k만큼 늘린 것에서 찾는 점이 다르다.
def solution(numbers, num_toss):
    numbers *= num_toss
    return numbers[num_toss*2 - 2]



"""오답노트"""

# 원래는 건너받기 때문에 2씩 더해서 찾으려 했으나 길게 연속된 리스트를 짜야하는 상황에 이르른 것이다. 
# 물론 여기서도 몫을 활용해 인덱스로 넣을 순 있었으나, 중간에 생각난 방법이 던지는 애들은 한정되거나, 순서가 정해져있다는 것을 이용하기로 결심했다.
# def solution(numbers, k):
#     f, t = 0, 0
#     for i in range(1, k+1):
#         f = numbers[i-1]
#         t = numbers[numbers.index(f)+2]
#     return f, t
