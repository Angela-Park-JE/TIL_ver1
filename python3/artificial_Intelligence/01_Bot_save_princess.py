""" 
22.12.07
Prepare> Artificial Intelligence> Bot Building> Bot saves princess
https://www.hackerrank.com/challenges/saveprincess/problem
Princess Peach is trapped in one of the four corners of a square grid. 
You are in the center of the grid and can move one step at a time in any of the four directions. Can you rescue the princess?
* Input format
The first line contains an odd integer N (3 <= N < 100) denoting the size of the grid. 
This is followed by an NxN grid. Each cell is denoted by '-' (ascii value: 45). 
The bot position is denoted by 'm' and the princess position is denoted by 'p'. Grid is indexed using Matrix Convention(https://www.hackerrank.com/scoring/board-convention).
* Output format
Print out the moves you will take to rescue the princess in one go. The moves must be separated by '\n', a newline. 
The valid moves are LEFT or RIGHT or UP or DOWN.

* Sample input

3
---
-m-
p--

* Sample output

DOWN
LEFT

"""


# 생각한대로 짜니 해결방식 자체는 문제가 없었으나 'DOWN'등의 프린트에서 문제가 생겨서 좀 헤맸다.
# 함수만 완성하면 되고, 나머지(m = int(input())...)는 건드리면 해결할 수 없다. 
# 위 아래, 그리고 왼쪽 오른쪽 각각 네 방향을 if elif if elif 식으로 나누어 썼을 때에는 개별 print()로 인해 위아래와 왼오 사이에 한 줄 줄바꿈이 생겨 문제가 있었으나,
# 각 방향에 의한 조합에 따라 네 케이스 중 하나의 print()만 실행되도록 바꾸었더니 잘 되었다.

#!/usr/bin/python
def displayPathtoPrincess(n, grid):
#print all the moves here
    for i in range(0, n):
        for j in range(0, n):
            if grid[i][j] == 'm':
                mx, my = i,j
    for i in [0, n-1]:
        for j in [0, n-1]:
            if grid[i][j] == 'p':
                px, py = i,j
    dx, dy = px - mx, py - my # d: 'distance'
    
    if (dx > 0) and (dy > 0):
        print('DOWN\n'*dx + 'RIGHT\n'*dy) 
    elif (dx > 0) and (dy <= 0):
        print('DOWN\n'*dx + 'LEFT\n'*abs(dy))
    elif (dx < 0) and (dy > 0):
        print('UP\n'*abs(dx) + 'RIGHT\n'*dy)
    else:
        print('UP\n'*abs(dx) + 'LEFT\n'*abs(dy))

m = int(input())
grid = [] 
for i in range(0, m): 
    grid.append(input().strip())
displayPathtoPrincess(m, grid)



"""현답들"""

# by. rahulchoudhary01 
# grid에서 바로 찾아서 수행한 경우. 봇은 항상 중앙에 위치함을 이용하여 실행시킨 문제이다. 
# 문제는 만약 봇이 중앙 자리에 없게 변형된다면 실행이 불가하다.
def displayPathtoPrincess(n,grid):
    if(grid[0][0]=="p"):
        for i in range(n//2):
            print("LEFT")
            print("UP")
    elif(grid[0][n-1]=="p"):
        for i in range(n//2):
            print("RIGHT")
            print("UP")
    elif(grid[n-1][0]=="p"):
        for i in range(n//2):
            print("LEFT")
            print("DOWN")
    else:
        for i in range(n//2):
            print("RIGHT")
            print("DOWN")



# by. etnicotinate 
# 주어진 grid를 펼친다음 거기서 me와 princess의 위치를 찾아서 거리를 구함. 
# 문제는 이 사람도 이 코드로는 n이 3 초과일 때 문제를 겪었을 것으로 생각된다. 
def displayPathtoPrincess(n,grid):
#print all the moves here
    for i,line in enumerate(grid):
        if line.find('m')>-1:
            me_pos=[line.find('m'),i]
        if line.find('p')>-1:
            prince_pos=[line.find('p'),i]
    x_move,y_move=[x-y for x,y in zip(prince_pos,me_pos)]
#    print(prince_pos,me_pos)
#    print(x_move,y_move)
    if y_move>0:
        print('DOWN'*y_move)
    else:
        print('UP'*(-y_move))
    if x_move>0:
        print('RIGHT'*x_move)
    else:
        print('LEFT'*(-x_move))
m = int(input())
grid = [] 
for i in range(0, m): 
    grid.append(input().strip())
displayPathtoPrincess(m,grid)
