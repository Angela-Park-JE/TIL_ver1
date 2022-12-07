""" 22.12.07
Prepare> Artificial Intelligence> Bot Building> Bot saves princess
https://www.hackerrank.com/challenges/saveprincess/problem
Princess Peach is trapped in one of the four corners of a square grid. 
You are in the center of the grid and can move one step at a time in any of the four directions. Can you rescue the princess?

* Input format
The first line contains an odd integer N (3 <= N < 100) denoting the size of the grid. 
This is followed by an NxN grid. Each cell is denoted by '-' (ascii value: 45). 
The bot position is denoted by 'm' and the princess position is denoted by 'p'. Grid is indexed using Matrix Convention

*Output format
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
# 함수만 완성하면 되고, 나머지는 건드리면 해결할 수 없다. 

#!/usr/bin/python
def displayPathtoPrincess(n, grid):
#print all the moves here
    size = n
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
