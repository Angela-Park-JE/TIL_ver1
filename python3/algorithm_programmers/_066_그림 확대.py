"""
코딩테스트 연습> 코딩 기초 트레이닝> 그림 확대
https://school.programmers.co.kr/learn/courses/30/lessons/181836
문제 설명
  직사각형 형태의 그림 파일이 있고, 이 그림 파일은 1 × 1 크기의 정사각형 크기의 픽셀로 이루어져 있습니다. 이 그림 파일을 나타낸 문자열 배열 picture과 정수 k가 매개변수로 주어질 때, 이 그림 파일을 가로 세로로 k배 늘린 그림 파일을 나타내도록 문자열 배열을 return 하는 solution 함수를 작성해 주세요.
제한사항
  1 ≤ picture의 길이 ≤ 20
  1 ≤ picture의 원소의 길이 ≤ 20
  모든 picture의 원소의 길이는 같습니다.
  picture의 원소는 '.'과 'x'로 이루어져 있습니다.
  1 ≤ k ≤ 10
"""



# 24.03.04: 
def solution(picture, k):
    # 방법1. 한글자를 두배로 replace하는 방법은 없나 생각했는데 어려웠다. ㅠㅠ
    # 방법2. 빈 문자열에 k배씩 한 것을 이어붙인다. 이어붙인걸 새 리스트에 넣고, 이를 세로로도 k만큼 늘리기 위해 k번 더한다.
    answer = []
    for i in picture:
        p = ''        # 한 줄당 새 p이다. 각 글자를 k번 곱한 것을 더하도록(잇도록) 
        for j in i:
            p = p+ j*k
        s = 0         # 세로로 k배 되도록 리스트레 k번 더한다.
        while s != k:
            answer.append(p)
            s += 1
    return answer



"""다른 풀이"""
# 원래 처음에 하고 싶었던 것인데, k번 되도록 range에 쓰고 각 요소가 k개 만큼되도록 replace를 한다...!
# 김종도 , 고은찬 , 김민지 , 성채아 외 3 명
def solution(picture, k):
    answer = []
    for i in range(len(picture)):
        for _ in range(k):
            answer.append(picture[i].replace('.', '.' * k).replace('x', 'x' * k))
    return answer

# 내가 한 방식과 비슷한 방식, 의외로 이 방식을 사용한 사람들이 많았다. '문자열도 바로 += 가 되었던가?!' 하는 점과 'for _ in range(k)'로 while 따위(?)를 바꿀 수 있는 점을 배운다.
# cpwoo , 김소영 , 최승준 , 김호준 외 2 명
def solution(picture, k):
    answer = []
    for p in picture:
        tmp = ""
        for i in p:
            tmp += i*k
        for _ in range(k):
            answer.append(tmp)
    return answer

# 어..? 싶은 코드. tmp 한줄에서 이미 글자를 k배로 늘이는 것이 끝나고 아래에서 길이를 늘인다
# youly92@gmail.com
def solution(picture, k):
    tmp =  ["".join ([_p*k for _p in p]) for p in picture]
    answer = [] 
    if k > 1 : 
        for t in tmp: 
            for i in range(1, k+1) : 
                answer.append(t) 
    else: 
        answer = tmp 

    return answer

# 미리 빈 그림판을 그려두고 거기에 요소를 k배씩 한 다음 마지막에 길이 늘리기.
# 설재영
def solution(picture, k):
    answer = ["" for i in range(len(picture))]
    answers = []
    for i, x in enumerate(picture) :
        for j in x :
            answer[i] += j * k
    for i in answer :
        for j in range(k) :
            answers.append(i)
    return answers

# 1. for 문을 한 줄로 쓸 수 있다고도 들었는데 이게 이렇게 되는건가 2. 한 줄을 뜯어 list로 만든 뒤 각요소를 k배 하고 join 한 다음 k배해서 그것을 answer에 넣는다...
# 이범원
def solution(picture, k):
    answer = []
    for v in [[''.join([c*k for c in list(p)])]*k for p in picture]: answer += v
    return answer
