# csv 등 불러올 때 인코딩 문제가 생길 때
# cp949 로 불러와보자. 

df = pd.read_csv('file.csv', encoding = 'cp949')
