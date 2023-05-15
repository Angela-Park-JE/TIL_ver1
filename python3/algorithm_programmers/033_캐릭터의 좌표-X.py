"""
코딩테스트 연습> 코딩테스트 입문> 캐릭터의 좌표
https://school.programmers.co.kr/learn/courses/30/lessons/120861
문제 설명
  머쓱이는 RPG게임을 하고 있습니다. 게임에는 up, down, left, right 방향키가 있으며 각 키를 누르면 위, 아래, 왼쪽, 오른쪽으로 한 칸씩 이동합니다. 
  예를 들어 [0,0]에서 up을 누른다면 캐릭터의 좌표는 [0, 1], down을 누른다면 [0, -1], left를 누른다면 [-1, 0], right를 누른다면 [1, 0]입니다. 
  머쓱이가 입력한 방향키의 배열 keyinput와 맵의 크기 board이 매개변수로 주어집니다. 
  캐릭터는 항상 [0,0]에서 시작할 때 키 입력이 모두 끝난 뒤에 캐릭터의 좌표 [x, y]를 return하도록 solution 함수를 완성해주세요.
    [0, 0]은 board의 정 중앙에 위치합니다. 예를 들어 board의 가로 크기가 9라면 캐릭터는 왼쪽으로 최대 [-4, 0]까지 오른쪽으로 최대 [4, 0]까지 이동할 수 있습니다.
제한사항
  board은 [가로 크기, 세로 크기] 형태로 주어집니다.
  board의 가로 크기와 세로 크기는 홀수입니다.
  board의 크기를 벗어난 방향키 입력은 무시합니다.
  0 ≤ keyinput의 길이 ≤ 50
  1 ≤ board[0] ≤ 99
  1 ≤ board[1] ≤ 99
  keyinput은 항상 up, down, left, right만 주어집니다.
"""





"""오답노트"""
# 23.05.03
# final로 zip에 묶으나 지금 보이는 식으로 묶으나 결과는 같다.
# 아마 범위를 벗어나는 지 아닌지 부터 검사해야하는데 그걸 안해서 그런 것 같다.
def solution(keyinput, board):
    meossg = [0, 0]
    board_range = [[j, j*(-1)] for j in [int((i-1)/2) for i in board]]
    
    direction_dic = {'up':[0,1], 'down':[0,-1], 'left':[-1,0], 'right':[1,0]}
    
    for d in keyinput:
        v = direction_dic[d]
        meossg = [i+j for i,j in zip(meossg, v)]
        
    signs = [1 if x>=0 else -1 for x in meossg]
#     final = [board_range[k][0] if abs(meossg[k])> abs(board_range[k][0]) else meossg[k] for k in range(2) ] 
    for p in range(2):
        if (meossg[p]>board_range[p][0])|(meossg[p]<board_range[p][1]):
            meossg[p] = board_range[p][0]
    
    return [i*j for i,j in zip(signs, meossg)]
