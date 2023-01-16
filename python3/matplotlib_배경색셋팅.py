"""
프로젝트를 하다가 모든 플롯의 배경색이 흰색으로 나타났으면 좋겠는데, 중간부터는 제대로 나타났다.
처음에는 sns.set_theme(style = 'whitegrid')때문인줄 알았지만, 처음부터 적용을 시켜놔도 적용되지 않았다. 
별다른 코드에 차이가 없었는데 왜 생겼을까 아무리 찾아도 답을 못얻다가,
여러 방법을 찾아본 결과 쓰기 좋은 두 가지가 있었다. 후자가 더 편함. 

배경이 없는 것이 용량에는 더 좋지만 어두운 배경으로 작업을 하다보니, 그리고 업로드 사이트마다 배경색이 다르다보니 가시성을 위해서라도 바꾸어야하기 때문에. 
"""


""" 1. plt.figure 를 객체로 저장한 후 해당 객체의 set_facecolor() 옵션으로 바꿔주는 방법. 간편하고, 다음에 plt.method()가 나와도 다 적용이 된다.
    문제는 프로젝트를 '수정' 중이었기 때문에 모든 셀마다 해당 그래프를 저장해주어야 한다는 불편함이 있었다. 
    plt.rcParams['figure.figsize'] = (6, 4) 으로 셀마다 지정해줬던 크기를 아래와 같이 변경시켰다. """

# 클래스별 레벨의 평균을 구하던 셀 전체 코드
fig = plt.figure(figsize = (6, 4))
fig.set_facecolor('white')
# plt.xticks(rotation = 90)
# plt.ylim(50, 100)
# df_hc_lev_mean = df_dead.groupby('class')[['level']].mean()
# sns.barplot(data = df_hc_lev_mean, x = df_hc_lev_mean.index, y = 'level')
# plt.show()



""" 2. plt.rcParams[] 로 고정해주는 방법. axis.facecolor 를 지정하면 그래프 외의 곳도 전부 지정 색상으로 바꿀 수 있다.
    plt.rcParams['savefig.facecolor']='white' 는 아직 이해하지 못함. 이것은 사용하지 않아도 배경이 나옴. 
    참조 : https://stackoverflow.com/questions/4804005/matplotlib-figure-facecolor-background-color """

# 캐릭터들의 레벨 histplot 을 그리는 셀 전체 코드 
# plt.rcParams["font.family"] = 'AppleGothic'
# plt.rcParams["font.size"] = 10
# plt.style.use("seaborn-whitegrid")

plt.rcParams['axes.facecolor']='white'
plt.rcParams['savefig.facecolor']='white' # 이것으론 배경 지정 못함 사용 안해도 됨

# plt.figure(figsize = (6, 4))
# sns.histplot(x = df_dead['level'], palette = 'Paired', kde = True)
# plt.title("level of dead characters in Hardcore mode")
# plt.show()
