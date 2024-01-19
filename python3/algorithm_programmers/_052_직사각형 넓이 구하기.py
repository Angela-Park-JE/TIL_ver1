"""
코딩테스트 연습> 코딩테스트 입문> 직사각형 넓이 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/120860?language=python3
문제 설명
    2차원 좌표 평면에 변이 축과 평행한 직사각형이 있습니다. 
    직사각형 네 꼭짓점의 좌표 [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]가 담겨있는 배열 dots가 매개변수로 주어질 때, 직사각형의 넓이를 return 하도록 solution 함수를 완성해보세요.
제한사항
    dots의 길이 = 4
    dots의 원소의 길이 = 2
    -256 < dots[i]의 원소 < 256
    잘못된 입력은 주어지지 않습니다.
"""


# 240119: 처음에는 축과 평행하다는 말을 제대로 읽지않고 풀려고 하다가 조금 헤맸다. 
# 아무튼 풀고나서 보니 max min을 사용하면 될것을 sort()치고 인덱스치고 있었던 것이다.
def solution(dots):
    dots.sort()
    answer = (dots[-1][0]-dots[0][0])*(dots[-1][1]-dots[0][1])
    return answer

# 프로그래머스에 가장 많은 사람들이 upvote한 풀이
def solution(dots):
    return (max(dots)[0] - min(dots)[0])*(max(dots)[1] - min(dots)[1]) # 결국 거기서 거기인 이야기

# 이거는 헤맴에서 바로나오자마자 짠 것이었는데 왜 이렇게 했는지 나도 모르겠다. 부끄러움 박제!
def solution(dots):
    nums = []
    for i in dots:
        for j in i:
            nums.append(j)
    nums = sorted(list(set(nums)))
    if len(nums) == 2:
        answer = (nums[1]-nums[0])*(nums[1]-nums[0]) # 두 점이 같은 수로 된 경우
    elif len(nums) == 3:
        answer = (nums[1]-nums(0))*(nums[2]-nums[0]) # 한 점이 같은 수로 된 경우
    else:
        answer = (nums[3]-nums[1])*(nums[2]-nums[0]) # 완전히 틀린 부분! x랑 y는 따로야!
return answer
