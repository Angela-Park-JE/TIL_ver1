# 벡터의 덧셈

# 로직
u = [1, 2, 3]
v = [4, 5, 6]

n = len(u)
w = []

for i in range(0, n):
  val = u[i] + v[i]
  w.append(val)
  
# 이를 함수로 만든다면

def v_add(u, v):
  n = len(u)
  w = []

  for i in range(0, n):
    val = u[i] + v[i]
    w.append(val)
  
  return w
