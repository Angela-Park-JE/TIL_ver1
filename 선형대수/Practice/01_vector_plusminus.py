# 벡터의 덧셈

# 로직
u = [1, 2, 3]
v = [4, 5, 6]

n = len(u)
w = []

for i in range(0, n):
  val = u[i] + v[i]
  w.append(val)
  
# >>> print(w)
# [5, 7, 9]
  
# 이를 함수로 만든다면

def v_add(u, v):
  n = len(u)
  w = []

  for i in range(0, n):
    val = u[i] + v[i]
    w.append(val)
  
  return w




# 벡터의 뺄셈

u = [5, 7, 9]
v = [2, 5, 8]

n = len(u)
w = []

for i in range(0, n):
  val = u[i] - v[i]
  w.append(val)

# >>> print(w)
# [3, 2, 1]  
  
# 이를 함수로 만든다면

def v_add(u, v):
  n = len(u)
  w = []

  for i in range(0, n):
    val = u[i] - v[i]
    w.append(val)
  
  return w
